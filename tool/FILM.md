# 35mm film arşivi

Filmli makineyle çekilmiş taramaların tutulduğu bölüm. Sitede **`/35mm`**
adresinde yaşıyor ve gizli: hiçbir yerden link verilmiyor, `robots.txt` hem
sayfayı hem `/film/` klasörünü arama motorlarına kapatıyor. Adresi bilen açar.

- `/35mm` — bütün rulolar, her birinin kapak karesiyle
- `/35mm/<rulo-id>` — o rulonun künyesi ve kontakt sayfası (paylaşılabilir adres)
- Kareye tıklayınca tam ekran görüntüleyici açılır (ok tuşları, `Esc`, kaydırma)

## Dosyalar nerede

Kareler Flutter asset'i değil, `index.html` yanında duran statik dosyalar —
bu yüzden yeni rulo eklerken `pubspec.yaml`'a dokunmak gerekmiyor:

```
web/film/<rulo-id>/f/001.webp   tam boy, uzun kenar 1800px, kalite 78
web/film/<rulo-id>/t/001.webp   küçük resim, uzun kenar 640px, kalite 62
```

WebP tercih edildi: aynı görsel kalitede JPEG'in yaklaşık üçte biri kadar yer
tutuyor (871 kare için 156 MB'a karşılık ~690 MB).

Künye bilgisi tek yerde: `lib/features/film/data/film_rolls_data.dart`.

## Yeni rulo ekleme

```bash
tool/build_film_archive.sh ~/Downloads/35mm/yeni-rulo portra-2026
```

Script iki boyu üretir ve ekrana `film_rolls_data.dart` içine yapıştıracağın
`FilmRoll(...)` bloğunu basar. Bloğu `rolls` listesinin **başına** koy, boş
künye alanlarını doldur, kullanılmayan satırları sil.

Doldurulabilecek alanlar — hepsi isteğe bağlı, sadece dolu olanlar ekranda çıkar:

| alan | örnek |
|---|---|
| `filmStock` | `Kodak Portra 400` |
| `camera` | `Canon AE-1 · 50mm f/1.8` |
| `shotOn` | `Temmuz 2026` |
| `developedAt` | `Fotoğraf Fabrikası` |
| `developedOn` | `2026-08-01` |
| `scannedAt` | tarama başka yerde yapıldıysa |
| `notes` | serbest not |
| `coverIndex` | kapakta görünecek kare numarası − 1 |

**Başlık kuralı:** `title` yalnızca film adı biliniyorsa verilir
(`Kodak Ektar · 2025`). Bilinmiyorsa `İsimsiz Rulo N` kalır; lab ve makine
bilgisi başlığa değil künye alanlarına yazılır.

**Rulo id kuralı:** id hem klasör adı hem URL olduğu için başlıkla aynı mantığı
izler. Film adı bilinen rulo `ektar-2025` gibi anlamlı bir id alır; bilinmeyen
rulo `rulo-07` olur ve `İsimsiz Rulo 7` başlığıyla eşleşir. Böylece taramanın
geldiği klasörün adı (kişi adı, lab adı, `asdasd`) adrese sızmaz.

## Yan yatmış kareleri düzeltme

Lab taramalarında EXIF yön etiketi yok ve bazı rulolar bütünüyle yan ya da ters
taranmış. Düzeltmek için:

```bash
python3 -m http.server 8000          # proje kökünde
open http://localhost:8000/tool/rotate_review.html
```

Açılan sayfada bütün kareler rulo rulo listelenir. Bir rulonun tamamı aynı yöne
yatmışsa önce **TÜM RULO** düğmeleri, sonra kalan tek tük kare tıklanarak
düzeltilir (her tıklama 90° saat yönü, `Shift`+tıklama ters yön). Seçimler
tarayıcıda saklanır, sayfayı kapatsan da kaybolmaz.

Bitince **rotations.json indir** deyip:

```bash
python3 tool/apply_rotations.py ~/Downloads/rotations.json
```

Bu, dönmüş kareleri **orijinal taramadan** yeniden üretir (mevcut WebP'yi
çevirmez, yani kalite kaybı olmaz) ve `film_rolls_data.dart` içindeki
`orientations` dizgesini günceller.

`tool/film_sources.json` her kareyi kaynak tarama dosyasına bağlar. Orijinallerin
durduğu klasörü taşırsan bu dosyadaki `root` değerini güncelle.

## Mükerrer kareleri temizleme

Aynı negatif birden fazla klasöre farklı taramalarla girmiş olabiliyor. Dosyalar
bayt bayt aynı olmadığı için `md5` işe yaramaz; algısal parmak izi gerekir:

```bash
python3 tool/find_duplicates.py           # tool/duplicates.json uretir
open http://localhost:8000/tool/duplicates_review.html
```

Sayfa üç bölüm gösterir:

- **Örtüşen rulolar** — bir rulo baştan sona başka bir rulonun kopyasıysa
  (`rulo-15` ↔ `rulo-19` %97 gibi) tek düğmeyle o rulonun bütün kopyaları
  işaretlenir. Düğme hiçbir grubu boşaltmaz, her grupta en az bir kare bırakır.
- **Mükerrer gruplar** — kare kare karşılaştırma. Silmek istediğine tıkla.
  Yeşil yazılı boyut o grubun en büyük dosyası, yani genelde daha iyi tarama.
- **Parmak izi çıkmayan kareler** — fazla düz/soluk oldukları için güvenilir
  eşleştirilemeyenler; bunlara gözünle bakman gerekiyor.

Bitince **deletions.json indir** deyip:

```bash
python3 tool/apply_deletions.py ~/Downloads/deletions.json --dry-run   # once dene
python3 tool/apply_deletions.py ~/Downloads/deletions.json
```

Kareler 001..N boşluksuz numaralandığı için silme sonrası kalanlar yeniden
numaralanır; `frameCount`, `orientations`, `coverIndex` ve `film_sources.json`
otomatik güncellenir. Bütün kareleri silinen rulo katalogdan tamamen kalkar.

## Yayına alma

```bash
flutter build web --release
firebase deploy --only hosting
```

**Rulo sildiysen ya da yeniden adlandırdıysan** önce `build/web`'i temizle:

```bash
rm -rf build/web && flutter build web --release
```

`flutter build web`, `web/` klasörünü `build/web`'e kopyalarken artık var olmayan
klasörleri silmiyor. Temizlemezsen eski adlarıyla boş dizinler deploy'a sızar.
