export function data_view(mem: any): DataView<ArrayBuffer>;
export function to_uint32(val: any): number;
export function utf8_encode(s: any, realloc: any, memory: any): number;
export function throw_invalid_bool(): void;
export const UTF8_DECODER: TextDecoder;
export let UTF8_ENCODED_LEN: number;
export class Slab {
    list: any[];
    head: number;
    insert(val: any): number;
    get(idx: any): any;
    remove(idx: any): any;
}
