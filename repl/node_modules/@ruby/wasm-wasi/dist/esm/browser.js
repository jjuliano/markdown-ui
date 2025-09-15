import { File, OpenFile, PreopenDirectory, WASI } from "@bjorn3/browser_wasi_shim";
import { consolePrinter } from "./console.js";
import { RubyVM } from "./vm.js";
export const DefaultRubyVM = async (rubyModule, options = {}) => {
    var _a, _b;
    const args = [];
    const env = Object.entries((_a = options.env) !== null && _a !== void 0 ? _a : {}).map(([k, v]) => `${k}=${v}`);
    const fds = [
        new OpenFile(new File([])),
        new OpenFile(new File([])),
        new OpenFile(new File([])),
        new PreopenDirectory("/", new Map()),
    ];
    const wasi = new WASI(args, env, fds, { debug: false });
    const printer = ((_b = options.consolePrint) !== null && _b !== void 0 ? _b : true) ? consolePrinter() : undefined;
    const { vm, instance } = await RubyVM.instantiateModule({
        module: rubyModule, wasip1: wasi,
        addToImports: (imports) => {
            printer === null || printer === void 0 ? void 0 : printer.addToImports(imports);
        },
        setMemory: (memory) => {
            printer === null || printer === void 0 ? void 0 : printer.setMemory(memory);
        }
    });
    return {
        vm,
        wasi,
        instance,
    };
};
