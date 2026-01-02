#!/bin/bash

# Flutter Installation Script for macOS
# This script installs Flutter SDK and sets up the environment

set -e

echo "🚀 LiveConnect Flutter Installation Script"
echo "==========================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if Flutter is already installed
if command -v flutter &> /dev/null; then
    echo -e "${GREEN}✅ Flutter is already installed!${NC}"
    flutter --version
    flutter doctor
    exit 0
fi

# Check for prerequisites
echo "📋 Checking prerequisites..."

# Check for Git
if ! command -v git &> /dev/null; then
    echo -e "${RED}❌ Git is not installed.${NC}"
    echo "Please install Git first: https://git-scm.com/download/mac"
    exit 1
fi
echo -e "${GREEN}✅ Git is installed${NC}"

# Check for Xcode Command Line Tools (for macOS)
if [ "$(uname)" == "Darwin" ]; then
    if ! xcode-select -p &> /dev/null; then
        echo -e "${YELLOW}⚠️  Xcode Command Line Tools are not installed.${NC}"
        echo "Installing Xcode Command Line Tools..."
        xcode-select --install
        echo "Please wait for installation to complete, then run this script again."
        exit 0
    fi
    echo -e "${GREEN}✅ Xcode Command Line Tools are installed${NC}"
fi

# Set Flutter installation directory
FLUTTER_HOME="$HOME/development"
FLUTTER_PATH="$FLUTTER_HOME/flutter"

echo ""
echo "📦 Installing Flutter SDK..."

# Create development directory if it doesn't exist
mkdir -p "$FLUTTER_HOME"
cd "$FLUTTER_HOME"

# Check if Flutter directory already exists
if [ -d "flutter" ]; then
    echo -e "${YELLOW}⚠️  Flutter directory already exists.${NC}"
    read -p "Do you want to reinstall? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        rm -rf flutter
    else
        echo "Using existing Flutter installation."
        FLUTTER_PATH="$FLUTTER_HOME/flutter"
    fi
fi

# Clone Flutter repository if not exists
if [ ! -d "flutter" ]; then
    echo "Cloning Flutter repository (this may take a few minutes)..."
    git clone https://github.com/flutter/flutter.git -b stable
    echo -e "${GREEN}✅ Flutter repository cloned${NC}"
else
    echo "Flutter directory already exists, skipping clone."
fi

# Add Flutter to PATH
echo ""
echo "🔧 Setting up environment variables..."

# Determine shell config file
SHELL_CONFIG=""
if [ -n "$ZSH_VERSION" ]; then
    SHELL_CONFIG="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
    SHELL_CONFIG="$HOME/.bash_profile"
else
    SHELL_CONFIG="$HOME/.zshrc"
fi

# Backup existing config
if [ -f "$SHELL_CONFIG" ]; then
    cp "$SHELL_CONFIG" "$SHELL_CONFIG.backup"
fi

# Add Flutter to PATH if not already added
if ! grep -q "flutter/bin" "$SHELL_CONFIG" 2>/dev/null; then
    echo "" >> "$SHELL_CONFIG"
    echo "# Flutter SDK" >> "$SHELL_CONFIG"
    echo "export PATH=\"\$PATH:$FLUTTER_PATH/bin\"" >> "$SHELL_CONFIG"
    echo -e "${GREEN}✅ Added Flutter to PATH in $SHELL_CONFIG${NC}"
else
    echo -e "${YELLOW}⚠️  Flutter PATH already exists in $SHELL_CONFIG${NC}"
fi

# Export PATH for current session
export PATH="$PATH:$FLUTTER_PATH/bin"

# Run Flutter doctor
echo ""
echo "🏥 Running Flutter doctor..."
echo ""

# Check if Flutter is now available
if command -v flutter &> /dev/null; then
    flutter doctor
    
    echo ""
    echo -e "${GREEN}✅ Flutter installation complete!${NC}"
    echo ""
    echo "📝 Next steps:"
    echo "1. Restart your terminal or run: source $SHELL_CONFIG"
    echo "2. Run 'flutter doctor' to verify installation"
    echo "3. Accept Android licenses: flutter doctor --android-licenses"
    echo "4. Navigate to the project: cd liveconnect_flutter"
    echo "5. Install dependencies: flutter pub get"
    echo "6. Run the app: flutter run"
    echo ""
else
    echo -e "${RED}❌ Flutter installation failed${NC}"
    echo "Please try running this script again or install Flutter manually."
    echo "See: https://docs.flutter.dev/get-started/install/macos"
    exit 1
fi






