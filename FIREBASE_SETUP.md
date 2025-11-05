# Firebase Setup Guide

This document explains the Firebase integration in your portfolio website.

## 🔥 Firebase Services Configured

### 1. Firebase Core
- **Purpose**: Initialize Firebase in your Flutter app
- **Configuration**: `lib/firebase_options.dart`
- **Project ID**: `aadev-a3d70`
- **Web App ID**: `1:132923745492:web:c9c7702474996a99a94741`

### 2. Firebase Analytics
- **Purpose**: Track user interactions and behavior
- **Service**: `lib/core/services/analytics_service.dart`
- **Measurement ID**: `G-DR2S6SE369`

### 3. Firebase Hosting
- **Purpose**: Deploy and host your website
- **Configuration**: `firebase.json`
- **Public Directory**: `build/web`

## 📊 Analytics Events Tracked

The app automatically tracks the following user interactions:

### Page Views
- Automatically tracked via `FirebaseAnalyticsObserver`
- Tracks navigation between sections

### Theme Changes
- **Event**: `theme_change`
- **Parameters**: `theme` (light/dark)
- **Triggered**: When user toggles theme in navigation bar

### Language Changes
- **Event**: `language_change`
- **Parameters**: `language` (en/tr)
- **Triggered**: When user switches language

### CV/Cover Letter Downloads
- **Event**: `cv_download`
- **Parameters**: `type` (CV_EN, CV_TR, CL_EN, CL_TR)
- **Triggered**: When user clicks download buttons

### Social Link Clicks
- **Event**: `social_link_click`
- **Parameters**: `platform` (GitHub, LinkedIn, etc.)
- **Triggered**: When user clicks social media icons

### Contact Actions
- **Event**: `contact_action`
- **Triggered**: When user clicks email contact button

### Navigation Events
- **Event**: `navigation`
- **Parameters**: `destination` (home, about, experience, etc.)
- **Triggered**: When user navigates to different sections

## 🛠️ Implementation Details

### Main App Initialization

```dart
// lib/main.dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const ProviderScope(child: MyApp()));
}
```

### Analytics Observer

```dart
// lib/main.dart
MaterialApp(
  navigatorObservers: [
    AnalyticsService.observer,
  ],
  // ...
)
```

### Analytics Service

The `AnalyticsService` class provides static methods for tracking:

```dart
// Track theme change
AnalyticsService.logThemeChange('dark');

// Track language change
AnalyticsService.logLanguageChange('tr');

// Track CV download
AnalyticsService.logCVDownload('CV_EN');

// Track social link click
AnalyticsService.logSocialLinkClick('GitHub');

// Track contact action
AnalyticsService.logContactAction();
```

## 📈 Viewing Analytics Data

### Firebase Console

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Select project: `aadev-a3d70`
3. Navigate to **Analytics** → **Dashboard**

### Real-time Analytics

View real-time user activity:
- **Analytics** → **Realtime**
- See active users, events, and page views

### Event Analytics

View detailed event data:
- **Analytics** → **Events**
- See all tracked events with parameters
- View event counts and trends

### User Properties

Set custom user properties:
```dart
AnalyticsService.setUserProperty('preferred_theme', 'dark');
AnalyticsService.setUserProperty('preferred_language', 'en');
```

## 🚀 Deployment Configuration

### firebase.json

```json
{
  "hosting": {
    "public": "build/web",
    "ignore": ["firebase.json", "**/.*", "**/node_modules/**"],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ],
    "headers": [
      {
        "source": "**/*.@(jpg|jpeg|gif|png|svg|webp|ico)",
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

### Cache Strategy

- **Images/Icons**: 1 year cache (`max-age=31536000`)
- **JS/CSS/Fonts**: 1 year cache
- **JSON/PDF**: 1 day cache (`max-age=86400`)

## 🔒 Security & Privacy

### Data Collection

Firebase Analytics collects:
- Anonymous user IDs
- Device information (browser, OS, screen size)
- Geographic location (country/city)
- User interactions (events)

### Privacy Compliance

- No personally identifiable information (PII) is collected
- Users can opt-out via browser settings
- Data is stored securely by Google

### GDPR Compliance

To add a cookie consent banner (optional):

```dart
// Add to your app
import 'package:cookie_consent/cookie_consent.dart';

// Show consent dialog
CookieConsent.show(context);
```

## 🧪 Testing Analytics

### Debug Mode

Enable debug mode to see events in real-time:

```bash
# Chrome DevTools Console
firebase.analytics().setAnalyticsCollectionEnabled(true);
```

### DebugView

1. Go to Firebase Console → Analytics → DebugView
2. Run app in debug mode
3. See events in real-time

### Test Events

```dart
// Test custom event
AnalyticsService.logEvent(
  name: 'test_event',
  parameters: {'test_param': 'test_value'},
);
```

## 📱 Future Enhancements

### Recommended Analytics

1. **Conversion Tracking**
   - Track when users download CV
   - Track when users click contact

2. **User Engagement**
   - Time spent on each section
   - Scroll depth tracking
   - Video play events (if added)

3. **Performance Monitoring**
   - Add Firebase Performance Monitoring
   - Track page load times
   - Monitor network requests

### Add Performance Monitoring

```yaml
# pubspec.yaml
dependencies:
  firebase_performance: ^0.10.0
```

```dart
// Track custom traces
final trace = FirebasePerformance.instance.newTrace('page_load');
await trace.start();
// ... load page
await trace.stop();
```

## 🆘 Troubleshooting

### Analytics Not Working

1. Check Firebase initialization in `main.dart`
2. Verify `firebase_options.dart` has correct configuration
3. Check browser console for errors
4. Wait 24 hours for data to appear in Firebase Console

### Events Not Showing

1. Enable DebugView in Firebase Console
2. Check event names (no spaces, lowercase)
3. Verify parameters are valid types
4. Check network tab for analytics requests

### Build Errors

```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter build web --release
```

## 📚 Resources

- [Firebase Documentation](https://firebase.google.com/docs)
- [Firebase Analytics for Flutter](https://firebase.google.com/docs/analytics/get-started?platform=flutter)
- [Firebase Hosting](https://firebase.google.com/docs/hosting)
- [FlutterFire Documentation](https://firebase.flutter.dev)

## 🎯 Quick Commands

```bash
# View analytics in browser
open https://console.firebase.google.com/project/aadev-a3d70/analytics

# Deploy to Firebase
firebase deploy --only hosting

# View hosting logs
firebase hosting:channel:list

# Test locally
flutter run -d chrome
```

---

**Last Updated**: 2025-11-05
**Firebase Project**: aadev-a3d70
**Measurement ID**: G-DR2S6SE369

