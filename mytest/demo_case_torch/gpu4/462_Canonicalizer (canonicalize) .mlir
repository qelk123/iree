
vm.func private @main(%arg0: !vm.ref<!hal.buffer_view>) -> !vm.ref<!hal.buffer_view> {
  %c13 = vm.const.i32 13
  %c28 = vm.const.i32 28
  %c2 = vm.const.i32 2
  %c3 = vm.const.i32 3
  %c17 = vm.const.i32 17
  %c48 = vm.const.i32 48
  %null = vm.const.ref.zero : !vm.ref<!hal.fence>
  %zero = vm.const.i32.zero
  %c3075 = vm.const.i32 3075
  %c16 = vm.const.i32 16
  %c3_0 = vm.const.i64 3
  %c-1 = vm.const.i64 -1
  %c-1_1 = vm.const.i32 -1
  %zero_2 = vm.const.i64.zero
  %c128 = vm.const.i64 128
  %c16_3 = vm.const.i64 16
  %c12 = vm.const.i64 12
  %c553648160 = vm.const.i32 553648160
  %c1 = vm.const.i32 1
  %c4 = vm.const.i64 4
  %_params.weight__timepoint = vm.global.load.ref @_params.weight__timepoint : !vm.ref<!hal.fence>
  %_params.weight = vm.global.load.ref @_params.weight : !vm.ref<!hal.buffer>
  %_device_query_0 = vm.global.load.i32 @_device_query_0 : i32
  %_pipeline_layout_0 = vm.global.load.ref @_pipeline_layout_0 : !vm.ref<!hal.pipeline_layout>
  %_executable_main_dispatch_0 = vm.global.load.ref @_executable_main_dispatch_0 : !vm.ref<!hal.executable>
  %_utf8_input_0_5FD512E67BEFDEEC = vm.const.ref.rodata @_utf8_input_0_5FD512E67BEFDEEC : !vm.buffer
  vm.call.variadic @hal.buffer_view.assert(%arg0, %_utf8_input_0_5FD512E67BEFDEEC, %c553648160, %c1, [%c4]) : (!vm.ref<!hal.buffer_view>, !vm.buffer, i32, i32, i64 ...)
  %ref = vm.call @hal.buffer_view.buffer(%arg0) {nosideeffects} : (!vm.ref<!hal.buffer_view>) -> !vm.ref<!hal.buffer>
  %ref_4 = vm.call @hal.ex.shared_device() {nosideeffects} : () -> !vm.ref<!hal.device>
  %ref_5 = vm.call @hal.device.allocator(%ref_4) {nosideeffects} : (!vm.ref<!hal.device>) -> !vm.ref<!hal.allocator>
  %_utf8_tensor_3C6209B4FD120BDC = vm.const.ref.rodata @_utf8_tensor_3C6209B4FD120BDC : !vm.buffer
  vm.call @hal.buffer.assert(%ref, %_utf8_tensor_3C6209B4FD120BDC, %ref_5, %c16_3, %c16, %c3075) : (!vm.ref<!hal.buffer>, !vm.buffer, !vm.ref<!hal.allocator>, i64, i32, i32) -> ()
  %ref_6 = vm.call @hal.fence.create(%ref_4, %zero) : (!vm.ref<!hal.device>, i32) -> !vm.ref<!hal.fence>
  %0 = vm.call.variadic @hal.fence.await(%c-1_1, [%_params.weight__timepoint]) : (i32, !vm.ref<!hal.fence> ...) -> i32
  %ref_7 = vm.call @hal.device.queue.alloca(%ref_4, %c-1, %null, %ref_6, %zero, %c48, %c3075, %c12) : (!vm.ref<!hal.device>, i64, !vm.ref<!hal.fence>, !vm.ref<!hal.fence>, i32, i32, i32, i64) -> !vm.ref<!hal.buffer>
  %1 = vm.call.variadic @hal.fence.await(%c-1_1, [%ref_6]) : (i32, !vm.ref<!hal.fence> ...) -> i32
  %ref_8 = vm.call @hal.command_buffer.create(%ref_4, %c17, %c3, %zero) : (!vm.ref<!hal.device>, i32, i32, i32) -> !vm.ref<!hal.command_buffer>
  %2 = vm.select.i64 %_device_query_0, %zero_2, %c-1 : i64
  %3 = vm.trunc.i64.i32 %2 : i64 -> i32
  vm.br_table %3 {
    default: ^bb2,
    0: ^bb1
  }
^bb1:  // pred: ^bb0
  vm.call.variadic @hal.command_buffer.push_descriptor_set(%ref_8, %_pipeline_layout_0, %zero, [(%zero, %zero, %ref, %zero_2, %c16_3), (%c1, %zero, %_params.weight, %zero_2, %c128), (%c2, %zero, %ref_7, %zero_2, %c12)]) : (!vm.ref<!hal.command_buffer>, !vm.ref<!hal.pipeline_layout>, i32, tuple<i32, i32, !vm.ref<!hal.buffer>, i64, i64> ...)
  vm.call @hal.command_buffer.dispatch(%ref_8, %_executable_main_dispatch_0, %zero, %c3, %c1, %c1) : (!vm.ref<!hal.command_buffer>, !vm.ref<!hal.executable>, i32, i32, i32, i32) -> ()
  vm.br ^bb2
^bb2:  // 2 preds: ^bb0, ^bb1
  vm.call @hal.command_buffer.execution_barrier(%ref_8, %c28, %c13, %zero) : (!vm.ref<!hal.command_buffer>, i32, i32, i32) -> ()
  vm.call @hal.command_buffer.finalize(%ref_8) : (!vm.ref<!hal.command_buffer>) -> ()
  %ref_9 = vm.call @hal.fence.create(%ref_4, %zero) : (!vm.ref<!hal.device>, i32) -> !vm.ref<!hal.fence>
  %4 = vm.call.variadic @hal.fence.await(%c-1_1, [%ref_6]) : (i32, !vm.ref<!hal.fence> ...) -> i32
  vm.call.variadic @hal.device.queue.execute(%ref_4, %c-1, %null, %ref_9, [%ref_8]) : (!vm.ref<!hal.device>, i64, !vm.ref<!hal.fence>, !vm.ref<!hal.fence>, !vm.ref<!hal.command_buffer> ...)
  %5 = vm.call.variadic @hal.fence.await(%c-1_1, [%ref_9]) : (i32, !vm.ref<!hal.fence> ...) -> i32
  vm.cond_br %5, ^bb4, ^bb3
^bb3:  // pred: ^bb2
  %ref_10 = vm.call.variadic @hal.buffer_view.create(%ref_7, %zero_2, %c12, %c553648160, %c1, [%c3_0]) {nosideeffects} : (!vm.ref<!hal.buffer>, i64, i64, i32, i32, i64 ...) -> !vm.ref<!hal.buffer_view>
  vm.return %ref_10 : !vm.ref<!hal.buffer_view>
^bb4:  // pred: ^bb2
  vm.fail %5, "failed to wait on timepoint"
}

