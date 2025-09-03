import { DefaultRubyVM } from "./browser.js";
import { RubyComponentInstantiator } from "./vm.js";
/**
 * The main entry point of `<script type="text/ruby">`-based scripting with WebAssembly Core Module.
 */
export declare const main: (pkg: {
    name: string;
    version: string;
}, options?: Parameters<typeof DefaultRubyVM>[1]) => Promise<void>;
/**
 * The main entry point of `<script type="text/ruby">`-based scripting with WebAssembly Component.
 */
export declare const componentMain: (pkg: {
    name: string;
    version: string;
}, options: {
    instantiate: RubyComponentInstantiator;
    wasip2: any;
}) => Promise<void>;
