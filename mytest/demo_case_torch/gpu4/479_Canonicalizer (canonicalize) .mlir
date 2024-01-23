
vm.func private @__init() {
  %c527363 = vm.const.i32 527363
  %c48 = vm.const.i32 48
  %null = vm.const.ref.zero : !vm.ref<!hal.fence>
  %null_0 = vm.const.ref.zero : !vm.ref<!hal.executable>
  %null_1 = vm.const.ref.zero : !vm.buffer
  %c2 = vm.const.i32 2
  %c7 = vm.const.i32 7
  %c1 = vm.const.i32 1
  %zero = vm.const.i64.zero
  %c128 = vm.const.i64 128
  %c-1 = vm.const.i64 -1
  %zero_2 = vm.const.i32.zero
  %ref = vm.call @hal.ex.shared_device() {nosideeffects} : () -> !vm.ref<!hal.device>
  %_utf8_hal_executable_format_EAB228F999C2D3A1 = vm.const.ref.rodata @_utf8_hal_executable_format_EAB228F999C2D3A1 : !vm.buffer
  %_utf8_cuda_nvptx_fb_B15B42B96FDBACC = vm.const.ref.rodata @_utf8_cuda_nvptx_fb_B15B42B96FDBACC : !vm.buffer
  %0:2 = vm.call @hal.device.query.i64(%ref, %_utf8_hal_executable_format_EAB228F999C2D3A1, %_utf8_cuda_nvptx_fb_B15B42B96FDBACC) {nosideeffects} : (!vm.ref<!hal.device>, !vm.buffer, !vm.buffer) -> (i32, i64)
  %1 = vm.trunc.i64.i32 %0#1 : i64 -> i32
  %2 = vm.and.i32 %1, %c1 : i32
  %3 = vm.select.i32 %0#0, %2, %zero_2 : i32
  %ref_3 = vm.call.variadic @hal.descriptor_set_layout.create(%ref, %zero_2, [(%zero_2, %c7, %c1), (%c1, %c7, %c1), (%c2, %c7, %zero_2)]) {nosideeffects} : (!vm.ref<!hal.device>, i32, tuple<i32, i32, i32> ...) -> !vm.ref<!hal.descriptor_set_layout>
  %ref_4 = vm.call.variadic @hal.pipeline_layout.create(%ref, %zero_2, [%ref_3]) {nosideeffects} : (!vm.ref<!hal.device>, i32, !vm.ref<!hal.descriptor_set_layout> ...) -> !vm.ref<!hal.pipeline_layout>
  %4 = vm.select.i64 %3, %zero, %c-1 : i64
  %5 = vm.trunc.i64.i32 %4 : i64 -> i32
  vm.global.store.i32 %3, @_device_query_0 : i32
  vm.global.store.ref %ref_4, @_pipeline_layout_0 : !vm.ref<!hal.pipeline_layout>
  vm.br_table %5 {
    default: ^bb2,
    0: ^bb1
  }
^bb1:  // pred: ^bb0
  %_pipeline_layout_0 = vm.global.load.ref @_pipeline_layout_0 : !vm.ref<!hal.pipeline_layout>
  %main_dispatch_0_cuda_nvptx_fb = vm.const.ref.rodata @main_dispatch_0_cuda_nvptx_fb : !vm.buffer
  %ref_5 = vm.call.variadic @hal.executable.create(%ref, %_utf8_cuda_nvptx_fb_B15B42B96FDBACC, %main_dispatch_0_cuda_nvptx_fb, %null_1, [%_pipeline_layout_0]) {nosideeffects} : (!vm.ref<!hal.device>, !vm.buffer, !vm.buffer, !vm.buffer, !vm.ref<!hal.pipeline_layout> ...) -> !vm.ref<!hal.executable>
  vm.br ^bb3(%ref_5 : !vm.ref<!hal.executable>)
^bb2:  // pred: ^bb0
  vm.br ^bb3(%null_0 : !vm.ref<!hal.executable>)
^bb3(%6: !vm.ref<!hal.executable>):  // 2 preds: ^bb1, ^bb2
  %_const = vm.const.ref.rodata @_const : !vm.buffer
  %ref_6 = vm.call @hal.device.allocator(%ref) {nosideeffects} : (!vm.ref<!hal.device>) -> !vm.ref<!hal.allocator>
  %ref_7 = vm.call @hal.allocator.import(%ref_6, %c1, %c-1, %c48, %c527363, %_const, %zero, %c128) : (!vm.ref<!hal.allocator>, i32, i64, i32, i32, !vm.buffer, i64, i64) -> !vm.ref<!hal.buffer>
  %rnz = vm.cmp.nz.ref %ref_7 : !vm.ref<!hal.buffer>
  vm.global.store.ref %6, @_executable_main_dispatch_0 : !vm.ref<!hal.executable>
  vm.cond_br %rnz, ^bb5(%null, %ref_7 : !vm.ref<!hal.fence>, !vm.ref<!hal.buffer>), ^bb4
^bb4:  // pred: ^bb3
  %ref_8 = vm.call @hal.allocator.allocate(%ref_6, %c-1, %c48, %c527363, %c128) : (!vm.ref<!hal.allocator>, i64, i32, i32, i64) -> !vm.ref<!hal.buffer>
  %ref_9 = vm.call @hal.ex.file.from_memory(%ref, %c-1, %c1, %_const, %zero, %c128, %zero_2) : (!vm.ref<!hal.device>, i64, i32, !vm.buffer, i64, i64, i32) -> !vm.ref<!hal.file>
  %ref_10 = vm.call @hal.fence.create(%ref, %zero_2) : (!vm.ref<!hal.device>, i32) -> !vm.ref<!hal.fence>
  vm.call @hal.device.queue.read(%ref, %c-1, %null, %ref_10, %ref_9, %zero, %ref_8, %zero, %c128, %zero_2) : (!vm.ref<!hal.device>, i64, !vm.ref<!hal.fence>, !vm.ref<!hal.fence>, !vm.ref<!hal.file>, i64, !vm.ref<!hal.buffer>, i64, i64, i32) -> ()
  vm.br ^bb5(%ref_10, %ref_8 : !vm.ref<!hal.fence>, !vm.ref<!hal.buffer>)
^bb5(%7: !vm.ref<!hal.fence>, %8: !vm.ref<!hal.buffer>):  // 2 preds: ^bb3, ^bb4
  vm.global.store.ref %8, @_params.weight : !vm.ref<!hal.buffer>
  vm.global.store.ref %7, @_params.weight__timepoint : !vm.ref<!hal.fence>
  vm.return
}

