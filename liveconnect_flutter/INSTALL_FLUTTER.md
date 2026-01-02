# Flutter Installation Guide

This guide will help you install Flutter SDK on macOS for the LiveConnect app.

## Quick Installation

### Option 1: Automatic Installation (Recommended)

Run the installation script:

```bash
cd liveconnect_flutter
./install_flutter.sh
```

### Option 2: Manual Installation

Follow the steps below for manual installation.

## Prerequisites

Before installing Flutter, ensure you have:

1. **Git** - For cloning repositories
2. **Xcode Command Line Tools** - Required for iOS development

### Check Prerequisites

```bash
# Check Git
git --version

# Check Xcode Command Line Tools
xcode-select -p
```

If Xcode Command Line Tools are not installed, run:
```bash
xcode-select --install
```

## Installation Steps

### 1. Download Flutter SDK

```bash
# Create a development directory
mkdir -p ~/development
cd ~/development

# Clone Flutter repository
git clone https://github.com/flutter/flutter.git -b stable
```

### 2. Add Flutter to PATH

Add Flutter to your PATH environment variable.

#### For Zsh (default on macOS Catalina+):

```bash
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.zshrc
source ~/.zshrc
```

#### For Bash:

```bash
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.bash_profile
source ~/.bash_profile
```

### 3. Verify Installation

```bash
# Check Flutter version
flutter --version

# Run Flutter doctor
flutter doctor
```

### 4. Accept Android Licenses (if developing for Android)

```bash
flutter doctor --android-licenses
```

Press `y` to accept all licenses.

### 5. Install CocoaPods (for iOS development)

```bash
sudo gem install cocoapods
```

## Platform-Specific Setup

### iOS Development Setup

1. **Install Xcode**:
   - Download from Mac App Store
   - Open Xcode and accept license: `sudo xcodebuild -license accept`

2. **Install CocoaPods**:
   ```bash
   sudo gem install cocoapods
   ```

3. **Install iOS Simulator**:
   - Xcode includes iOS Simulator
   - Launch via: `open -a Simulator`

### Android Development Setup

1. **Install Android Studio**:
   - Download from https://developer.android.com/studio
   - Install Android SDK, Android SDK Platform-Tools

2. **Set Android Environment Variables**:
   ```bash
   # Add to ~/.zshrc or ~/.bash_profile
   export ANDROID_HOME=$HOME/Library/Android/sdk
   export PATH=$PATH:$ANDROID_HOME/emulator
   export PATH=$PATH:$ANDROID_HOME/platform-tools
   export PATH=$PATH:$ANDROID_HOME/tools
   export PATH=$PATH:$ANDROID_HOME/tools/bin
   ```

3. **Accept Android Licenses**:
   ```bash
   flutter doctor --android-licenses
   ```

## Verify Installation

Run Flutter doctor to check everything:

```bash
flutter doctor -v
```

You should see checkmarks (✓) for:
- Flutter
- Android toolchain (if developing for Android)
- Xcode (if developing for iOS)
- Chrome (optional, for web development)

## Troubleshooting

### Flutter command not found

1. Make sure you've added Flutter to PATH
2. Restart your terminal
3. Verify PATH: `echo $PATH`

### Xcode Command Line Tools not found

```bash
xcode-select --install
```

### CocoaPods not found

```bash
sudo gem install cocoapods
```

### Android SDK not found

1. Install Android Studio
2. Set ANDROID_HOME environment variable
3. Run `flutter doctor` again

### Permissions issues

```bash
# For CocoaPods
sudo gem install cocoapods

# For Flutter
chmod +x ~/development/flutter/bin/flutter
```

## Next Steps

After Flutter is installed:

1. **Navigate to project**:
   ```bash
   cd liveconnect_flutter
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **For iOS, install pods**:
   ```bash
   cd ios
   pod install
   cd ..
   ```

4. **Run the app**:
   ```bash
   flutter run
   ```

## Additional Resources

- [Flutter Official Docs](https://docs.flutter.dev/get-started/install/macos)
- [Flutter Installation Troubleshooting](https://docs.flutter.dev/get-started/install/macos#troubleshooting)
- [Flutter Setup for Android](https://docs.flutter.dev/get-started/install/macos#android-setup)
- [Flutter Setup for iOS](https://docs.flutter.dev/get-started/install/macos#ios-setup)

## Quick Commands Reference

```bash
# Check Flutter version
flutter --version

# Check Flutter setup
flutter doctor

# Update Flutter
flutter upgrade

# Check connected devices
flutter devices

# Run app
flutter run

# Build for iOS
flutter build ios

# Build for Android
flutter build apk
```






