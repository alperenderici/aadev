# 🎨 Ali Alperen Derici - Professional Portfolio Website

<div align="center">

[![Flutter](https://img.shields.io/badge/Flutter-3.27.1-02569B?logo=flutter)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.9.2-0175C2?logo=dart)](https://dart.dev)
[![Firebase](https://img.shields.io/badge/Firebase-Hosting-FFCA28?logo=firebase)](https://firebase.google.com)
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Live Demo](https://img.shields.io/badge/Live-alialperenderici.dev-blue)](https://alialperenderici.dev)

A modern, responsive, and feature-rich portfolio website built with **Flutter Web**, showcasing professional experience, projects, and skills as a Flutter developer.

[Live Demo](https://alialperenderici.dev) • [Report Bug](https://github.com/alperenderici/aadev/issues) • [Request Feature](https://github.com/alperenderici/aadev/issues)

</div>

---

## ✨ Features

### 🎯 Core Features
- **🎨 Modern Design** - Clean, professional UI with smooth animations and transitions
- **📱 Fully Responsive** - Optimized for Mobile, Tablet, and Desktop viewports
- **🌓 Dark/Light Mode** - Theme toggle with system preference support
- **🌍 Bilingual** - Turkish and English language support with seamless switching
- **✍️ Text Selection** - Users can select and copy text throughout the site
- **🎭 Generative Art** - Interactive d_art page with 6 different art styles (Particles, Waves, Fractals, Noise Field, Spirals, Frame)
- **🔍 SEO Optimized** - Proper meta tags, semantic HTML, and Open Graph support

### 🛠️ Technical Features
- **State Management** - Riverpod & Riverpod Hooks for efficient, scalable state management
- **Code Generation** - Automated code generation with build_runner
- **Type Safety** - Full type safety with Dart's sound null safety
- **Reusable Components** - Modular, maintainable widget architecture
- **CI/CD** - Automated deployment via GitHub Actions
- **Analytics** - Firebase Analytics integration for user insights
- **Performance** - Optimized build with tree-shaking and lazy loading

## 📋 Portfolio Sections

| Section | Description |
|---------|-------------|
| 🎯 **Hero** | Eye-catching introduction with animated greeting and CTA buttons |
| 👤 **About Me** | Personal introduction with 6 highlight cards showcasing expertise |
| 💼 **Experience & Projects** | Comprehensive work history and project portfolio |
| 🎓 **Certificates** | Professional certifications with hover effects and modal view |
| 🎨 **Generative Art (d_art)** | Interactive art page with 6 customizable art styles |
| 🌐 **Social Links** | Connect on GitHub, LinkedIn, Upwork, Medium, and more |
| 📄 **CV Download** | Download resume in English or Turkish |
| 📧 **Contact** | Get in touch section with email integration |
| 🎉 **Events** | Community engagement and conference participation |

## 🛠️ Complete Tech Stack

### Frontend Framework
- **Flutter Web** `3.27.1` - Google's UI toolkit for building natively compiled applications
- **Dart** `^3.9.2` - Programming language optimized for building mobile, desktop, server, and web applications

### State Management
- **flutter_riverpod** `^2.6.1` - Reactive caching and data-binding framework
- **riverpod_annotation** `^2.6.1` - Code generation for Riverpod
- **hooks_riverpod** `^2.6.1` - Riverpod integration with Flutter Hooks
- **flutter_hooks** `^0.20.5` - React hooks-like API for Flutter

### UI & Styling
- **google_fonts** `^6.2.1` - 1000+ font families from Google Fonts
- **flutter_animate** `^4.5.0` - Animation library for Flutter
- **font_awesome_flutter** `^10.8.0` - Font Awesome icon pack
- **cupertino_icons** `^1.0.8` - iOS-style icons

### Localization
- **flutter_localizations** - Flutter's built-in localization support
- **intl** - Internationalization and localization utilities

### Utilities
- **url_launcher** `^6.3.1` - Launch URLs in the mobile platform
- **url_strategy** `^0.3.0` - Configure URL strategy for Flutter web
- **visibility_detector** `^0.4.0+2` - Detect when widgets become visible

### Firebase & Backend
- **firebase_core** `^3.8.1` - Firebase Core SDK
- **firebase_analytics** `^11.3.4` - Google Analytics for Firebase

### Development Tools
- **build_runner** `^2.4.13` - Code generation tool
- **riverpod_generator** `^2.6.2` - Code generator for Riverpod
- **riverpod_lint** `^2.6.2` - Lint rules for Riverpod
- **custom_lint** `^0.7.0` - Custom lint rules

### Deployment & CI/CD
- **Firebase Hosting** - Fast and secure web hosting
- **GitHub Actions** - Automated CI/CD pipeline

## 📦 Project Structure

```
aad/
├── lib/
│   ├── core/
│   │   ├── constants/          # App-wide constants (colors, spacing, assets)
│   │   ├── data/              # Static data (experiences, events)
│   │   ├── l10n/              # Localization (English & Turkish)
│   │   ├── models/            # Data models (Certificate, Experience, etc.)
│   │   ├── providers/         # Riverpod providers (theme, locale, analytics)
│   │   ├── services/          # Services (analytics, URL launcher)
│   │   ├── theme/             # Theme configuration (light/dark modes)
│   │   └── utils/             # Utility functions (responsive helpers)
│   ├── features/
│   │   ├── generative_art/    # d_art page with interactive art styles
│   │   │   ├── models/        # Art type models
│   │   │   ├── pages/         # Generative art page
│   │   │   ├── painters/      # Custom painters for each art style
│   │   │   └── widgets/       # Art controls and canvas widgets
│   │   └── home/
│   │       ├── pages/         # Home page
│   │       └── widgets/       # Section widgets (Hero, About, Experience, etc.)
│   ├── shared/
│   │   └── widgets/           # Reusable widgets (buttons, cards, sections)
│   ├── firebase_options.dart  # Firebase configuration
│   └── main.dart              # App entry point
├── web/
│   ├── icons/                 # PWA icons
│   ├── index.html             # HTML entry point with SEO meta tags
│   └── manifest.json          # PWA manifest
├── assets/
│   ├── certificates/          # Certificate images
│   ├── CV/                    # Resume PDFs
│   ├── images/                # Profile and project images
│   └── screenshots/           # Project screenshots
├── .github/
│   └── workflows/             # CI/CD workflows (Firebase deployment)
├── firebase.json              # Firebase hosting configuration
├── .firebaserc                # Firebase project configuration
└── pubspec.yaml               # Dependencies and project metadata
```

## 🚀 Getting Started

### 📋 Prerequisites

Before you begin, ensure you have the following installed:

- **Flutter SDK** `3.27.1` or higher ([Install Flutter](https://docs.flutter.dev/get-started/install))
- **Dart SDK** `^3.9.2` (comes with Flutter)
- **Git** ([Install Git](https://git-scm.com/downloads))
- **Firebase CLI** (for deployment) - `npm install -g firebase-tools`
- **Code Editor** - VS Code or Android Studio recommended

### 📥 Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/alperenderici/aadev.git
   cd aad
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code** (Riverpod providers)
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

### 🏃 Running the App

#### Development Mode (with hot reload)
```bash
flutter run -d chrome
```

#### Production Build
```bash
flutter build web --release
```

#### Watch Mode (auto-generate code on changes)
```bash
dart run build_runner watch
```

## 🌐 Deployment

### 🔥 Firebase Hosting (Automated via GitHub Actions)

This project uses **GitHub Actions** for automated deployment to Firebase Hosting.

#### Automatic Deployment
- **On Push to `main`**: Automatically builds and deploys to production
- **On Pull Request**: Creates a preview deployment for testing

#### Manual Deployment

1. **Install Firebase CLI**
   ```bash
   npm install -g firebase-tools
   ```

2. **Login to Firebase**
   ```bash
   firebase login
   ```

3. **Build and Deploy**
   ```bash
   # Build the web app
   flutter build web --release

   # Deploy to Firebase
   firebase deploy --only hosting
   ```

Your site will be live at: `https://aadev-a3d70.web.app`

#### Custom Domain Setup

This project is deployed at **[alialperenderici.dev](https://alialperenderici.dev)**

To set up your own custom domain:
1. Go to [Firebase Console](https://console.firebase.google.com) → Hosting
2. Click "Add custom domain"
3. Follow the DNS verification instructions
4. Add the provided DNS records to your domain registrar

### 🔐 Security & API Keys

**Firebase Web API keys are safe to commit** - they're meant to be public and security is enforced through Firebase Security Rules, not API key secrecy. The API key in `lib/firebase_options.dart` is intentionally committed to the repository.

For GitHub Actions deployment, ensure you have:
- `FIREBASE_SERVICE_ACCOUNT_AADEV_A3D70` secret configured in GitHub repository settings

## 📝 Customization Guide

Want to use this portfolio template for your own website? Here's how:

### 🔧 Update Personal Information

| What to Update | File Location |
|----------------|---------------|
| **Contact Info** | `lib/core/constants/app_constants.dart` |
| **Social Links** | `lib/core/models/social_link_model.dart` |
| **Experience Data** | `lib/core/data/experiences_data.dart` |
| **Events Data** | `lib/core/data/events_data.dart` |
| **Theme Colors** | `lib/core/theme/app_theme.dart` |
| **Translations** | `lib/core/l10n/app_localizations.dart` |

### ➕ Add New Content

#### Add New Experience/Project
1. Add project screenshots to `assets/screenshots/`
2. Update `lib/core/constants/asset_paths.dart` with new asset paths
3. Add experience entry to `lib/core/data/experiences_data.dart`
4. Add English and Turkish translations in `lib/core/l10n/app_localizations.dart`

#### Add New Certificate
1. Add certificate image to `assets/certificates/` (format: `DD.MM.YYYY.png`)
2. Add entry to `lib/core/models/certificate_model.dart` with English and Turkish titles
3. Certificates are automatically sorted by date (newest first)

#### Update CV/Cover Letter
1. Replace PDF files in `assets/CV/`
2. Keep naming convention: `AAD_CV(EN).pdf`, `AAD_CV(TR).pdf`, etc.

### 🎨 Assets Structure

```
assets/
├── certificates/          # Certificate images (DD.MM.YYYY.png format)
├── CV/                   # Resume PDFs (English & Turkish)
├── images/               # Profile and project images
│   ├── pp.png           # Profile photo
│   └── fitgo_*.JPG      # Project photos
└── screenshots/          # Project screenshots
    └── akilliekip_logo.jpg
```

## 🔧 Development Commands

| Command | Description |
|---------|-------------|
| `flutter pub get` | Install dependencies |
| `dart run build_runner build --delete-conflicting-outputs` | Generate code (Riverpod providers) |
| `dart run build_runner watch` | Watch mode - auto-generate on file changes |
| `flutter run -d chrome` | Run in development mode with hot reload |
| `flutter build web --release` | Build optimized production bundle |
| `flutter analyze` | Analyze code for issues |
| `dart format .` | Format code according to Dart style guide |
| `firebase deploy --only hosting` | Deploy to Firebase Hosting |

## 📱 Responsive Design

This portfolio is fully responsive with optimized layouts for all screen sizes:

| Breakpoint | Width | Layout |
|------------|-------|--------|
| 📱 **Mobile** | < 600px | Single column, stacked sections |
| 📱 **Tablet** | 600px - 900px | 2-column grid for cards |
| 💻 **Desktop** | > 900px | Multi-column layouts, side-by-side content |

## 🌍 Internationalization (i18n)

Fully bilingual support with seamless language switching:

- 🇬🇧 **English** (`en`) - Default language
- 🇹🇷 **Turkish** (`tr`) - Complete Turkish translations

All content, including certificate titles, experience descriptions, and UI labels, are localized.

## 🎨 Generative Art Styles

The **d_art** page features 6 interactive generative art styles:

1. **Particles** - Animated particle system with connections
2. **Waves** - Flowing wave patterns with multiple layers
3. **Fractals** - Recursive fractal tree structures
4. **Noise Field** - Perlin noise-based flow field
5. **Spirals** - Rotating spiral patterns
6. **Frame** - Flowing waves in a frame

Each style has customizable parameters (speed, color, intensity, etc.)

## 📊 Performance Optimizations

- ✅ Tree-shaking for minimal bundle size
- ✅ Lazy loading of images and assets
- ✅ Code splitting with route-based loading
- ✅ Optimized font loading with Google Fonts
- ✅ Efficient state management with Riverpod
- ✅ Cached network images
- ✅ Minified and compressed production builds

## 🤝 Contributing

While this is a personal portfolio, suggestions and feedback are welcome!

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

Feel free to use this portfolio as inspiration or a template for your own website!

## 👤 Author

**Ali Alperen Derici**
- 🌐 Website: [alialperenderici.dev](https://alialperenderici.dev)
- 💼 GitHub: [@alperenderici](https://github.com/alperenderici)
- 💼 LinkedIn: [Ali Alperen Derici](https://linkedin.com/in/alperenderici)
- 💼 Upwork: [Ali Alperen Derici](https://www.upwork.com/freelancers/~01f3c97a8c1e3e3e3e)
- 📧 Email: alialperenderici@gmail.com

## 🙏 Acknowledgments

- **Framework**: [Flutter](https://flutter.dev) by Google
- **Hosting**: [Firebase Hosting](https://firebase.google.com/products/hosting)
- **Icons**: [Font Awesome](https://fontawesome.com)
- **Fonts**: [Google Fonts](https://fonts.google.com)
- **State Management**: [Riverpod](https://riverpod.dev)
- **Animations**: [Flutter Animate](https://pub.dev/packages/flutter_animate)

## ⭐ Show Your Support

If you found this project helpful or inspiring, please consider giving it a ⭐ on GitHub!

---

<div align="center">

**Made with ❤️ and Flutter by Ali Alperen Derici**

[⬆ Back to Top](#-ali-alperen-derici---professional-portfolio-website)

</div>
