# Custom Domain Kurulumu: alialperenderici.dev

## 🎯 Hedef

Squarespace'deki `alialperenderici.dev` domain'inizi Firebase Hosting'e bağlamak.

## 📋 Adımlar

### 1. Firebase Console'da Domain Ekleme

1. [Firebase Console - Hosting](https://console.firebase.google.com/project/aadev-a3d70/hosting) adresine gidin

2. **Add custom domain** butonuna tıklayın

3. Domain adınızı girin: `alialperenderici.dev`

4. **Continue** butonuna tıklayın

### 2. Domain Doğrulama (Verification)

Firebase size bir **TXT kaydı** verecek. Örnek:
```
Type: TXT
Name: @
Value: firebase=aadev-a3d70
```

#### Squarespace'de TXT Kaydı Ekleme

1. [Squarespace Domains](https://account.squarespace.com/domains) adresine gidin

2. `alialperenderici.dev` domain'ine tıklayın

3. **DNS Settings** veya **Advanced Settings** bölümüne gidin

4. **Add Record** butonuna tıklayın

5. Şu bilgileri girin:
   - **Type**: TXT
   - **Host**: @ (veya boş bırakın)
   - **Value**: Firebase'in verdiği değer (örn: `firebase=aadev-a3d70`)
   - **TTL**: 3600 (veya default)

6. **Save** butonuna tıklayın

7. Firebase Console'a dönün ve **Verify** butonuna tıklayın

**Not**: DNS değişikliklerinin yayılması 5-10 dakika sürebilir.

### 3. DNS Kayıtlarını Güncelleme

Domain doğrulandıktan sonra, Firebase size **A kayıtları** verecek. Örnek:
```
Type: A
Name: @
Value: 151.101.1.195

Type: A
Name: @
Value: 151.101.65.195
```

#### Squarespace'de A Kayıtlarını Güncelleme

**ÖNEMLİ**: Önce mevcut A kayıtlarını silin veya devre dışı bırakın!

1. Squarespace DNS Settings'e gidin

2. **Mevcut A kayıtlarını** bulun (Squarespace'e işaret edenler)

3. Bu kayıtları **silin** veya **devre dışı bırakın**

4. **Add Record** ile yeni A kayıtları ekleyin:
   - **Type**: A
   - **Host**: @ (veya boş)
   - **Value**: Firebase'in verdiği ilk IP adresi
   - **TTL**: 3600

5. İkinci A kaydını da ekleyin:
   - **Type**: A
   - **Host**: @ (veya boş)
   - **Value**: Firebase'in verdiği ikinci IP adresi
   - **TTL**: 3600

6. **Save** butonuna tıklayın

### 4. www Subdomain (Opsiyonel ama Önerilen)

`www.alialperenderici.dev` için de yönlendirme ekleyin:

Firebase Console'da:
1. **Add custom domain** butonuna tekrar tıklayın
2. `www.alialperenderici.dev` girin
3. **Redirect to existing website** seçeneğini seçin
4. `alialperenderici.dev` seçin

Squarespace'de:
1. CNAME kaydı ekleyin:
   - **Type**: CNAME
   - **Host**: www
   - **Value**: `alialperenderici.dev`
   - **TTL**: 3600

### 5. SSL Sertifikası (Otomatik)

Firebase otomatik olarak SSL sertifikası oluşturacak:
- Bu işlem **birkaç dakika** ile **24 saat** arasında sürebilir
- Genellikle 15-30 dakika içinde tamamlanır
- Sertifika hazır olduğunda domain'iniz HTTPS ile erişilebilir olacak

### 6. Squarespace'i Devre Dışı Bırakma

Domain Firebase'e bağlandıktan sonra:

1. Squarespace'deki web sitenizi **unpublish** edin
2. Veya Squarespace aboneliğinizi iptal edin
3. Domain'i Squarespace'de tutabilirsiniz (sadece DNS yönetimi için)

**Not**: Domain'i başka bir registrar'a (GoDaddy, Namecheap, Google Domains) transfer etmek isterseniz, Squarespace'den transfer kodu alabilirsiniz.

## 🔍 DNS Değişikliklerini Kontrol Etme

DNS değişikliklerinin yayılıp yayılmadığını kontrol etmek için:

### Terminal'de:
```bash
# TXT kaydını kontrol et
dig TXT alialperenderici.dev

# A kayıtlarını kontrol et
dig A alialperenderici.dev

# Veya nslookup kullan
nslookup alialperenderici.dev
```

### Online Araçlar:
- https://dnschecker.org
- https://www.whatsmydns.net

## 📊 Beklenen DNS Yapısı

Domain bağlandıktan sonra DNS kayıtlarınız şöyle olmalı:

```
alialperenderici.dev
├── A       → 151.101.1.195 (Firebase IP 1)
├── A       → 151.101.65.195 (Firebase IP 2)
├── TXT     → firebase=aadev-a3d70 (Doğrulama)
└── www
    └── CNAME → alialperenderici.dev
```

## ⏱️ Zaman Çizelgesi

1. **TXT kaydı ekleme**: 5-10 dakika (DNS yayılması)
2. **Domain doğrulama**: Anında (DNS yayıldıktan sonra)
3. **A kayıtları ekleme**: 5-10 dakika (DNS yayılması)
4. **SSL sertifikası**: 15 dakika - 24 saat (genellikle 30 dakika)
5. **Toplam süre**: ~1 saat (ortalama)

## ✅ Başarı Kontrolü

Domain başarıyla bağlandığında:

1. `https://alialperenderici.dev` adresine gidin
2. Siteniz yüklenmeli
3. Tarayıcıda yeşil kilit ikonu görünmeli (HTTPS)
4. Firebase Console'da domain durumu "Connected" olmalı

## 🆘 Sorun Giderme

### "Domain verification failed"
- TXT kaydının doğru eklendiğini kontrol edin
- DNS yayılmasını bekleyin (5-10 dakika)
- `dig TXT alialperenderici.dev` ile kontrol edin

### "SSL certificate pending"
- Normal, 24 saate kadar sürebilir
- Genellikle 15-30 dakika içinde hazır olur
- Bekleyin, Firebase otomatik olarak halleder

### "DNS records not found"
- A kayıtlarının doğru eklendiğini kontrol edin
- Eski Squarespace A kayıtlarını sildiğinizden emin olun
- DNS yayılmasını bekleyin

### "Mixed content" uyarıları
- Tüm asset'lerin HTTPS ile yüklendiğinden emin olun
- Firebase otomatik olarak HTTPS'e yönlendirir

## 📞 Yardım

Sorun yaşarsanız:
1. Firebase Console → Support
2. Squarespace Support (DNS ayarları için)
3. Firebase Community: https://firebase.google.com/support

## 🎉 Tamamlandı!

Domain bağlandığında:
- ✅ `https://alialperenderici.dev` → Portfolio siteniz
- ✅ `https://www.alialperenderici.dev` → Otomatik yönlendirme
- ✅ `https://aadev-a3d70.web.app` → Hala çalışır (yedek URL)
- ✅ HTTPS otomatik
- ✅ SSL sertifikası otomatik yenilenir

---

**Not**: Bu işlem sırasında Squarespace aboneliğiniz aktif olmalı. Domain transfer etmek isterseniz, önce Firebase'e bağlayın, sonra transfer edin.

