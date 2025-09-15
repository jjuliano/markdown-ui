import { WASI } from "wasi";
import { RubyVM } from "./vm.js";
export const DefaultRubyVM = async (rubyModule, options = {}) => {
    const wasi = new WASI({ env: options.env, version: "preview1", returnOnExit: true });
    const { vm, instance } = await RubyVM.instantiateModule({ module: rubyModule, wasip1: wasi });
    return {
        vm,
        wasi,
        instance,
    };
};
