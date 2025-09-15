# GitHub Pages Deployment Guide

This guide explains how to deploy the MarkdownUI Online REPL to GitHub Pages with full Ruby WebAssembly support.

## 🚀 Quick Deploy

### Option 1: Manual Deployment

1. **Build the GitHub Pages version:**
   ```bash
   cd repl
   npm run build:gh-pages
   ```

2. **Copy files to your repository:**
   ```bash
   # Create a new repository or use existing one
   git clone https://github.com/yourusername/markdown-ui-repl.git
   cd markdown-ui-repl

   # Copy the GitHub Pages build
   cp -r /path/to/markdown-ui/repl/build/gh-pages/* .

   # Add and commit
   git add .
   git commit -m "Deploy MarkdownUI REPL"
   git push origin main
   ```

3. **Enable GitHub Pages:**
   - Go to your repository on GitHub
   - Navigate to Settings → Pages
   - Select "Deploy from a branch"
   - Choose `main` branch and `/ (root)` folder
   - Click Save

4. **Access your REPL:**
   Your REPL will be available at: `https://yourusername.github.io/markdown-ui-repl/`

### Option 2: Automatic Deployment with GitHub Actions

1. **Set up the workflow:**
   - Copy the `.github/workflows/deploy.yml` file to your repository
   - The workflow will automatically build and deploy on every push to main

2. **Configure GitHub Pages:**
   - Go to repository Settings → Pages
   - Select "GitHub Actions" as the source

3. **Deploy:**
   ```bash
   git add .
   git commit -m "Add GitHub Pages deployment"
   git push origin main
   ```

## 🔧 Technical Details

### SharedArrayBuffer Support

GitHub Pages has limitations with SharedArrayBuffer due to security policies. The build includes:

- **COEP Headers**: `Cross-Origin-Embedder-Policy: require-corp`
- **COOP Headers**: `Cross-Origin-Opener-Policy: same-origin`
- **Fallback System**: Automatic fallback to textarea editor if WebAssembly fails

### File Structure

The GitHub Pages build includes:
```
gh-pages/
├── index.html          # Main REPL interface with proper headers
├── .nojekyll          # Prevents Jekyll processing
├── css/
│   └── repl.css       # Custom styles
├── js/
│   ├── ruby-wasm-integration.js  # WebAssembly integration
│   └── repl-interface.js         # REPL logic
├── lib/
│   └── ...            # Ruby library files
├── examples/
│   └── ...            # Sample MarkdownUI files
└── build-info.json    # Build metadata
```

### CDN Dependencies

The REPL uses CDNs for:
- **Semantic UI**: `https://cdn.jsdelivr.net/npm/semantic-ui@2.4.2/`
- **Monaco Editor**: `https://unpkg.com/monaco-editor@0.45.0/`
- **Ruby WebAssembly**: `https://cdn.jsdelivr.net/npm/@ruby/wasm-wasi@2.7.1/`

## 🐛 Troubleshooting

### WebAssembly Not Loading

If Ruby WebAssembly fails to load:
1. ✅ The REPL **automatically falls back** to a textarea editor
2. ✅ **All functionality remains** - live preview, element browser, export
3. ✅ Check browser console for detailed error messages

### CORS Issues

For local development, use:
```bash
cd repl/build/gh-pages
python -m http.server 8000
```

### Build Issues

If the build fails:
```bash
# Clean and rebuild
cd repl
npm run clean
npm run build:gh-pages
```

## 🌐 Custom Domain

To use a custom domain:
1. Add a `CNAME` file to your repository root:
   ```
   your-domain.com
   ```

2. Configure DNS settings to point to GitHub Pages

3. Update the workflow file with your domain:
   ```yaml
   with:
     github_token: ${{ secrets.GITHUB_TOKEN }}
     publish_dir: ./repl/build/gh-pages
     cname: your-domain.com
   ```

## 📊 Performance

### Optimization Features

- **Lazy Loading**: Ruby files loaded on-demand
- **CDN Delivery**: Fast global content delivery
- **Compression**: GitHub Pages automatically compresses assets
- **Caching**: Browser caching for improved performance

### Bundle Size

- **Ruby Library**: ~500KB (gzipped)
- **Web Assets**: ~200KB (gzipped)
- **Total**: ~700KB initial load

## 🔒 Security

### Content Security Policy

The build includes appropriate CSP headers for:
- Script loading from CDNs
- WebAssembly execution
- Monaco Editor functionality

### HTTPS Only

GitHub Pages enforces HTTPS, ensuring secure delivery.

## 📈 Analytics

To add analytics, include your tracking code in the `index.html` file before the closing `</body>` tag.

## 🆘 Support

If you encounter issues:

1. **Check the build logs** for compilation errors
2. **Test locally first** before deploying
3. **Verify browser compatibility** (Chrome, Firefox, Safari)
4. **Check GitHub Pages status** for any outages

---

**Ready to deploy?** Run `npm run build:gh-pages` and push to GitHub! 🚀

