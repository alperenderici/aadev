#!/usr/bin/env python3
"""Bake the rotations chosen in tool/rotate_review.html into the archive.

    python3 tool/apply_rotations.py ~/Downloads/rotations.json

For every frame listed in rotations.json this re-encodes both sizes from the
ORIGINAL scan rather than turning the WebP, so a rotated frame loses no quality
relative to one that was already upright.

Because the source is the original, the turn a frame already carries has to be
added to the new one — the review page shows the frame as it stands now, so a
second pass over the same frame means "turn it further", not "turn it this far
from the original". tool/film_rotations.json remembers each frame's total, and
this script keeps it up to date. Without that, a second pass would silently undo
the first. Run tool/rebuild_rotation_ledger.py if the file is ever lost.

Frames whose shape ends up different are moved between portrait and landscape in
film_rolls_data.dart.

Needs: pillow  ->  python3 -m pip install pillow
"""

import json
import os
import re
import sys

from PIL import Image

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
SOURCES = os.path.join(ROOT, "tool", "film_sources.json")
LEDGER = os.path.join(ROOT, "tool", "film_rotations.json")
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
    ledger = json.load(open(LEDGER, encoding="utf-8")) if os.path.exists(LEDGER) else {}
    src_root = sources["root"]

    if not os.path.isdir(src_root):
        sys.exit(
            f"kaynak tarama klasoru bulunamadi: {src_root}\n"
            f"tool/film_sources.json icindeki 'root' degerini guncelle."
        )

    shapes = {}   # slug -> {index: 'l' | 'p'} for frames to fix in the catalogue
    done = 0

    for slug, frames in rotations.items():
        roll = sources["rolls"].get(slug)
        if roll is None:
            print(f"!! bilinmeyen rulo, atlandi: {slug}")
            continue

        out_dir = os.path.join(ROOT, "web", "film", slug)

        for index_text, requested in frames.items():
            index = int(index_text)
            key = f"{slug}/{index}"
            already = int(ledger.get(key, 0))
            total = (already + int(requested)) % 360

            if index >= len(roll["files"]):
                print(f"!! {key}: rulodaki kare sayisini asiyor, atlandi")
                continue

            src = os.path.join(src_root, roll["folder"], roll["files"][index])
            if not os.path.exists(src):
                print(f"!! kaynak yok, atlandi: {src}")
                continue

            with Image.open(src) as image:
                image = image.convert("RGB")
                # PIL turns counter-clockwise; the review page records clockwise.
                turned = image.rotate(-total, expand=True) if total else image

                number = f"{index + 1:03d}"
                resized(turned, FULL_EDGE).save(
                    os.path.join(out_dir, "f", f"{number}.webp"),
                    "WEBP", quality=FULL_Q, method=4,
                )
                resized(turned, THUMB_EDGE).save(
                    os.path.join(out_dir, "t", f"{number}.webp"),
                    "WEBP", quality=THUMB_Q, method=4,
                )
                w, h = turned.size

            shapes.setdefault(slug, {})[index] = "l" if w >= h else "p"
            if total:
                ledger[key] = total
            else:
                ledger.pop(key, None)

            done += 1
            note = f" (onceki {already}° + {requested}°)" if already else ""
            print(f"  {key.replace('/', '/' )}  -> {total}°{note}")

    print(f"\n{done} kare yeniden uretildi")

    json.dump(ledger, open(LEDGER, "w", encoding="utf-8"), ensure_ascii=False, indent=1)

    if shapes:
        changed = update_orientations(shapes)
        print(f"{changed} karenin yönü film_rolls_data.dart icinde guncellendi")


def update_orientations(shapes):
    """Set the orientation character of every frame this run re-encoded."""
    dart = open(DART, encoding="utf-8").read()
    changed = 0

    for slug, frames in shapes.items():
        pattern = re.compile(
            r"(id: '" + re.escape(slug) + r"',.*?orientations: ')([lp]+)(')",
            re.S,
        )
        match = pattern.search(dart)
        if not match:
            print(f"!! film_rolls_data.dart icinde bulunamadi: {slug}")
            continue

        chars = list(match.group(2))
        for index, char in frames.items():
            if index < len(chars) and chars[index] != char:
                chars[index] = char
                changed += 1
        dart = dart[: match.start(2)] + "".join(chars) + dart[match.end(2):]

    open(DART, "w", encoding="utf-8").write(dart)
    return changed


if __name__ == "__main__":
    main()
