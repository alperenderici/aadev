# Ali Alperen Derici - Professional Portfolio Website

A modern, professional portfolio website built with Flutter Web, showcasing my expertise as a Flutter developer.

## 🚀 Features

- **Modern Design**: Clean, professional UI with smooth animations
- **Responsive**: Fully responsive across Mobile, Tablet, and Desktop viewports
- **Dark/Light Mode**: Theme toggle with system preference support
- **Bilingual**: Turkish and English language support (i18n)
- **Text Selection Enabled**: Users can select and copy text
- **State Management**: Riverpod and Riverpod Hooks for efficient state management
- **Reusable Components**: Dynamic, reusable widgets across all pages
- **SEO Optimized**: Proper meta tags and semantic HTML

## 📋 Sections

1. **Hero Section**: Eye-catching introduction with profile photo
2. **About Me**: Professional background and skills showcase
3. **Experience**: Portfolio of projects with screenshots and descriptions
4. **Certificates**: Gallery of achievements and certifications
5. **Social Links**: Connect on various platforms (GitHub, LinkedIn, etc.)
6. **CV Downloads**: Download CV and cover letters in English and Turkish
7. **Contact**: Easy email contact functionality

## 🛠️ Tech Stack

- **Framework**: Flutter Web
- **State Management**: Riverpod, Riverpod Hooks
- **Localization**: flutter_localizations, intl
- **UI/Animations**: flutter_animate, Google Fonts
- **Icons**: Font Awesome Flutter
- **Utilities**: url_launcher, url_strategy
- **Firebase**: Core, Analytics, Hosting
- **Deployment**: Firebase Hosting

## 📦 Project Structure

```
lib/
├── core/
│   ├── constants/       # App constants and asset paths
│   ├── data/           # Static data (experiences, etc.)
│   ├── l10n/           # Localization files
│   ├── models/         # Data models
│   ├── providers/      # Riverpod providers
│   ├── theme/          # Theme configuration
│   └── utils/          # Utility functions (responsive, etc.)
├── features/
│   └── home/
│       ├── pages/      # Main pages
│       └── widgets/    # Feature-specific widgets
├── shared/
│   └── widgets/        # Reusable widgets
└── main.dart           # App entry point
```

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (3.9.2 or higher)
- Dart SDK
- Firebase CLI (for deployment)

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd aad
```

2. Install dependencies:
```bash
flutter pub get
```

3. Generate Riverpod code:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### Running the App

#### Web (Development)
```bash
flutter run -d chrome
```

#### Web (Production Build)
```bash
flutter build web --release
```

## 🌐 Deployment to Firebase Hosting

### First-time Setup

1. Install Firebase CLI:
```bash
npm install -g firebase-tools
```

2. Login to Firebase:
```bash
firebase login
```

3. Initialize Firebase (if not already done):
```bash
firebase init hosting
```
- Select your Firebase project
- Set public directory to: `build/web`
- Configure as single-page app: Yes
- Don't overwrite index.html

### Deploy

1. Build the web app:
```bash
flutter build web --release
```

2. Deploy to Firebase:
```bash
firebase deploy --only hosting
```

Your site will be live at: `https://your-project.web.app`

### Custom Domain Setup

1. Go to Firebase Console → Hosting
2. Click "Add custom domain"
3. Follow the instructions to verify and connect your domain (alialperenderici.dev)

## 📝 Customization Guide

### Update Personal Information

1. **Contact Info**: Edit `lib/core/constants/app_constants.dart`
2. **Social Links**: Update URLs in `lib/core/models/social_link_model.dart`
3. **Experience Data**: Modify `lib/core/data/experiences_data.dart`

### Add New Experience

1. Add screenshots to `assets/screenshots/`
2. Update `lib/core/constants/asset_paths.dart`
3. Add experience to `lib/core/data/experiences_data.dart`
4. Add translations in `lib/core/l10n/app_localizations.dart`

### Add New Certificate

1. Add certificate image to `assets/certificates/`
2. Update the list in `lib/core/constants/asset_paths.dart`

### Update CV/Cover Letter

1. Replace files in `assets/CV/`
2. Keep the same naming convention: `AAD_CV(EN).pdf`, `AAD_CV(TR).pdf`, etc.

### Change Theme Colors

Edit `lib/core/theme/app_theme.dart` to customize colors and styles.

## 🎨 Assets

- **Profile Photo**: `assets/images/pp.png`
- **Professional Photos**: `assets/images/fitgo_*.JPG`
- **Screenshots**: `assets/screenshots/`
- **Certificates**: `assets/certificates/`
- **Documents**: `assets/CV/`

## 🔧 Development Commands

```bash
# Get dependencies
flutter pub get

# Generate code (Riverpod)
dart run build_runner build --delete-conflicting-outputs

# Watch for changes (auto-generate)
dart run build_runner watch

# Run on web
flutter run -d chrome

# Build for web
flutter build web --release

# Analyze code
flutter analyze

# Format code
dart format .
```

## 📱 Responsive Breakpoints

- **Mobile**: < 600px
- **Tablet**: 600px - 900px
- **Desktop**: > 900px

## 🌍 Supported Languages

- English (en)
- Turkish (tr)

## 📄 License

This project is personal portfolio website. Feel free to use it as inspiration for your own portfolio!

## 👤 Author

**Ali Alperen Derici**
- Website: [alialperenderici.dev](https://alialperenderici.dev)
- GitHub: [@alperenderici](https://github.com/alperenderici)
- LinkedIn: [Ali Alperen Derici](https://linkedin.com/in/alperenderici)

## 🙏 Acknowledgments

- Built with [Flutter](https://flutter.dev)
- State management with [Riverpod](https://riverpod.dev)
- Icons from [Font Awesome](https://fontawesome.com)
- Fonts from [Google Fonts](https://fonts.google.com)

---

**Note**: Remember to update your social media URLs, email, and other personal information in the constants file before deploying!
