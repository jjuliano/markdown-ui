console.warn(`[33mDEPRECATED(ruby-3.4-wasm-wasi): "dist/node" will be moved to "@ruby/wasm-wasi" in the next major release.
Please replace your \`import * from 'ruby-3.4-wasm-wasi/dist/node';\` with \`import * from '@ruby/wasm-wasi/dist/node';\`[0m`);

export * from '@ruby/wasm-wasi/dist/node';