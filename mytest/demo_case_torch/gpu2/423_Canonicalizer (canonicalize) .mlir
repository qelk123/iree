
vm.func private @__init() {
  %null = vm.const.ref.zero : !vm.ref<!hal.executable>
  %null_0 = vm.const.ref.zero : !vm.buffer
  %c4 = vm.const.i32 4
  %c7 = vm.const.i32 7
  %zero = vm.const.i32.zero
  %c1 = vm.const.i32 1
  %zero_1 = vm.const.i64.zero
  %c-1 = vm.const.i64 -1
  %ref = vm.call @hal.ex.shared_device() {nosideeffects} : () -> !vm.ref<!hal.device>
  %_utf8_hal_executable_format_EAB228F999C2D3A1 = vm.const.ref.rodata @_utf8_hal_executable_format_EAB228F999C2D3A1 : !vm.buffer
  %_utf8_cuda_nvptx_fb_B15B42B96FDBACC = vm.const.ref.rodata @_utf8_cuda_nvptx_fb_B15B42B96FDBACC : !vm.buffer
  %0:2 = vm.call @hal.device.query.i64(%ref, %_utf8_hal_executable_format_EAB228F999C2D3A1, %_utf8_cuda_nvptx_fb_B15B42B96FDBACC) {nosideeffects} : (!vm.ref<!hal.device>, !vm.buffer, !vm.buffer) -> (i32, i64)
  %1 = vm.trunc.i64.i32 %0#1 : i64 -> i32
  %2 = vm.and.i32 %1, %c1 : i32
  %3 = vm.select.i32 %0#0, %2, %zero : i32
  %ref_2 = vm.call.variadic @hal.descriptor_set_layout.create(%ref, %zero, [(%zero, %c7, %c1), (%c1, %c7, %zero)]) {nosideeffects} : (!vm.ref<!hal.device>, i32, tuple<i32, i32, i32> ...) -> !vm.ref<!hal.descriptor_set_layout>
  %ref_3 = vm.call.variadic @hal.pipeline_layout.create(%ref, %c4, [%ref_2]) {nosideeffects} : (!vm.ref<!hal.device>, i32, !vm.ref<!hal.descriptor_set_layout> ...) -> !vm.ref<!hal.pipeline_layout>
  %4 = vm.select.i64 %3, %zero_1, %c-1 : i64
  %5 = vm.trunc.i64.i32 %4 : i64 -> i32
  vm.global.store.i32 %3, @_device_query_0 : i32
  vm.global.store.ref %ref_3, @_pipeline_layout_0 : !vm.ref<!hal.pipeline_layout>
  vm.br_table %5 {
    default: ^bb2,
    0: ^bb1
  }
^bb1:  // pred: ^bb0
  %_pipeline_layout_0 = vm.global.load.ref @_pipeline_layout_0 : !vm.ref<!hal.pipeline_layout>
  %main_dispatch_0_cuda_nvptx_fb = vm.const.ref.rodata @main_dispatch_0_cuda_nvptx_fb : !vm.buffer
  %ref_4 = vm.call.variadic @hal.executable.create(%ref, %_utf8_cuda_nvptx_fb_B15B42B96FDBACC, %main_dispatch_0_cuda_nvptx_fb, %null_0, [%_pipeline_layout_0]) {nosideeffects} : (!vm.ref<!hal.device>, !vm.buffer, !vm.buffer, !vm.buffer, !vm.ref<!hal.pipeline_layout> ...) -> !vm.ref<!hal.executable>
  vm.br ^bb3(%ref_4 : !vm.ref<!hal.executable>)
^bb2:  // pred: ^bb0
  vm.br ^bb3(%null : !vm.ref<!hal.executable>)
^bb3(%6: !vm.ref<!hal.executable>):  // 2 preds: ^bb1, ^bb2
  vm.global.store.ref %6, @_executable_main_dispatch_0 : !vm.ref<!hal.executable>
  vm.return
}

