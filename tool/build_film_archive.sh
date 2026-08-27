#!/bin/bash
#
# Yeni bir film rulosunu web/film/ altina hazirlar.
#
#   tool/build_film_archive.sh <tarama-klasoru> <rulo-id>
#
# Ornek:
#   tool/build_film_archive.sh ~/Downloads/35mm/portra-2026 portra-2026
#
# Klasordeki JPEG taramalari dosya adina gore siralar, 001'den baslayarak
# numaralandirir ve iki boy uretir:
#
#   web/film/<rulo-id>/f/NNN.webp   uzun kenar 1800px, kalite 78
#   web/film/<rulo-id>/t/NNN.webp   uzun kenar  640px, kalite 62
#
# Cikti olarak lib/features/film/data/film_rolls_data.dart icine yapistirilacak
# FilmRoll blogunu basar; kunye alanlarini (makine, tarih, yikama) elle doldur.
#
# Gereksinim: cwebp  ->  brew install webp

set -euo pipefail

if [ $# -ne 2 ]; then
  echo "kullanim: $0 <tarama-klasoru> <rulo-id>" >&2
  exit 1
fi

SRC="$1"
SLUG="$2"
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
OUT="$ROOT/web/film/$SLUG"

FULL_EDGE=1800
FULL_Q=78
THUMB_EDGE=640
THUMB_Q=62

command -v cwebp >/dev/null || { echo "cwebp bulunamadi: brew install webp" >&2; exit 1; }
[ -d "$SRC" ] || { echo "klasor yok: $SRC" >&2; exit 1; }

mkdir -p "$OUT/f" "$OUT/t"

files=()
while IFS= read -r f; do files+=("$f"); done < <(
  find "$SRC" -maxdepth 1 -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.tif' -o -iname '*.tiff' -o -iname '*.png' \) \
    -not -name '._*' -print | sort -V
)

[ ${#files[@]} -gt 0 ] || { echo "klasorde taranacak gorsel yok: $SRC" >&2; exit 1; }

idx=0
orientations=""
for f in "${files[@]}"; do
  idx=$((idx + 1))
  n=$(printf "%03d" "$idx")

  read -r w h < <(sips -g pixelWidth -g pixelHeight "$f" 2>/dev/null \
    | awk '/pixelWidth/{w=$2} /pixelHeight/{h=$2} END{print w, h}')
  if [ -z "${w:-}" ]; then
    echo "!! boyut okunamadi, atlandi: $f" >&2
    idx=$((idx - 1))
    continue
  fi

  # Uzun kenari hedef boyuta indir; kisa kenar oranla belirlenir.
  if [ "$w" -ge "$h" ]; then
    full_resize="$FULL_EDGE 0";  thumb_resize="$THUMB_EDGE 0";  orientations="${orientations}l"
  else
    full_resize="0 $FULL_EDGE";  thumb_resize="0 $THUMB_EDGE";  orientations="${orientations}p"
  fi

  cwebp -quiet -q "$FULL_Q"  -m 4 -resize $full_resize  "$f" -o "$OUT/f/$n.webp"
  cwebp -quiet -q "$THUMB_Q" -m 4 -resize $thumb_resize "$f" -o "$OUT/t/$n.webp"
  printf '.'
done
echo

echo
echo "$idx kare islendi -> web/film/$SLUG  ($(du -sh "$OUT" | cut -f1))"
echo
echo "Asagidaki blogu lib/features/film/data/film_rolls_data.dart icindeki"
echo "rolls listesinin BASINA ekle ve bos alanlari doldur:"
echo
cat <<DART
    FilmRoll(
      id: '$SLUG',
      title: 'BASLIK',
      filmStock: 'ORN. Kodak Portra 400',
      camera: 'ORN. Canon AE-1',
      shotOn: 'ORN. Temmuz 2026',
      developedAt: 'ORN. Fotograf Fabrikasi',
      developedOn: 'ORN. 2026-08-01',
      // scannedAt: 'TARAMA YERI',
      // notes: 'NOT',
      frameCount: $idx,
      orientations: '$orientations',
      sortKey: 1000,
    ),
DART
