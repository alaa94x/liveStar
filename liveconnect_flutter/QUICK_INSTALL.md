# Quick Flutter Installation Guide

## Step-by-Step Installation

### Step 1: Install Flutter SDK

Open Terminal and run:

```bash
# Create development directory
mkdir -p ~/development
cd ~/development

# Clone Flutter repository
git clone https://github.com/flutter/flutter.git -b stable
```

This will download Flutter (~1.5 GB, takes a few minutes).

### Step 2: Add Flutter to PATH

For **Zsh** (macOS Catalina+ default):

```bash
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.zshrc
source ~/.zshrc
```

For **Bash**:

```bash
echo 'export PATH="$PATH:$HOME/development/flutter/bin"' >> ~/.bash_profile
source ~/.bash_profile
```

### Step 3: Verify Installation

```bash
flutter --version
```

You should see the Flutter version.

### Step 4: Run Flutter Doctor

```bash
flutter doctor
```

This will check your setup and show what's needed.

### Step 5: Accept Android Licenses (if needed)

```bash
flutter doctor --android-licenses
```

Press `y` to accept all licenses.

### Step 6: Install CocoaPods (for iOS)

```bash
sudo gem install cocoapods
```

## After Installation

Navigate to the project:

```bash
cd /Users/alaa/liveStar/liveconnect_flutter
```

Install dependencies:

```bash
flutter pub get
```

For iOS, install pods:

```bash
cd ios
pod install
cd ..
```

Run the app:

```bash
flutter run
```

## Troubleshooting

### Flutter command not found

Make sure you:
1. Added Flutter to PATH
2. Restarted your terminal
3. Or run: `source ~/.zshrc` (or `source ~/.bash_profile`)

### Xcode Command Line Tools missing

```bash
xcode-select --install
```

### CocoaPods installation fails

Try:
```bash
sudo gem install cocoapods --user-install
```

Or install via Homebrew:
```bash
brew install cocoapods
```

## Need Help?

See the detailed guide in `INSTALL_FLUTTER.md`






