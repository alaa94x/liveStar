#!/bin/bash

# Accept all Android SDK licenses automatically

export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools"

echo "📜 Accepting Android SDK licenses..."

# Accept all licenses automatically
yes | flutter doctor --android-licenses 2>&1 | grep -v "Warning:"

echo ""
echo "✅ License acceptance complete!"
echo ""
echo "Verifying setup..."
flutter doctor -v | grep -A 10 "Android toolchain"



