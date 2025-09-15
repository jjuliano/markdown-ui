import { RubyJsRubyRuntime } from "./bindgen/interfaces/ruby-js-ruby-runtime.js";
import * as RbAbi from "./bindgen/legacy/rb-abi-guest.js";
/**
 * This interface bridges between the Ruby runtime and the JavaScript runtime
 * and defines how to interact with underlying import/export functions.
 */
export interface Binding {
    rubyShowVersion(): void;
    rubyInit(args: string[]): void;
    rubyInitLoadpath(): void;
    rbEvalStringProtect(str: string): [RbAbiValue, number];
    rbFuncallvProtect(recv: RbAbiValue, mid: RbAbi.RbId, args: RbAbiValue[]): [RbAbiValue, number];
    rbIntern(name: string): RbAbi.RbId;
    rbErrinfo(): RbAbiValue;
    rbClearErrinfo(): void;
    rstringPtr(value: RbAbiValue): string;
    rbVmBugreport(): void;
    rbGcEnable(): boolean;
    rbGcDisable(): boolean;
    rbSetShouldProhibitRewind(newValue: boolean): boolean;
    setInstance(instance: WebAssembly.Instance): Promise<void>;
    addToImports(imports: WebAssembly.Imports): void;
}
export interface RbAbiValue {
}
export declare class LegacyBinding extends RbAbi.RbAbiGuest implements Binding {
    setInstance(instance: WebAssembly.Instance): Promise<void>;
}
export declare class ComponentBinding implements Binding {
    underlying: typeof RubyJsRubyRuntime;
    constructor();
    setUnderlying(underlying: typeof RubyJsRubyRuntime): void;
    rubyShowVersion(): void;
    rubyInit(args: string[]): void;
    rubyInitLoadpath(): void;
    rbEvalStringProtect(str: string): [RbAbiValue, number];
    rbFuncallvProtect(recv: RbAbiValue, mid: number, args: RbAbiValue[]): [RbAbiValue, number];
    rbIntern(name: string): number;
    rbErrinfo(): RbAbiValue;
    rbClearErrinfo(): void;
    rstringPtr(value: RbAbiValue): string;
    rbVmBugreport(): void;
    rbGcEnable(): boolean;
    rbGcDisable(): boolean;
    rbSetShouldProhibitRewind(newValue: boolean): boolean;
    setInstance(instance: WebAssembly.Instance): Promise<void>;
    addToImports(imports: WebAssembly.Imports): void;
}
