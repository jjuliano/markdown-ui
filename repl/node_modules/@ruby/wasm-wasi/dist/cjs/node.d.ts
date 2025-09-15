import { WASI } from "wasi";
import { RubyVM } from "./vm.js";
export declare const DefaultRubyVM: (rubyModule: WebAssembly.Module, options?: {
    env?: Record<string, string> | undefined;
}) => Promise<{
    vm: RubyVM;
    wasi: WASI;
    instance: WebAssembly.Instance;
}>;
