console.warn(`[33mDEPRECATED(ruby-3.4-wasm-wasi): "dist/browser.script" will be moved to "@ruby/wasm-wasi" in the next major release.
Please replace your \`require('ruby-3.4-wasm-wasi/dist/browser.script');\` with \`require('@ruby/wasm-wasi/dist/browser.script');\`[0m`);

module.exports = require('@ruby/wasm-wasi/dist/browser.script');