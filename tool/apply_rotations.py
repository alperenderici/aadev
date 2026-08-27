#!/usr/bin/env python3
"""Bake the rotations chosen in tool/rotate_review.html into the archive.

    python3 tool/apply_rotations.py ~/Downloads/rotations.json

For every frame listed in rotations.json this re-encodes both sizes from the
ORIGINAL scan rather than turning the existing WebP, so a rotated frame loses no
quality relative to one that was already upright. It then rewrites the affected
`orientations` strings in film_rolls_data.dart, since a 90° turn swaps a frame
between portrait and landscape.

Needs: pillow  ->  python3 -m pip install pillow
"""

import json
import os
import re
import sys

from PIL import Image

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SOURCES = os.path.join(ROOT, "tool", "film_sources.json")
DART = os.path.join(ROOT, "lib", "features", "film", "data", "film_rolls_data.dart")

FULL_EDGE, FULL_Q = 1800, 78
THUMB_EDGE, THUMB_Q = 640, 62


def resized(image, long_edge):
    """Scale so the longest side is long_edge, keeping the aspect ratio."""
    w, h = image.size
    scale = long_edge / max(w, h)
    if scale >= 1:
        return image.copy()
    return image.resize((round(w * scale), round(h * scale)), Image.LANCZOS)


def main():
    if len(sys.argv) != 2:
        sys.exit("kullanim: python3 tool/apply_rotations.py <rotations.json>")

    rotations = json.load(open(sys.argv[1], encoding="utf-8"))
    sources = json.load(open(SOURCES, encoding="utf-8"))
    src_root = sources["root"]

    if not os.path.isdir(src_root):
        sys.exit(
            f"kaynak tarama klasoru bulunamadi: {src_root}\n"
            f"tool/film_sources.json icindeki 'root' degerini guncelle."
        )

    # slug -> {index: 'l' | 'p'} for the frames whose shape changed
    flipped = {}
    done = 0

    for slug, frames in rotations.items():
        roll = sources["rolls"].get(slug)
        if roll is None:
            print(f"!! bilinmeyen rulo, atlandi: {slug}")
            continue

        out_dir = os.path.join(ROOT, "web", "film", slug)

        for index_text, degrees in frames.items():
            index = int(index_text)
            degrees = int(degrees) % 360
            if degrees == 0:
                continue

            src = os.path.join(src_root, roll["folder"], roll["files"][index])
            if not os.path.exists(src):
                print(f"!! kaynak yok, atlandi: {src}")
                continue

            with Image.open(src) as image:
                image = image.convert("RGB")
                # PIL rotates counter-clockwise; the tool records clockwise.
                turned = image.rotate(-degrees, expand=True)

                number = f"{index + 1:03d}"
                resized(turned, FULL_EDGE).save(
                    os.path.join(out_dir, "f", f"{number}.webp"),
                    "WEBP", quality=FULL_Q, method=4,
                )
                resized(turned, THUMB_EDGE).save(
                    os.path.join(out_dir, "t", f"{number}.webp"),
                    "WEBP", quality=THUMB_Q, method=4,
                )

                if degrees in (90, 270):
                    w, h = turned.size
                    flipped.setdefault(slug, {})[index] = "l" if w >= h else "p"

            done += 1
            print(f"  {slug}/{index + 1:03d}  {degrees}°")

    print(f"\n{done} kare yeniden uretildi")

    if flipped:
        update_orientations(flipped)
        print(f"{sum(len(v) for v in flipped.values())} karenin yönü "
              f"film_rolls_data.dart icinde guncellendi")


def update_orientations(flipped):
    """Rewrite the orientations string of every roll whose frames changed shape."""
    dart = open(DART, encoding="utf-8").read()

    for slug, changes in flipped.items():
        pattern = re.compile(
            r"(id: '" + re.escape(slug) + r"',.*?orientations: ')([lp]+)(')",
            re.S,
        )
        match = pattern.search(dart)
        if not match:
            print(f"!! film_rolls_data.dart icinde bulunamadi: {slug}")
            continue

        chars = list(match.group(2))
        for index, char in changes.items():
            if index < len(chars):
                chars[index] = char
        dart = (
            dart[: match.start(2)] + "".join(chars) + dart[match.end(2) :]
        )

    open(DART, "w", encoding="utf-8").write(dart)


if __name__ == "__main__":
    main()
