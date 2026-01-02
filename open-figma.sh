#!/bin/bash

# Script to open a Figma file or URL in the browser
# Usage: ./open-figma.sh <figma-url-or-file-id>

if [ -z "$1" ]; then
  echo "Error: Please provide a Figma URL or file ID"
  echo ""
  echo "Usage: ./open-figma.sh <figma-url-or-file-id>"
  echo ""
  echo "Examples:"
  echo "  ./open-figma.sh https://www.figma.com/file/abc123/My-Design"
  echo "  ./open-figma.sh abc123def456"
  exit 1
fi

FIGMA_INPUT="$1"

# Determine if input is a URL or file ID
if [[ "$FIGMA_INPUT" == http* ]]; then
  FIGMA_URL="$FIGMA_INPUT"
else
  FIGMA_URL="https://www.figma.com/file/$FIGMA_INPUT"
fi

echo "Opening Figma URL: $FIGMA_URL"

# Open in default browser
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  open "$FIGMA_URL"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux
  xdg-open "$FIGMA_URL"
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "cygwin" ]]; then
  # Windows
  start "$FIGMA_URL"
else
  echo "Error: Unsupported operating system"
  exit 1
fi

echo "Figma file opened in your default browser!"

