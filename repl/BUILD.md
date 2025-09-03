# Build System for MarkdownUI WebAssembly Demo

This document describes the clean build system for the MarkdownUI WebAssembly demo.

## Overview

The build system creates a clean `build/` directory containing only the files needed for GitHub Pages deployment:

```
build/
├── index.html                    # Main demo interface 
├── js/
│   └── ruby-wasm-integration.js  # WebAssembly integration
└── markdown-ui.wasm             # Ruby WebAssembly runtime (when built)
```

## Build Commands

### Quick Build (without WebAssembly)
```bash
npm run build:quick
```
- Creates build directory with HTML and JS files
- Skips WebAssembly compilation (faster for UI testing)

### Full Build (with WebAssembly)
```bash
npm run build
```
- Runs WebAssembly build script first
- Creates complete deployment-ready build
- Includes .wasm file

### Clean Build
```bash
npm run clean      # Remove build directory
npm run rebuild    # Clean + full build
```

### Testing
```bash
npm run serve      # Serve build directory on :8080
npm run dev        # Serve current directory on :8000
npm run test:local # Build + serve
```

### Deployment
```bash
npm run deploy     # Build + deployment instructions
```

## WebAssembly Integration

The WebAssembly integration (`js/ruby-wasm-integration.js`) supports multiple execution modes:

1. **Server-side**: Uses wasmtime-rb (when server available)
2. **Browser-side**: Direct .wasm file loading (with SharedArrayBuffer)
3. **CDN Fallback**: Uses @ruby/wasm-wasi from CDN

## GitHub Pages Deployment

1. Run `npm run build` to create deployment files
2. Push `build/` directory contents to your `gh-pages` branch
3. Enable GitHub Pages in repository settings
4. Set source to "Deploy from branch: gh-pages"

## File Structure

- `demo.html` → `build/index.html` (main interface)
- `js/ruby-wasm-integration.js` → `build/js/` (WebAssembly layer)
- Generated `.wasm` files → `build/` (Ruby runtime)

The build directory contains **only** the files needed for deployment, with no extra development files or nested folder structures.