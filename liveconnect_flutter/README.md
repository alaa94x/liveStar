# LiveConnect Flutter App

A modern live streaming mobile application built with Flutter for iOS and Android.

## Features

- 🎥 Live Streaming
- 💬 Real-time Chat
- 🎁 Virtual Gift Economy
- 👥 Social Features
- 💰 Monetization (Wallet & Rewards)
- 📱 Cross-Platform (iOS & Android)

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK (3.0.0 or higher)
- Android Studio / Xcode (for platform-specific builds)
- iOS 12.0+ / Android API 21+

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd liveconnect_flutter
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
# For iOS
flutter run -d ios

# For Android
flutter run -d android

# Or run on connected device
flutter run
```

### Build for Production

#### iOS
```bash
flutter build ios
```

#### Android
```bash
flutter build apk
# or
flutter build appbundle
```

## Project Structure

```
lib/
├── core/
│   ├── models/          # Data models
│   ├── providers/       # State management
│   ├── routing/         # Navigation configuration
│   ├── theme/           # App theme and colors
│   └── widgets/          # Reusable widgets
├── features/
│   ├── auth/            # Authentication screens
│   ├── home/            # Home feed
│   ├── live_stream/     # Live streaming
│   ├── messages/        # Chat functionality
│   ├── profile/         # User profiles
│   ├── gifts/           # Gift store
│   ├── rewards/         # Rewards system
│   ├── wallet/          # Wallet management
│   └── ...
└── main.dart            # App entry point
```

## Design System

The app follows the LiveConnect design system with:
- **Primary Colors**: Purple (#C700FF) to Pink (#FF2D92) gradient
- **Theme**: Dark mode with vibrant accents
- **Typography**: Inter font family
- **Components**: Material Design 3 with custom styling

## Cross-Platform Support

### iOS Configuration
- Minimum iOS version: 12.0
- Supports iPhone and iPad
- Camera and microphone permissions configured
- Photo library access for media sharing

### Android Configuration
- Minimum SDK: 21 (Android 5.0)
- Target SDK: 34 (Android 14)
- Permissions for camera, microphone, storage
- Notification support for Android 13+

## Dependencies

Key dependencies:
- `go_router` - Navigation
- `provider` - State management
- `cached_network_image` - Image caching
- `animations` - Smooth animations
- `http` / `dio` - Networking

See `pubspec.yaml` for complete list.

## Development

### Running Tests
```bash
flutter test
```

### Code Analysis
```bash
flutter analyze
```

### Format Code
```bash
flutter format .
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For support, email support@liveconnect.app or join our Discord community.

---

Built with ❤️ using Flutter

