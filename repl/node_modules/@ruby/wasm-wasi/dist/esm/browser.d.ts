import { WASI } from "@bjorn3/browser_wasi_shim";
import { RubyVM } from "./vm.js";
export declare const DefaultRubyVM: (rubyModule: WebAssembly.Module, options?: {
    consolePrint?: boolean;
    env?: Record<string, string> | undefined;
}) => Promise<{
    vm: RubyVM;
    wasi: WASI;
    instance: WebAssembly.Instance;
}>;
