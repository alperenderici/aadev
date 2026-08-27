#!/usr/bin/env python3
"""Find frames that appear more than once in the archive.

    python3 tool/find_duplicates.py

The same negative often got scanned twice into different folders, at different
sizes and colour balance, so byte-identical matching finds almost none of them.
This compares a perceptual fingerprint (dHash) of every frame instead, which
survives rescaling, recompression and mild colour shifts.

A fingerprint alone is not enough: washed-out frames — hazy sunsets, blank
leader, fogged exposures — all fingerprint alike and chain into one huge false
group. So every candidate pair is confirmed against the actual pixels, and
frames with too little detail to fingerprint reliably are set aside for the eye
instead of being guessed at.

Writes tool/duplicates.json for tool/duplicates_review.html to display.
"""

import json
import os
import re
import subprocess
import tempfile

from PIL import Image

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DART = os.path.join(ROOT, "lib", "features", "film", "data", "film_rolls_data.dart")
OUT = os.path.join(ROOT, "tool", "duplicates.json")

HASH_DISTANCE = 10   # dHash bits that may differ for a pair to be worth checking
MAX_RMSE = 26.0      # per-channel pixel difference (0-255) allowed after confirming
MIN_DETAIL = 14.0    # frames flatter than this cannot be fingerprinted reliably
COMPARE = 32         # confirmation happens on a COMPARE x COMPARE thumbnail


def dhash(image, size=8):
    """64-bit fingerprint: which way the brightness steps between neighbours."""
    small = image.convert("L").resize((size + 1, size), Image.LANCZOS)
    pixels = list(small.getdata())
    bits = 0
    for row in range(size):
        base = row * (size + 1)
        for col in range(size):
            bits = (bits << 1) | (pixels[base + col] < pixels[base + col + 1])
    return bits


def signature(image):
    """Small RGB thumbnail used to confirm a fingerprint match against pixels."""
    return list(image.convert("RGB").resize((COMPARE, COMPARE), Image.LANCZOS).getdata())


def detail(image):
    """Standard deviation of brightness: how much there is to fingerprint."""
    small = image.convert("L").resize((COMPARE, COMPARE), Image.LANCZOS)
    pixels = list(small.getdata())
    mean = sum(pixels) / len(pixels)
    return (sum((p - mean) ** 2 for p in pixels) / len(pixels)) ** 0.5


def rmse(a, b):
    total = 0
    for (r1, g1, b1), (r2, g2, b2) in zip(a, b):
        total += (r1 - r2) ** 2 + (g1 - g2) ** 2 + (b1 - b2) ** 2
    return (total / (len(a) * 3)) ** 0.5


def rolls_from_dart():
    dart = open(DART, encoding="utf-8").read()
    out = []
    for block in dart.split("FilmRoll(")[1:]:
        out.append((
            re.search(r"id: '([^']+)'", block).group(1),
            re.search(r"title: '((?:[^'\\]|\\.)*)'", block).group(1),
            int(re.search(r"frameCount: (\d+)", block).group(1)),
        ))
    return out


def main():
    rolls = rolls_from_dart()
    titles = {slug: title for slug, title, _ in rolls}

    frames, faint = [], []
    tmp = tempfile.mkdtemp()
    png = os.path.join(tmp, "f.png")

    for slug, _title, count in rolls:
        for i in range(count):
            webp = os.path.join(ROOT, "web", "film", slug, "t", f"{i + 1:03d}.webp")
            subprocess.run(["dwebp", "-quiet", webp, "-o", png], check=True)
            with Image.open(png) as im:
                im.load()
                entry = (slug, i, dhash(im), signature(im))
                if detail(im) < MIN_DETAIL:
                    faint.append({"slug": slug, "index": i})
                else:
                    frames.append(entry)

    print(f"{len(frames) + len(faint)} kare okundu "
          f"({len(faint)} tanesi cok duz, elle bakilacak)")

    # Only pairs that pass both the fingerprint and the pixel check link up, so a
    # run of similar-looking frames cannot chain into one oversized group.
    parent = list(range(len(frames)))

    def find(a):
        while parent[a] != a:
            parent[a] = parent[parent[a]]
            a = parent[a]
        return a

    pairs = 0
    for a in range(len(frames)):
        for b in range(a + 1, len(frames)):
            if bin(frames[a][2] ^ frames[b][2]).count("1") > HASH_DISTANCE:
                continue
            if rmse(frames[a][3], frames[b][3]) > MAX_RMSE:
                continue
            ra, rb = find(a), find(b)
            if ra != rb:
                parent[rb] = ra
            pairs += 1

    groups = {}
    for i in range(len(frames)):
        groups.setdefault(find(i), []).append(i)

    result = []
    for members in groups.values():
        if len(members) < 2:
            continue
        result.append([
            {"slug": frames[i][0], "index": frames[i][1]} for i in sorted(members)
        ])
    result.sort(key=lambda g: (-len({f["slug"] for f in g}), -len(g)))

    # Rolls that overlap heavily are probably the same roll scanned twice; worth
    # seeing as a whole rather than frame by frame.
    overlap = {}
    for group in result:
        slugs = sorted({f["slug"] for f in group})
        for i, x in enumerate(slugs):
            for y in slugs[i + 1:]:
                overlap[(x, y)] = overlap.get((x, y), 0) + 1

    counts = {slug: count for slug, _t, count in rolls}
    roll_pairs = []
    for (x, y), shared in sorted(overlap.items(), key=lambda kv: -kv[1]):
        if shared < 3:
            continue
        roll_pairs.append({
            "a": x, "b": y, "shared": shared,
            "a_total": counts[x], "b_total": counts[y],
            "a_pct": round(100 * shared / counts[x]),
            "b_pct": round(100 * shared / counts[y]),
        })

    # Byte size of the full-size file is a rough stand-in for scan quality, so
    # the reviewer can tell which of two copies is the better scan.
    sizes = {}
    for slug, _t, count in rolls:
        for i in range(count):
            full = os.path.join(ROOT, "web", "film", slug, "f", f"{i + 1:03d}.webp")
            sizes[f"{slug}/{i}"] = os.path.getsize(full)

    json.dump({
        "groups": result,
        "sizes": sizes,
        "faint": faint,
        "roll_overlap": roll_pairs,
        "titles": titles,
    }, open(OUT, "w", encoding="utf-8"), ensure_ascii=False, indent=1)

    dupes = sum(len(g) - 1 for g in result)
    print(f"{len(result)} grup, {dupes} fazladan kopya")
    if roll_pairs:
        print("\nbirbiriyle ortusen rulolar:")
        for p in roll_pairs[:12]:
            print(f"  {p['a']:30} {p['b']:30} {p['shared']:3} ortak "
                  f"({p['a_pct']}% / {p['b_pct']}%)")
    print(f"\n-> {OUT}")


if __name__ == "__main__":
    main()
