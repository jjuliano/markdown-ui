#!/bin/bash

# GitHub Pages Deployment Script for MarkdownUI WebAssembly Demo

echo "🚀 Preparing MarkdownUI WebAssembly Demo for GitHub Pages deployment..."

# Ensure we're in the right directory
if [ ! -f "demo.html" ]; then
    echo "❌ Error: demo.html not found. Please run this script from the repl directory."
    exit 1
fi

# Check if build directories exist
if [ ! -d "build" ]; then
    echo "❌ Error: build directory not found."
    exit 1
fi

echo "✅ Building GitHub Pages deployment..."

# Use npm build command to create the build directory
npm run build

# Ensure all required files are present
echo "📁 Checking required files..."

REQUIRED_FILES=(
    "build/index.html"
    "build/js/ruby-wasm-integration.js"
    "build/markdown-ui.wasm"
)

for file in "${REQUIRED_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "✅ $file"
    else
        echo "❌ Missing: $file"
        exit 1
    fi
done

echo ""
echo "🎉 GitHub Pages deployment ready!"
echo ""
echo "📋 Next steps:"
echo "1. Push the build/ directory to your GitHub repository's gh-pages branch"
echo "2. Enable GitHub Pages in your repository settings"
echo "3. Set the source to 'Deploy from a branch' and select 'gh-pages'"
echo ""
echo "📂 Files ready in: build/"
echo "🌐 Once deployed, your demo will be available at: https://yourusername.github.io/your-repo-name/"
echo ""

# Optional: Create a README for the build directory
cat > build/README.md << 'EOF'
# MarkdownUI WebAssembly Demo

This directory contains a fully client-side MarkdownUI parser powered by Ruby WebAssembly.

## Features

- ✅ Pure client-side execution (no server required)
- ✅ Full MarkdownUI syntax support
- ✅ WebAssembly for optimal performance
- ✅ GitHub Pages compatible
- ✅ Offline capable

## Files

- `index.html` - Main demo interface
- `js/ruby-wasm-integration.js` - WebAssembly integration layer
- `markdown-ui.wasm` - Ruby WebAssembly runtime with MarkdownUI

## Usage

Simply open `index.html` in a web browser. The WebAssembly will load automatically and you can start parsing MarkdownUI syntax immediately.

## Deployment

This directory is ready for GitHub Pages deployment. Just push it to the `gh-pages` branch of your repository.
EOF

echo "✅ Created README.md for gh-pages directory"
echo ""
echo "🔧 To test locally before deployment:"
echo "   npm run serve"
echo "   Then visit: http://localhost:8080"