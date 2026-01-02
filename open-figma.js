#!/usr/bin/env node

/**
 * Script to open a Figma file or URL in the browser
 * Usage: node open-figma.js <figma-url-or-file-id>
 */

const { exec } = require('child_process');

// Get the URL or file ID from command line arguments
const figmaInput = process.argv[2];

if (!figmaInput) {
  console.error('Error: Please provide a Figma URL or file ID');
  console.log('\nUsage: node open-figma.js <figma-url-or-file-id>');
  console.log('\nExamples:');
  console.log('  node open-figma.js https://www.figma.com/file/abc123/My-Design');
  console.log('  node open-figma.js abc123def456');
  process.exit(1);
}

// Determine if input is a URL or file ID
let figmaUrl;

if (figmaInput.startsWith('http')) {
  // It's already a URL
  figmaUrl = figmaInput;
} else {
  // Assume it's a file ID and construct the URL
  figmaUrl = `https://www.figma.com/file/${figmaInput}`;
}

console.log(`Opening Figma URL: ${figmaUrl}`);

// Open in default browser (works on macOS, Linux, Windows)
const command = process.platform === 'win32' 
  ? `start ${figmaUrl}`
  : `open "${figmaUrl}"`;

exec(command, (error) => {
  if (error) {
    console.error(`Error opening Figma URL: ${error.message}`);
    process.exit(1);
  } else {
    console.log('Figma file opened in your default browser!');
  }
});

