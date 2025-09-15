/**
 * Create a console printer that can be used as an overlay of WASI imports.
 * See the example below for how to use it.
 *
 * ```javascript
 * const imports = {
 *  "wasi_snapshot_preview1": wasi.wasiImport,
 * }
 * const printer = consolePrinter();
 * printer.addToImports(imports);
 *
 * const instance = await WebAssembly.instantiate(module, imports);
 * printer.setMemory(instance.exports.memory);
 * ```
 *
 * Note that the `stdout` and `stderr` functions are called with text, not
 * bytes. This means that bytes written to stdout/stderr will be decoded as
 * UTF-8 and then passed to the `stdout`/`stderr` functions every time a write
 * occurs without buffering.
 *
 * @param stdout A function that will be called when stdout is written to.
 *               Defaults to `console.log`.
 * @param stderr A function that will be called when stderr is written to.
 *               Defaults to `console.warn`.
 * @returns An object that can be used as an overlay of WASI imports.
 */
export declare function consolePrinter({ stdout, stderr, }?: {
    stdout: (str: string) => void;
    stderr: (str: string) => void;
}): {
    addToImports(imports: WebAssembly.Imports): void;
    setMemory(m: WebAssembly.Memory): void;
};
