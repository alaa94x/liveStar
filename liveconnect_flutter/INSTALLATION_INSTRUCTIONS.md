# Flutter Installation Instructions

I've created installation scripts and guides for you. Here's what you need to do:

## Quick Installation (Recommended)

### Method 1: Using the Installation Script

1. **Run the installation script**:
   ```bash
   cd /Users/alaa/liveStar/liveconnect_flutter
   ./install_flutter.sh
   ```

   This script will:
   - Check if Flutter is already installed
   - Install Flutter SDK to `~/development/flutter`
   - Add Flutter to your PATH
   - Run `flutter doctor` to check setup

### Method 2: Manual Installation

If you prefer manual installation or the script doesn't work:

```bash
# Step 1: Create development directory
mkdir -p ~/development
cd ~/development

# Step 2: Clone Flutter repository (this may take a few minutes)
git clone https://github.com/flutter/flutter.git -b stable

# Step 3: Add Flutter to PATH (for Zsh - default on macOS Catalina+)
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.zshrc

# Step 4: Reload shell configuration
source ~/.zshrc

# Step 5: Verify installation
flutter --version

# Step 6: Run Flutter doctor
flutter doctor
```

## After Flutter Installation

### 1. Navigate to Project
```bash
cd /Users/alaa/liveStar/liveconnect_flutter
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Setup iOS (if developing for iOS)

Install CocoaPods:
```bash
sudo gem install cocoapods
```

Install iOS pods:
```bash
cd ios
pod install
cd ..
```

### 4. Setup Android (if developing for Android)

Accept Android licenses:
```bash
flutter doctor --android-licenses
```

Press `y` to accept all licenses.

### 5. Run the App

```bash
# See available devices
flutter devices

# Run on connected device or simulator
flutter run

# Or specify platform
flutter run -d ios        # For iOS
flutter run -d android    # For Android
```

## Verify Installation

Run this check script:
```bash
cd /Users/alaa/liveStar/liveconnect_flutter
./check_flutter.sh
```

Or manually check:
```bash
flutter --version
flutter doctor
```

## Common Issues & Solutions

### Issue: Flutter command not found

**Solution**:
```bash
# Add Flutter to PATH manually
export PATH="$PATH:$HOME/development/flutter/bin"

# Or reload shell config
source ~/.zshrc
```

### Issue: Xcode Command Line Tools missing

**Solution**:
```bash
xcode-select --install
```

### Issue: CocoaPods not found

**Solution**:
```bash
sudo gem install cocoapods
```

Or via Homebrew:
```bash
brew install cocoapods
```

### Issue: Android SDK not found

**Solution**:
1. Install Android Studio
2. Set ANDROID_HOME:
   ```bash
   export ANDROID_HOME=$HOME/Library/Android/sdk
   export PATH=$PATH:$ANDROID_HOME/platform-tools
   ```
3. Run `flutter doctor` again

## What's Installed?

After installation, you should have:

✅ Flutter SDK in `~/development/flutter`
✅ Flutter added to PATH
✅ Ability to run `flutter` command
✅ Development environment ready

## Next Steps

1. ✅ Install Flutter SDK
2. ✅ Run `flutter pub get` in project
3. ✅ Set up iOS/Android platforms (if needed)
4. ✅ Run the app: `flutter run`
5. ✅ Start developing!

## Resources

- **Detailed Guide**: See `INSTALL_FLUTTER.md`
- **Quick Guide**: See `QUICK_INSTALL.md`
- **Setup Guide**: See `SETUP_GUIDE.md`
- **Flutter Docs**: https://docs.flutter.dev/get-started/install/macos

## Need Help?

If you encounter issues:
1. Run `flutter doctor -v` to see detailed diagnostics
2. Check Flutter documentation: https://docs.flutter.dev/get-started/install/macos
3. Check troubleshooting section in `INSTALL_FLUTTER.md`

---

**Status**: Installation scripts and guides are ready!  
**Action Required**: Run the installation script or follow manual steps above.






