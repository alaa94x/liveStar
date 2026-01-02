# LiveConnect Flutter App - Setup Guide

## Quick Start

### 1. Install Flutter

Make sure Flutter is installed on your system:
```bash
flutter --version
```

If not installed, download from: https://flutter.dev/docs/get-started/install

### 2. Setup Dependencies

Navigate to the project directory:
```bash
cd liveconnect_flutter
```

Install Flutter dependencies:
```bash
flutter pub get
```

### 3. Platform Setup

#### For iOS Development:

1. Install Xcode from Mac App Store
2. Install CocoaPods (if not already installed):
```bash
sudo gem install cocoapods
```

3. Navigate to iOS directory and install pods:
```bash
cd ios
pod install
cd ..
```

4. Open the project in Xcode:
```bash
open ios/Runner.xcworkspace
```

#### For Android Development:

1. Install Android Studio
2. Open Android Studio and install:
   - Android SDK
   - Android SDK Platform-Tools
   - Android Emulator
   
3. Accept Android licenses:
```bash
flutter doctor --android-licenses
```

### 4. Run the App

#### On iOS Simulator:
```bash
# List available devices
flutter devices

# Run on iOS simulator
flutter run -d ios
```

#### On Android Emulator:
```bash
# Start an Android emulator first, then:
flutter run -d android
```

#### On Physical Device:

**iOS:**
- Connect iPhone/iPad via USB
- Trust the computer on your device
- Run: `flutter run -d ios`

**Android:**
- Enable Developer Options on your device
- Enable USB Debugging
- Connect via USB
- Run: `flutter run -d android`

### 5. Build for Production

#### iOS Build:
```bash
flutter build ios --release
```

Then open `ios/Runner.xcworkspace` in Xcode to archive and upload to App Store.

#### Android Build:
```bash
# Build APK
flutter build apk --release

# Build App Bundle (for Play Store)
flutter build appbundle --release
```

## Configuration

### iOS Configuration

1. **Bundle Identifier**: Update in `ios/Runner.xcodeproj` or Xcode
2. **App Name**: Update in `ios/Runner/Info.plist` (CFBundleDisplayName)
3. **Permissions**: Already configured in `Info.plist`
4. **Signing**: Configure in Xcode under Signing & Capabilities

### Android Configuration

1. **Package Name**: Update in `android/app/build.gradle` (applicationId)
2. **App Name**: Update in `android/app/src/main/AndroidManifest.xml`
3. **Permissions**: Already configured in `AndroidManifest.xml`
4. **Signing**: Create `android/app/key.properties` for release signing

### Environment Variables

Create a `.env` file in the root directory if needed:
```env
API_BASE_URL=https://api.liveconnect.app
API_KEY=your_api_key
```

## Troubleshooting

### Common Issues

1. **Flutter doctor issues:**
```bash
flutter doctor -v
```
Fix any issues reported by this command.

2. **Dependency conflicts:**
```bash
flutter clean
flutter pub get
```

3. **iOS build issues:**
```bash
cd ios
pod deintegrate
pod install
cd ..
```

4. **Android build issues:**
```bash
cd android
./gradlew clean
cd ..
```

### Platform-Specific Issues

#### iOS:
- Make sure Xcode Command Line Tools are installed
- Ensure CocoaPods is up to date: `pod repo update`

#### Android:
- Ensure Android SDK is properly configured
- Check that `ANDROID_HOME` environment variable is set
- Update `compileSdkVersion` in `build.gradle` if needed

## Development Workflow

1. **Run in Debug Mode:**
```bash
flutter run
```

2. **Hot Reload**: Press `r` in terminal
3. **Hot Restart**: Press `R` in terminal
4. **Open DevTools**: Press `d` in terminal

## Testing

Run tests:
```bash
flutter test
```

Run with coverage:
```bash
flutter test --coverage
```

## Code Analysis

Check code quality:
```bash
flutter analyze
```

Format code:
```bash
flutter format .
```

## Next Steps

- [ ] Set up backend API endpoints
- [ ] Configure Firebase (if using)
- [ ] Set up push notifications
- [ ] Configure analytics
- [ ] Set up crash reporting
- [ ] Implement authentication flow
- [ ] Integrate video streaming SDK
- [ ] Set up payment gateway for gifts

## Resources

- [Flutter Documentation](https://flutter.dev/docs)
- [Dart Documentation](https://dart.dev/guides)
- [Flutter Packages](https://pub.dev/)
- [Flutter Community](https://flutter.dev/community)

## Support

For issues or questions, please open an issue on GitHub or contact the development team.

