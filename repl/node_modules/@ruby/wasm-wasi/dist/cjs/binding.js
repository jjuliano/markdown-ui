"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ComponentBinding = exports.LegacyBinding = void 0;
const tslib_1 = require("tslib");
const RbAbi = tslib_1.__importStar(require("./bindgen/legacy/rb-abi-guest.js"));
class LegacyBinding extends RbAbi.RbAbiGuest {
    async setInstance(instance) {
        await this.instantiate(instance);
    }
}
exports.LegacyBinding = LegacyBinding;
class ComponentBinding {
    constructor() { }
    setUnderlying(underlying) {
        this.underlying = underlying;
    }
    rubyShowVersion() {
        this.underlying.rubyShowVersion();
    }
    rubyInit(args) {
        this.underlying.rubyInit(args);
    }
    rubyInitLoadpath() {
        this.underlying.rubyInitLoadpath();
    }
    rbEvalStringProtect(str) {
        return this.underlying.rbEvalStringProtect(str);
    }
    rbFuncallvProtect(recv, mid, args) {
        return this.underlying.rbFuncallvProtect(recv, mid, args);
    }
    rbIntern(name) {
        return this.underlying.rbIntern(name);
    }
    rbErrinfo() {
        return this.underlying.rbErrinfo();
    }
    rbClearErrinfo() {
        return this.underlying.rbClearErrinfo();
    }
    rstringPtr(value) {
        return this.underlying.rstringPtr(value);
    }
    rbVmBugreport() {
        this.underlying.rbVmBugreport();
    }
    rbGcEnable() {
        return this.underlying.rbGcEnable();
    }
    rbGcDisable() {
        return this.underlying.rbGcDisable();
    }
    rbSetShouldProhibitRewind(newValue) {
        return this.underlying.rbSetShouldProhibitRewind(newValue);
    }
    async setInstance(instance) {
        // No-op
    }
    addToImports(imports) {
        // No-op
    }
}
exports.ComponentBinding = ComponentBinding;
