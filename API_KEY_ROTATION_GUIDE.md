# 🔐 Firebase API Key Rotation ve Git History Temizleme

## ⚠️ Durum

GitGuardian, GitHub repository'nizde Firebase API Key tespit etti:
- **Secret type**: Google API Key
- **Repository**: alperenderici/aadev
- **Key**: `AIzaSyB5G-EPoIN1WaynJT-8ctARzrVC3NVbgTc`

## ✅ Çözüm Adımları

### Adım 1: Yeni Firebase Web App Oluştur

1. [Firebase Console](https://console.firebase.google.com/project/aadev-a3d70/settings/general) → Settings → General

2. **Your apps** bölümünde **Add app** → **Web** (</>) seçin

3. App nickname: `aad-web-secure` (veya istediğiniz bir isim)

4. **Register app** butonuna tıklayın

5. Yeni API key'i kopyalayın (örnek: `AIzaSyXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX`)

6. **Continue to console** butonuna tıklayın

### Adım 2: Eski API Key'i Devre Dışı Bırak

1. [Google Cloud Console - Credentials](https://console.cloud.google.com/apis/credentials?project=aadev-a3d70)

2. Eski API key'i bulun: `Browser key (auto created by Firebase)` veya `AIzaSyB5G-EPoIN1WaynJT-8ctARzrVC3NVbgTc`

3. **Delete** butonuna tıklayın (veya **Disable** edin)

4. Onaylayın

**Not**: Eski key'i silmeden önce yeni key'in çalıştığından emin olun!

### Adım 3: Environment Variable Kullanımı

Firebase Web API key'leri için environment variable kullanımı **gerekli değildir** çünkü:
- Web uygulamalarında API key'ler client-side kodda bulunur
- Güvenlik Firebase Security Rules ile sağlanır
- Ancak git history'den temizlemek için yeni key kullanacağız

### Adım 4: Yeni API Key ile firebase_options.dart Güncelleme

Ben sizin için güncelleyeceğim. Yeni API key'i bana verin.

### Adım 5: Git History Temizleme

Eski API key'i git history'den tamamen silmek için:

**Seçenek 1: BFG Repo-Cleaner (Önerilen)**

```bash
# BFG'yi yükle (Mac)
brew install bfg

# Repository'yi clone et (bare)
cd /tmp
git clone --mirror https://github.com/alperenderici/aadev.git

# Eski API key'i değiştir
cd aadev.git
bfg --replace-text ../replacements.txt

# replacements.txt içeriği:
# AIzaSyB5G-EPoIN1WaynJT-8ctARzrVC3NVbgTc==>REDACTED_API_KEY

# Değişiklikleri uygula
git reflog expire --expire=now --all
git gc --prune=now --aggressive

# GitHub'a push et (FORCE)
git push --force
```

**Seçenek 2: git filter-repo (Alternatif)**

```bash
# git-filter-repo yükle
brew install git-filter-repo

# Repository'de çalıştır
cd /Volumes/ExternalPortableSSD/Documents/Projects/aad

# Eski API key'i değiştir
git filter-repo --replace-text <(echo 'AIzaSyB5G-EPoIN1WaynJT-8ctARzrVC3NVbgTc==>REDACTED_API_KEY')

# GitHub'a push et (FORCE)
git push --force --all
```

**Seçenek 3: Yeni Repository Oluştur (En Kolay)**

Eğer commit history'niz önemli değilse:

```bash
# Mevcut .git klasörünü sil
cd /Volumes/ExternalPortableSSD/Documents/Projects/aad
rm -rf .git

# Yeni git repository başlat
git init
git add .
git commit -m "Initial commit with secure Firebase configuration"

# GitHub'daki repository'yi sil ve yeniden oluştur
# VEYA force push et
git remote add origin https://github.com/alperenderici/aadev.git
git push -u --force origin main
```

### Adım 6: GitHub Secret Scanning Uyarısını Kapat

1. [GitHub - Security Alerts](https://github.com/alperenderici/aadev/security/secret-scanning)

2. Uyarıyı açın

3. **Close as** → **Revoked** seçin

4. Açıklama: "API key rotated and old key deleted from Google Cloud Console"

5. **Close alert** butonuna tıklayın

### Adım 7: GitGuardian Uyarısını Kapat

1. GitGuardian dashboard'a gidin

2. Uyarıyı bulun

3. **Mark as resolved** → **Revoked** seçin

4. Açıklama: "API key rotated, old key deleted, git history cleaned"

## 🔒 Gelecek İçin Güvenlik Önlemleri

### 1. API Key Kısıtlamaları

Yeni API key için kısıtlamalar ekleyin:

1. [Google Cloud Console - Credentials](https://console.cloud.google.com/apis/credentials?project=aadev-a3d70)

2. Yeni API key'i bulun

3. **Edit** butonuna tıklayın

4. **Application restrictions**:
   - **HTTP referrers** seçin
   - Ekleyin:
     ```
     aadev-a3d70.web.app/*
     aadev-a3d70.firebaseapp.com/*
     alialperenderici.dev/*
     www.alialperenderici.dev/*
     localhost:*
     127.0.0.1:*
     ```

5. **API restrictions**:
   - **Restrict key** seçin
   - Seçin:
     - Firebase Hosting API
     - Firebase Analytics API
     - Identity Toolkit API

6. **Save**

### 2. .gitignore Güncellemesi

`.gitignore` dosyasına ekleyin:
```
# Firebase sensitive files
lib/firebase_options.dart
.env
.env.local
```

**Ancak**: Firebase Web için bu gerekli değil, çünkü API key zaten public olmalı.

### 3. Pre-commit Hook (Opsiyonel)

Secret'ları commit etmeden önce kontrol etmek için:

```bash
# gitleaks yükle
brew install gitleaks

# Pre-commit hook oluştur
cat > .git/hooks/pre-commit << 'EOF'
#!/bin/sh
gitleaks protect --staged --verbose
EOF

chmod +x .git/hooks/pre-commit
```

## 📝 Özet

1. ✅ Yeni Firebase Web App oluştur
2. ✅ Yeni API key al
3. ✅ `firebase_options.dart` güncelle
4. ✅ Eski API key'i Google Cloud Console'dan sil
5. ✅ Git history'yi temizle (BFG veya yeni repo)
6. ✅ GitHub'a force push
7. ✅ GitHub ve GitGuardian uyarılarını kapat
8. ✅ Yeni API key'e kısıtlamalar ekle

## ⚠️ Önemli Notlar

- **Firebase Web API Key'leri public olabilir** - Bu normal!
- Güvenlik, API key ile değil, Firebase Security Rules ile sağlanır
- API key kısıtlamaları (domain restrictions) ekstra güvenlik sağlar
- Git history temizleme işlemi **force push** gerektirir
- Force push yapmadan önce yedek alın!

## 🆘 Yardım

Sorun yaşarsanız:
- Firebase Support: https://firebase.google.com/support
- GitHub Support: https://support.github.com
- GitGuardian: https://www.gitguardian.com/support

---

**Sonraki Adım**: Bana yeni Firebase API key'inizi verin, ben `firebase_options.dart` dosyasını güncelleyeyim.

