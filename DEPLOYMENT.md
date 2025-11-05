# Deployment Guide

This guide will help you deploy your Flutter Web portfolio to Firebase Hosting.

## Prerequisites

- Flutter SDK installed
- Firebase CLI installed
- Firebase project created (aadev-a3d70)
- Domain: alialperenderici.dev

## Step 1: Build the Web App

```bash
# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Generate Riverpod code
dart run build_runner build --delete-conflicting-outputs

# Build for web (production)
flutter build web --release
```

The build output will be in the `build/web` directory.

## Step 2: Test the Build Locally

Before deploying, test the production build locally:

```bash
# Serve the build directory
cd build/web
python3 -m http.server 8000
```

Open `http://localhost:8000` in your browser to test.

## Step 3: Deploy to Firebase Hosting

### Firebase Configuration

Your project is already configured with:
- **Firebase Core**: For initialization
- **Firebase Analytics**: For tracking user interactions and page views
- **Firebase Hosting**: For web deployment

The `firebase.json` is already configured with:
- Public directory: `build/web`
- Single-page app rewrites
- Cache headers for optimal performance (1 year for assets, 1 day for JSON/PDF)
- Asset optimization

### Analytics Tracking

The app automatically tracks:
- Page views
- Theme changes (light/dark mode)
- Language changes (EN/TR)
- CV/Cover Letter downloads
- Social link clicks
- Contact actions
- Navigation events

View analytics in [Firebase Console](https://console.firebase.google.com) → Analytics

### First-time Setup

If you need to reconfigure Firebase:

```bash
# Login to Firebase
firebase login

# Initialize Firebase Hosting (if needed)
firebase init hosting
```

When prompted:
- Select your Firebase project: `aadev-a3d70`
- Public directory: `build/web`
- Configure as single-page app: `Yes`
- Set up automatic builds with GitHub: `No` (optional)
- Don't overwrite `index.html`: `No`

### Deploy

```bash
# Deploy to Firebase Hosting
firebase deploy --only hosting
```

Your site will be live at: `https://aadev-a3d70.web.app`

## Step 4: Connect Custom Domain

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Select your project: `aadev-a3d70`
3. Navigate to **Hosting** in the left sidebar
4. Click **Add custom domain**
5. Enter your domain: `alialperenderici.dev`
6. Follow the verification steps:
   - Add TXT record to your domain's DNS settings
   - Wait for verification (can take up to 24 hours)
7. Add the A records provided by Firebase to your DNS settings:
   - Type: A
   - Name: @
   - Value: (IP addresses provided by Firebase)
8. Add AAAA records for IPv6 support (optional but recommended)
9. Wait for SSL certificate provisioning (automatic, takes a few minutes)

### DNS Configuration Example

For your domain registrar (e.g., GoDaddy, Namecheap, Google Domains):

```
Type    Name    Value
TXT     @       (verification code from Firebase)
A       @       (IP address 1 from Firebase)
A       @       (IP address 2 from Firebase)
```

## Step 5: Verify Deployment

1. Visit `https://alialperenderici.dev`
2. Test all features:
   - [ ] Theme toggle (light/dark mode)
   - [ ] Language toggle (EN/TR)
   - [ ] Navigation scrolling
   - [ ] Social links
   - [ ] CV downloads
   - [ ] Contact email link
   - [ ] Responsive design (mobile, tablet, desktop)

## Continuous Deployment

### Option 1: Manual Deployment

Every time you make changes:

```bash
# 1. Make your changes
# 2. Test locally
flutter run -d chrome

# 3. Build for production
flutter build web --release

# 4. Deploy
firebase deploy --only hosting
```

### Option 2: GitHub Actions (Recommended)

Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy to Firebase Hosting

on:
  push:
    branches:
      - main

jobs:
  build_and_deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.9.2'
      
      - name: Install dependencies
        run: flutter pub get
      
      - name: Generate code
        run: dart run build_runner build --delete-conflicting-outputs
      
      - name: Build web
        run: flutter build web --release
      
      - uses: FirebaseExtended/action-hosting-deploy@v0
        with:
          repoToken: '${{ secrets.GITHUB_TOKEN }}'
          firebaseServiceAccount: '${{ secrets.FIREBASE_SERVICE_ACCOUNT }}'
          channelId: live
          projectId: aadev-a3d70
```

## Troubleshooting

### Build Errors

If you encounter build errors:

```bash
# Clean and rebuild
flutter clean
flutter pub get
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
flutter build web --release
```

### Firebase CLI Issues

```bash
# Update Firebase CLI
npm install -g firebase-tools

# Re-login
firebase logout
firebase login
```

### Domain Not Working

- Check DNS propagation: https://dnschecker.org
- Verify DNS records in your domain registrar
- Wait up to 24-48 hours for DNS propagation
- Check Firebase Console for SSL certificate status

### Assets Not Loading

Make sure all assets are properly declared in `pubspec.yaml` and exist in the correct directories.

## Performance Optimization

### Enable Caching

Firebase Hosting automatically caches static assets. You can customize caching in `firebase.json`:

```json
{
  "hosting": {
    "public": "build/web",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "headers": [
      {
        "source": "**/*.@(jpg|jpeg|gif|png|svg|webp)",
        "headers": [
          {
            "key": "Cache-Control",
            "value": "max-age=31536000"
          }
        ]
      },
      {
        "source": "**/*.@(js|css)",
        "headers": [
          {
            "key": "Cache-Control",
            "value": "max-age=31536000"
          }
        ]
      }
    ]
  }
}
```

### Optimize Images

Before deploying, optimize your images:

```bash
# Install imagemagick
brew install imagemagick

# Optimize images
mogrify -strip -quality 85 assets/images/*.{jpg,jpeg,png}
mogrify -strip -quality 85 assets/screenshots/*.{jpg,jpeg,png}
mogrify -strip -quality 85 assets/certificates/*.{jpg,jpeg,png}
```

## Monitoring

### Firebase Analytics

Add Firebase Analytics to track visitors:

1. Go to Firebase Console → Analytics
2. Enable Google Analytics
3. Add the Firebase SDK to your web app
4. Track custom events for user interactions

### Performance Monitoring

Monitor your site's performance:

1. Go to Firebase Console → Performance
2. Enable Performance Monitoring
3. View metrics like page load time, network requests, etc.

## Rollback

If you need to rollback to a previous version:

```bash
# View deployment history
firebase hosting:channel:list

# Rollback to a specific version
firebase hosting:clone SOURCE_SITE_ID:SOURCE_CHANNEL_ID TARGET_SITE_ID:live
```

## Security

### Content Security Policy

Add CSP headers in `firebase.json` for better security:

```json
{
  "headers": [
    {
      "source": "**",
      "headers": [
        {
          "key": "Content-Security-Policy",
          "value": "default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline' https://fonts.googleapis.com; font-src 'self' https://fonts.gstatic.com; img-src 'self' data: https:;"
        }
      ]
    }
  ]
}
```

## Support

For issues or questions:
- Firebase Documentation: https://firebase.google.com/docs/hosting
- Flutter Web Documentation: https://flutter.dev/web
- GitHub Issues: Create an issue in your repository

---

**Last Updated**: 2025-11-05

