# Firebase API Key Güvenlik Bilgisi

## ⚠️ GitHub Uyarısı Hakkında

GitHub'dan aldığınız uyarı:
```
Google API Key detected: REDACTED_FIREBASE_API_KEY
```

## ✅ Bu Normal ve Güvenlidir

Firebase Web API Key'inin public olması **tamamen normaldir** ve **güvenlik sorunu değildir**.

### Neden?

1. **Web API Key'leri Public'tir**: Flutter Web, React, Angular gibi tüm web uygulamalarında Firebase API key'leri client-side kodda bulunur ve herkes tarafından görülebilir.

2. **Güvenlik Firebase Tarafında**: Güvenlik, API key ile değil, Firebase Console'daki güvenlik kuralları (Security Rules) ile sağlanır.

3. **Firebase Resmi Dokümantasyonu**: Firebase'in resmi dokümantasyonu, web API key'lerinin public olmasının güvenli olduğunu belirtir.

## 🔒 Güvenlik Önlemleri

### 1. Firebase Console'da API Key Kısıtlamaları

Firebase Console'da API key'inizi kısıtlayın:

1. [Google Cloud Console](https://console.cloud.google.com/apis/credentials?project=aadev-a3d70) adresine gidin
2. API Key'inizi bulun: `REDACTED_FIREBASE_API_KEY`
3. **Application restrictions** bölümünde:
   - **HTTP referrers** seçin
   - Şu domain'leri ekleyin:
     - `aadev-a3d70.web.app/*`
     - `aadev-a3d70.firebaseapp.com/*`
     - `alialperenderici.dev/*` (custom domain ekledikten sonra)
     - `localhost:*` (development için)

4. **API restrictions** bölümünde:
   - **Restrict key** seçin
   - Sadece şu API'leri seçin:
     - Firebase Hosting API
     - Firebase Analytics API
     - Cloud Firestore API (eğer kullanıyorsanız)

### 2. Firebase Security Rules

Firebase Console'da güvenlik kurallarınızı kontrol edin:

**Analytics**: Otomatik olarak güvenlidir, ek kural gerekmez.

**Firestore** (eğer kullanıyorsanız):
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read: if true;  // Public read
      allow write: if false; // No public write
    }
  }
}
```

**Storage** (eğer kullanıyorsanız):
```javascript
rules_version = '2';
service firebase.storage {
  match /b/{bucket}/o {
    match /{allPaths=**} {
      allow read: if true;  // Public read
      allow write: if false; // No public write
    }
  }
}
```

## 📝 GitHub Uyarısını Kapatma

GitHub'daki uyarıyı kapatmak için:

1. GitHub repository'nize gidin: https://github.com/alperenderici/aadev
2. **Security** → **Secret scanning alerts** bölümüne gidin
3. Uyarıyı açın
4. **Close as** → **Used in tests** veya **False positive** seçin
5. Açıklama ekleyin:
   ```
   This is a Firebase Web API Key which is designed to be public.
   Security is handled by Firebase Security Rules and API restrictions
   in Google Cloud Console, not by keeping the key secret.
   
   Reference: https://firebase.google.com/docs/projects/api-keys
   ```

## 🔗 Referanslar

- [Firebase: Using API Keys](https://firebase.google.com/docs/projects/api-keys)
- [Is it safe to expose Firebase apiKey to the public?](https://stackoverflow.com/questions/37482366/is-it-safe-to-expose-firebase-apikey-to-the-public)
- [Firebase Security Rules](https://firebase.google.com/docs/rules)

## ✅ Sonuç

Firebase Web API Key'iniz public olabilir. Güvenlik, Firebase Console'daki:
1. API Key kısıtlamaları (domain restrictions)
2. Security Rules (Firestore, Storage, vb.)

ile sağlanır. GitHub uyarısını "false positive" olarak kapatabilirsiniz.

