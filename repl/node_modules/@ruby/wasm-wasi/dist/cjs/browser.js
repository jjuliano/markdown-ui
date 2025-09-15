"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.DefaultRubyVM = void 0;
const browser_wasi_shim_1 = require("@bjorn3/browser_wasi_shim");
const console_js_1 = require("./console.js");
const vm_js_1 = require("./vm.js");
const DefaultRubyVM = async (rubyModule, options = {}) => {
    var _a, _b;
    const args = [];
    const env = Object.entries((_a = options.env) !== null && _a !== void 0 ? _a : {}).map(([k, v]) => `${k}=${v}`);
    const fds = [
        new browser_wasi_shim_1.OpenFile(new browser_wasi_shim_1.File([])),
        new browser_wasi_shim_1.OpenFile(new browser_wasi_shim_1.File([])),
        new browser_wasi_shim_1.OpenFile(new browser_wasi_shim_1.File([])),
        new browser_wasi_shim_1.PreopenDirectory("/", new Map()),
    ];
    const wasi = new browser_wasi_shim_1.WASI(args, env, fds, { debug: false });
    const printer = ((_b = options.consolePrint) !== null && _b !== void 0 ? _b : true) ? (0, console_js_1.consolePrinter)() : undefined;
    const { vm, instance } = await vm_js_1.RubyVM.instantiateModule({
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
exports.DefaultRubyVM = DefaultRubyVM;
