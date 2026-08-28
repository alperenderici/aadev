#!/usr/bin/env python3
"""Work out how far each frame is already turned from its original scan.

    python3 tool/rebuild_rotation_ledger.py

apply_rotations.py re-encodes from the original scan, so it needs to know what
turn a frame is already carrying — otherwise a second pass over a frame replaces
the first pass instead of adding to it, and the frame springs back.

Nothing recorded that until now, so this recovers it by comparing each published
frame against all four turns of its original and keeping the closest match.
Writes tool/film_rotations.json, which apply_rotations.py maintains from then on.
"""

import json
import os
import re
import subprocess
import tempfile

from PIL import Image

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DART = os.path.join(ROOT, "lib", "features", "film", "data", "film_rolls_data.dart")
SOURCES = os.path.join(ROOT, "tool", "film_sources.json")
LEDGER = os.path.join(ROOT, "tool", "film_rotations.json")

COMPARE = 32   # both sides are squashed to this square before comparing


def signature(image):
    return list(image.convert("RGB").resize((COMPARE, COMPARE), Image.LANCZOS).getdata())


def distance(a, b):
    total = 0
    for (r1, g1, b1), (r2, g2, b2) in zip(a, b):
        total += (r1 - r2) ** 2 + (g1 - g2) ** 2 + (b1 - b2) ** 2
    return (total / (len(a) * 3)) ** 0.5


def main():
    dart = open(DART, encoding="utf-8").read()
    sources = json.load(open(SOURCES, encoding="utf-8"))
    src_root = sources["root"]
    if not os.path.isdir(src_root):
        raise SystemExit(f"kaynak tarama klasoru yok: {src_root}")

    ledger = {}
    ambiguous = []
    tmp = tempfile.mkdtemp()
    png = os.path.join(tmp, "cur.png")

    for block in dart.split("FilmRoll(")[1:]:
        slug = re.search(r"id: '([^']+)'", block).group(1)
        count = int(re.search(r"frameCount: (\d+)", block).group(1))
        roll = sources["rolls"][slug]

        for i in range(count):
            webp = os.path.join(ROOT, "web", "film", slug, "t", f"{i + 1:03d}.webp")
            subprocess.run(["dwebp", "-quiet", webp, "-o", png], check=True)
            with Image.open(png) as cur:
                cur.load()
                current = signature(cur)

            path = os.path.join(src_root, roll["folder"], roll["files"][i])
            with Image.open(path) as original:
                # Shrink first: turning a thumbnail is the same comparison as
                # turning a 10-megapixel scan, and thousands of frames go by.
                original.draft("RGB", (256, 256))
                small = original.convert("RGB")
                small.thumbnail((128, 128), Image.LANCZOS)

            scores = {deg: distance(current, signature(small.rotate(-deg, expand=True)))
                      for deg in (0, 90, 180, 270)}
            best = min(scores, key=scores.get)
            runner_up = min((d for d in scores if d != best), key=lambda d: scores[d])
            if scores[runner_up] - scores[best] < 4:
                ambiguous.append(f"{slug}/{i + 1:03d} ({best}° vs {runner_up}°)")
            if best:
                ledger[f"{slug}/{i}"] = best

    json.dump(ledger, open(LEDGER, "w", encoding="utf-8"), ensure_ascii=False, indent=1)

    turned = len(ledger)
    print(f"{turned} kare cevrilmis durumda kayda gecti -> {LEDGER}")
    if ambiguous:
        print(f"\n{len(ambiguous)} karede iki yon birbirine cok yakin "
              f"(simetrik/duz kareler; yanlissa elle duzelt):")
        for a in ambiguous[:15]:
            print("  " + a)


if __name__ == "__main__":
    main()
