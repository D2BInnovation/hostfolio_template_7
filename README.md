# HostFolio - Premium Animated Portfolio

A next-level animated personal portfolio website built with Flutter Web, driven entirely by JSON data.

## 🚀 Features

### 🎨 Ultra-Modern Design
- **Glassmorphism UI** with depth and shadows
- **Gradient accents** and premium animations
- **Motion-first design** inspired by macOS/Windows Fluent UI
- **Fully responsive** (desktop, tablet, mobile)

### 📬 JSON-Driven Architecture
- **100% data.json powered** - no hardcoded content
- **Conditional rendering** - sections appear only if data exists
- **Dynamic navigation** - navbar items auto-generated from JSON
- **Easy content management** - update portfolio via JSON only

### 🎬 Premium Animations
- **Smooth 60fps animations** throughout
- **Page load entrance animations**
- **Scroll-based reveal animations**
- **Hover micro-interactions**
- **Section transition animations**

### 🧩 Conditional Sections
All sections are conditionally rendered based on data.json:

- ✅ **Hero / Intro** - Premium landing with floating elements
- ✅ **About** - Skills showcase with glassmorphism cards
- ✅ **Experience** - Animated timeline with achievements
- ✅ **Projects** - Interactive gallery with filtering
- ✅ **Contact** - Animated form with social links

## 📁 Project Structure

```
lib/
├── models/           # Data models for JSON parsing
│   └── portfolio_models.dart
├── services/         # Data services and utilities
│   └── data_service.dart
├── widgets/          # Reusable animated widgets
│   └── animated_header.dart
├── sections/         # Portfolio sections
│   ├── hero_section.dart
│   ├── about_section.dart
│   ├── experience_section.dart
│   ├── projects_section.dart
│   └── contact_section.dart
├── utils/           # Utilities and helpers
│   └── scroll_controller.dart
└── main.dart        # App entry point
```

## 🛠 Tech Stack

- **Flutter Web** - Modern cross-platform framework
- **Provider** - State management
- **Google Fonts** - Typography
- **Glassmorphism** - UI effects
- **Flutter Animate** - Smooth animations
- **Font Awesome** - Icons
- **URL Launcher** - External links

## 🚀 Getting Started

### 1. Install Dependencies

```bash
flutter pub get
```

### 2. Generate JSON Models

```bash
flutter packages pub run build_runner build --delete-conflicting-outputs
```

### 3. Run the App

```bash
flutter run -d chrome
```

## 📝 Configuration

### Editing Portfolio Content

Simply edit `assets/data.json` to customize your portfolio:

```json
{
  "personal": {
    "name": "Your Name",
    "title": "Your Title",
    "email": "your.email@example.com",
    "bio": "Your bio description..."
  },
  "hero": {
    "greeting": "Hi, I'm",
    "description": "Your hero description...",
    "primaryButton": {
      "text": "View My Work",
      "link": "#projects"
    }
  }
}
```

### Adding/Removing Sections

**To add a section:** Simply add the section key to `data.json`

**To remove a section:** Remove the section key from `data.json`

The navbar and section will automatically hide/show based on data availability.

### Section Keys

- `hero` - Landing section
- `about` - About and skills
- `experience` - Work experience timeline
- `projects` - Project showcase
- `contact` - Contact form and info

## 🎨 Customization

### Colors & Gradients

Update gradients in section files:

```dart
gradient: LinearGradient(
  colors: [
    Colors.blue.withOpacity(0.8),
    Colors.purple.withOpacity(0.8),
  ],
)
```

### Animations

Adjust animation durations and curves:

```dart
.animate().slideY(
  duration: 600.ms,
  curve: Curves.easeOutCubic,
)
```

### Typography

Customize fonts using Google Fonts:

```dart
GoogleFonts.inter(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: Colors.white,
)
```

## 📱 Responsive Design

The portfolio automatically adapts to:

- **Desktop** (>768px) - Full layout with side-by-side sections
- **Tablet** (768px-1024px) - Adjusted spacing and layout
- **Mobile** (<768px) - Stacked layout with optimized spacing

## 🎯 Performance Features

- **Lazy loading** of sections
- **Optimized animations** with 60fps target
- **Efficient state management** with Provider
- **Cached JSON data** for fast loading
- **Smooth scrolling** with physics-based controllers

## 🔧 Development

### Adding New Sections

1. Create section widget in `lib/sections/`
2. Add model in `lib/models/portfolio_models.dart`
3. Update conditional rendering in `main.dart`
4. Add section key to `data_service.dart`

### Custom Animations

Use `flutter_animate` for smooth animations:

```dart
.myWidget()
  .animate()
  .slideY(duration: 600.ms)
  .fadeIn(delay: 200.ms)
  .then()
  .shimmer(duration: 2000.ms)
```

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🤝 Contributing

1. Fork the project
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Open a Pull Request

## 📞 Support

For support and questions, please reach out through the contact form in the portfolio or create an issue in the repository.

---

**Built with ❤️ using Flutter Web**
