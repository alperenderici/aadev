#!/usr/bin/env python3
"""Remove the frames marked in tool/duplicates_review.html.

    python3 tool/apply_deletions.py ~/Downloads/deletions.json [--dry-run]

Frames are numbered 001..N with no gaps, so deleting one means renumbering every
frame after it. This does that for both sizes on disk, and keeps the catalogue in
step: frameCount, the per-frame `orientations` string, and `coverIndex` all move
with the frames. tool/film_sources.json and tool/film_rotations.json are moved
along too, so a later rotation pass still points at the right original scan and
adds to the right accumulated turn.

A roll that loses every frame is dropped from the catalogue entirely.
"""

import json
import os
import re
import shutil
import sys

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DART = os.path.join(ROOT, "lib", "features", "film", "data", "film_rolls_data.dart")
SOURCES = os.path.join(ROOT, "tool", "film_sources.json")
LEDGER = os.path.join(ROOT, "tool", "film_rotations.json")
FILM = os.path.join(ROOT, "web", "film")


def roll_blocks(dart):
    """Split the data file into (prefix, [block, ...], suffix)."""
    parts = dart.split("    FilmRoll(")
    head = parts[0]
    blocks, tail = [], ""
    for i, part in enumerate(parts[1:]):
        if i == len(parts) - 2:
            body, _, tail = part.partition("    ),\n  ];")
            blocks.append(body + "    ),\n")
            tail = "  ];" + tail
        else:
            blocks.append(part)
    return head, blocks, tail


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    dry_run = "--dry-run" in sys.argv
    if len(args) != 1:
        sys.exit("kullanim: python3 tool/apply_deletions.py <deletions.json> [--dry-run]")

    deletions = {k: sorted(set(v)) for k, v in json.load(open(args[0], encoding="utf-8")).items()}
    if not deletions:
        sys.exit("silinecek kare yok")

    dart = open(DART, encoding="utf-8").read()
    sources = json.load(open(SOURCES, encoding="utf-8"))
    ledger = json.load(open(LEDGER, encoding="utf-8")) if os.path.exists(LEDGER) else {}
    head, blocks, tail = roll_blocks(dart)

    total_removed = 0
    dropped_rolls = []
    new_blocks = []

    for block in blocks:
        slug = re.search(r"id: '([^']+)'", block).group(1)
        count = int(re.search(r"frameCount: (\d+)", block).group(1))
        remove = [i for i in deletions.get(slug, []) if 0 <= i < count]

        if not remove:
            new_blocks.append(block)
            continue

        keep = [i for i in range(count) if i not in set(remove)]
        total_removed += len(remove)

        if not keep:
            dropped_rolls.append(slug)
            if not dry_run:
                shutil.rmtree(os.path.join(FILM, slug), ignore_errors=True)
                sources["rolls"].pop(slug, None)
                drop_from_ledger(ledger, slug)
            continue

        if not dry_run:
            renumber(slug, keep)
            files = sources["rolls"][slug]["files"]
            sources["rolls"][slug]["files"] = [files[i] for i in keep]
            remap_ledger(ledger, slug, keep)

        new_blocks.append(rewrite_block(block, keep, count))
        print(f"  {slug}: {len(remove)} silindi, {len(keep)} kaldi")

    if dropped_rolls:
        print("  tamamen kaldirilan rulo: " + ", ".join(dropped_rolls))

    if dry_run:
        print(f"\n[dry-run] {total_removed} kare silinecekti")
        return

    open(DART, "w", encoding="utf-8").write(head + "    FilmRoll(".join([""] + new_blocks).lstrip("\n") + tail)
    json.dump(sources, open(SOURCES, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
    json.dump(ledger, open(LEDGER, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
    print(f"\n{total_removed} kare silindi, kalan kareler yeniden numaralandi")


def drop_from_ledger(ledger, slug):
    """Forget the accumulated turns of a roll that no longer exists."""
    for key in [k for k in ledger if k.startswith(f"{slug}/")]:
        del ledger[key]


def remap_ledger(ledger, slug, keep):
    """Move each surviving frame's accumulated turn to its new number.

    The ledger is keyed by frame index, so a deletion shifts every entry after
    it. Left alone, a later rotation pass would add its turn to some other
    frame's total and quietly mis-rotate both.
    """
    moved = {}
    for new_index, old_index in enumerate(keep):
        degrees = ledger.get(f"{slug}/{old_index}")
        if degrees:
            moved[f"{slug}/{new_index}"] = degrees
    drop_from_ledger(ledger, slug)
    ledger.update(moved)


def renumber(slug, keep):
    """Rewrite <slug>/f and <slug>/t as a gapless 001..len(keep) run."""
    for size in ("f", "t"):
        directory = os.path.join(FILM, slug, size)
        staged = os.path.join(directory, "__yeni__")
        os.makedirs(staged, exist_ok=True)
        for new_index, old_index in enumerate(keep):
            shutil.move(
                os.path.join(directory, f"{old_index + 1:03d}.webp"),
                os.path.join(staged, f"{new_index + 1:03d}.webp"),
            )
        for leftover in os.listdir(directory):
            path = os.path.join(directory, leftover)
            if os.path.isfile(path):
                os.remove(path)
        for name in os.listdir(staged):
            shutil.move(os.path.join(staged, name), os.path.join(directory, name))
        os.rmdir(staged)


def rewrite_block(block, keep, old_count):
    """Bring frameCount, orientations and coverIndex in line with the kept frames."""
    orientations = re.search(r"orientations: '([lp]+)'", block).group(1)
    kept_orientations = "".join(orientations[i] for i in keep)

    block = re.sub(r"frameCount: \d+", f"frameCount: {len(keep)}", block)
    block = re.sub(r"orientations: '[lp]+'", f"orientations: '{kept_orientations}'", block)

    cover = re.search(r"coverIndex: (\d+)", block)
    old_cover = int(cover.group(1)) if cover else 0
    # Follow the cover frame to its new number; if it was deleted, fall back to
    # the first surviving frame rather than pointing at nothing.
    new_cover = keep.index(old_cover) if old_cover in keep else 0
    if cover:
        block = (re.sub(r"coverIndex: \d+", f"coverIndex: {new_cover}", block)
                 if new_cover else re.sub(r"\s*coverIndex: \d+,", "", block))
    elif new_cover:
        block = block.replace("      // kaynak klasör",
                              f"      coverIndex: {new_cover},\n      // kaynak klasör")
    return block


if __name__ == "__main__":
    main()
