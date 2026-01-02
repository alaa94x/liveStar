#!/bin/bash

# Android SDK Setup Script for Flutter
# This script helps set up Android SDK and command-line tools

set -e

echo "🤖 Android SDK Setup Script"
echo "============================"
echo ""

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Check if Android Studio is installed
if [ -d "/Applications/Android Studio.app" ]; then
    echo -e "${GREEN}✅ Android Studio is installed${NC}"
    ANDROID_STUDIO_PATH="/Applications/Android Studio.app"
else
    echo -e "${YELLOW}⚠️  Android Studio not found in /Applications${NC}"
    echo "Please install Android Studio from: https://developer.android.com/studio"
    echo ""
    read -p "Do you want to continue with manual SDK setup? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 0
    fi
fi

# Set Android SDK location
ANDROID_HOME="$HOME/Library/Android/sdk"
ANDROID_SDK_MANAGER="$ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager"

echo ""
echo "📦 Setting up Android SDK..."

# Create Android SDK directory if it doesn't exist
mkdir -p "$ANDROID_HOME"

# Check if SDK Manager exists
if [ ! -f "$ANDROID_SDK_MANAGER" ]; then
    echo -e "${YELLOW}⚠️  Android SDK command-line tools not found${NC}"
    echo "Downloading Android SDK command-line tools..."
    
    # Create cmdline-tools directory
    mkdir -p "$ANDROID_HOME/cmdline-tools"
    cd "$ANDROID_HOME/cmdline-tools"
    
    # Download command-line tools for macOS
    echo "Downloading command-line tools..."
    
    # Check architecture
    ARCH=$(uname -m)
    if [ "$ARCH" == "arm64" ]; then
        echo "Detected Apple Silicon (arm64)"
        CMDLINE_TOOLS_URL="https://dl.google.com/android/repository/commandlinetools-mac-11076708_latest.zip"
    else
        echo "Detected Intel (x86_64)"
        CMDLINE_TOOLS_URL="https://dl.google.com/android/repository/commandlinetools-mac-11076708_latest.zip"
    fi
    
    # Download using curl
    echo "Downloading from: $CMDLINE_TOOLS_URL"
    curl -L -o cmdline-tools.zip "$CMDLINE_TOOLS_URL"
    
    if [ $? -eq 0 ]; then
        echo "Extracting..."
        unzip -q cmdline-tools.zip
        rm cmdline-tools.zip
        
        # Move to latest directory
        if [ -d "cmdline-tools" ]; then
            mv cmdline-tools latest
        else
            # Create latest directory and move contents
            mkdir -p latest
            mv bin latest/ 2>/dev/null || true
            mv lib latest/ 2>/dev/null || true
            mv NOTICE.txt latest/ 2>/dev/null || true
            mv source.properties latest/ 2>/dev/null || true
        fi
        
        echo -e "${GREEN}✅ Command-line tools installed${NC}"
    else
        echo -e "${RED}❌ Failed to download command-line tools${NC}"
        echo "Please download manually from:"
        echo "https://developer.android.com/studio#command-line-tools-only"
        exit 1
    fi
else
    echo -e "${GREEN}✅ SDK Manager already exists${NC}"
fi

# Set up environment variables
echo ""
echo "🔧 Setting up environment variables..."

SHELL_CONFIG="$HOME/.zshrc"
if [ ! -f "$SHELL_CONFIG" ]; then
    SHELL_CONFIG="$HOME/.bash_profile"
fi

# Backup
if [ -f "$SHELL_CONFIG" ]; then
    cp "$SHELL_CONFIG" "$SHELL_CONFIG.backup"
fi

# Add Android environment variables if not already present
if ! grep -q "ANDROID_HOME" "$SHELL_CONFIG" 2>/dev/null; then
    echo "" >> "$SHELL_CONFIG"
    echo "# Android SDK" >> "$SHELL_CONFIG"
    echo "export ANDROID_HOME=\"\$HOME/Library/Android/sdk\"" >> "$SHELL_CONFIG"
    echo "export PATH=\"\$PATH:\$ANDROID_HOME/cmdline-tools/latest/bin\"" >> "$SHELL_CONFIG"
    echo "export PATH=\"\$PATH:\$ANDROID_HOME/platform-tools\"" >> "$SHELL_CONFIG"
    echo "export PATH=\"\$PATH:\$ANDROID_HOME/emulator\"" >> "$SHELL_CONFIG"
    echo -e "${GREEN}✅ Added Android environment variables to $SHELL_CONFIG${NC}"
else
    echo -e "${YELLOW}⚠️  Android environment variables already exist${NC}"
fi

# Export for current session
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export PATH="$PATH:$ANDROID_HOME/emulator"

# Verify SDK Manager
if [ -f "$ANDROID_SDK_MANAGER" ]; then
    echo ""
    echo -e "${GREEN}✅ SDK Manager is now available!${NC}"
    echo ""
    echo "📋 Next steps:"
    echo "1. Restart your terminal or run: source $SHELL_CONFIG"
    echo "2. Install required SDK components:"
    echo "   $ANDROID_SDK_MANAGER --install \"platform-tools\" \"platforms;android-34\" \"build-tools;34.0.0\""
    echo "3. Accept licenses: flutter doctor --android-licenses"
    echo "4. Verify: flutter doctor"
    echo ""
else
    echo -e "${RED}❌ SDK Manager installation may have failed${NC}"
    echo "Please check the installation manually."
    exit 1
fi



