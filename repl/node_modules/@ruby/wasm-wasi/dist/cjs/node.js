"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.DefaultRubyVM = void 0;
const wasi_1 = require("wasi");
const vm_js_1 = require("./vm.js");
const DefaultRubyVM = async (rubyModule, options = {}) => {
    const wasi = new wasi_1.WASI({ env: options.env, version: "preview1", returnOnExit: true });
    const { vm, instance } = await vm_js_1.RubyVM.instantiateModule({ module: rubyModule, wasip1: wasi });
    return {
        vm,
        wasi,
        instance,
    };
};
exports.DefaultRubyVM = DefaultRubyVM;
