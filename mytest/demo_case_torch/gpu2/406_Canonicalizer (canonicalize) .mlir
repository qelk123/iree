
vm.func private @main(%arg0: !vm.ref<!hal.buffer_view>) -> !vm.ref<!hal.buffer_view> {
  %c13 = vm.const.i32 13
  %c28 = vm.const.i32 28
  %c3 = vm.const.i32 3
  %c17 = vm.const.i32 17
  %c32 = vm.const.i32 32
  %c48 = vm.const.i32 48
  %null = vm.const.ref.zero : !vm.ref<!hal.fence>
  %c3075 = vm.const.i32 3075
  %c16 = vm.const.i32 16
  %zero = vm.const.i32.zero
  %c32_0 = vm.const.i64 32
  %c128 = vm.const.i64 128
  %c553648160 = vm.const.i32 553648160
  %c1 = vm.const.i32 1
  %zero_1 = vm.const.i64.zero
  %c4 = vm.const.i64 4
  %c-1 = vm.const.i64 -1
  %c-1_2 = vm.const.i32 -1
  %c1_3 = vm.const.i64 1
  %_device_query_0 = vm.global.load.i32 @_device_query_0 : i32
  %_pipeline_layout_0 = vm.global.load.ref @_pipeline_layout_0 : !vm.ref<!hal.pipeline_layout>
  %_executable_main_dispatch_0 = vm.global.load.ref @_executable_main_dispatch_0 : !vm.ref<!hal.executable>
  %0 = vm.call @hal.buffer_view.dim(%arg0, %zero) {nosideeffects} : (!vm.ref<!hal.buffer_view>, i32) -> i64
  %1 = vm.call @hal.buffer_view.dim(%arg0, %c1) {nosideeffects} : (!vm.ref<!hal.buffer_view>, i32) -> i64
  %_utf8_input_0_5FD512E67BEFDEEC = vm.const.ref.rodata @_utf8_input_0_5FD512E67BEFDEEC : !vm.buffer
  vm.call.variadic @hal.buffer_view.assert(%arg0, %_utf8_input_0_5FD512E67BEFDEEC, %c553648160, %c1, [%0, %1]) : (!vm.ref<!hal.buffer_view>, !vm.buffer, i32, i32, i64 ...)
  %2 = vm.mul.i64 %0, %c4 : i64
  %3 = vm.mul.i64 %2, %1 : i64
  %ref = vm.call @hal.buffer_view.buffer(%arg0) {nosideeffects} : (!vm.ref<!hal.buffer_view>) -> !vm.ref<!hal.buffer>
  %ref_4 = vm.call @hal.ex.shared_device() {nosideeffects} : () -> !vm.ref<!hal.device>
  %ref_5 = vm.call @hal.device.allocator(%ref_4) {nosideeffects} : (!vm.ref<!hal.device>) -> !vm.ref<!hal.allocator>
  %_utf8_tensor_3C6209B4FD120BDC = vm.const.ref.rodata @_utf8_tensor_3C6209B4FD120BDC : !vm.buffer
  vm.call @hal.buffer.assert(%ref, %_utf8_tensor_3C6209B4FD120BDC, %ref_5, %3, %c16, %c3075) : (!vm.ref<!hal.buffer>, !vm.buffer, !vm.ref<!hal.allocator>, i64, i32, i32) -> ()
  %ref_6 = vm.call @hal.fence.create(%ref_4, %zero) : (!vm.ref<!hal.device>, i32) -> !vm.ref<!hal.fence>
  %ref_7 = vm.call @hal.device.queue.alloca(%ref_4, %c-1, %null, %ref_6, %zero, %c48, %c3075, %3) : (!vm.ref<!hal.device>, i64, !vm.ref<!hal.fence>, !vm.ref<!hal.fence>, i32, i32, i32, i64) -> !vm.ref<!hal.buffer>
  %4 = vm.call.variadic @hal.fence.await(%c-1_2, [%ref_6]) : (i32, !vm.ref<!hal.fence> ...) -> i32
  %5 = vm.trunc.i64.i32 %0 : i64 -> i32
  %6 = vm.shr.i64.u %0, %c32 : i64
  %7 = vm.trunc.i64.i32 %6 : i64 -> i32
  %8 = vm.trunc.i64.i32 %1 : i64 -> i32
  %9 = vm.shr.i64.u %1, %c32 : i64
  %10 = vm.trunc.i64.i32 %9 : i64 -> i32
  %ref_8 = vm.call @hal.command_buffer.create(%ref_4, %c17, %c3, %zero) : (!vm.ref<!hal.device>, i32, i32, i32) -> !vm.ref<!hal.command_buffer>
  %11 = vm.select.i64 %_device_query_0, %zero_1, %c-1 : i64
  %12 = vm.trunc.i64.i32 %11 : i64 -> i32
  vm.br_table %12 {
    default: ^bb2,
    0: ^bb1
  }
^bb1:  // pred: ^bb0
  vm.call.variadic @hal.command_buffer.push_constants(%ref_8, %_pipeline_layout_0, %zero, [%5, %7, %8, %10]) : (!vm.ref<!hal.command_buffer>, !vm.ref<!hal.pipeline_layout>, i32, i32 ...)
  vm.call.variadic @hal.command_buffer.push_descriptor_set(%ref_8, %_pipeline_layout_0, %zero, [(%zero, %zero, %ref, %zero_1, %3), (%c1, %zero, %ref_7, %zero_1, %3)]) : (!vm.ref<!hal.command_buffer>, !vm.ref<!hal.pipeline_layout>, i32, tuple<i32, i32, !vm.ref<!hal.buffer>, i64, i64> ...)
  %slt = vm.cmp.lt.i64.s %zero_1, %1 : i64
  %13 = vm.xor.i32 %slt, %c1 : i32
  %14 = vm.sub.i64 %zero_1, %1 : i64
  %15 = vm.sub.i64 %1, %c1_3 : i64
  %16 = vm.select.i64 %13, %14, %15 : i64
  %17 = vm.div.i64.s %16, %c128 : i64
  %18 = vm.sub.i64 %zero_1, %17 : i64
  %19 = vm.add.i64 %17, %c1_3 : i64
  %20 = vm.select.i64 %13, %18, %19 : i64
  %slt_9 = vm.cmp.lt.i64.s %zero_1, %0 : i64
  %21 = vm.xor.i32 %slt_9, %c1 : i32
  %22 = vm.sub.i64 %zero_1, %0 : i64
  %23 = vm.sub.i64 %0, %c1_3 : i64
  %24 = vm.select.i64 %21, %22, %23 : i64
  %25 = vm.div.i64.s %24, %c32_0 : i64
  %26 = vm.sub.i64 %zero_1, %25 : i64
  %27 = vm.add.i64 %25, %c1_3 : i64
  %28 = vm.select.i64 %21, %26, %27 : i64
  %29 = vm.mul.i64 %20, %28 : i64
  %30 = vm.trunc.i64.i32 %29 : i64 -> i32
  vm.call @hal.command_buffer.dispatch(%ref_8, %_executable_main_dispatch_0, %zero, %30, %c1, %c1) : (!vm.ref<!hal.command_buffer>, !vm.ref<!hal.executable>, i32, i32, i32, i32) -> ()
  vm.br ^bb2
^bb2:  // 2 preds: ^bb0, ^bb1
  vm.call @hal.command_buffer.execution_barrier(%ref_8, %c28, %c13, %zero) : (!vm.ref<!hal.command_buffer>, i32, i32, i32) -> ()
  vm.call @hal.command_buffer.finalize(%ref_8) : (!vm.ref<!hal.command_buffer>) -> ()
  %ref_10 = vm.call @hal.fence.create(%ref_4, %zero) : (!vm.ref<!hal.device>, i32) -> !vm.ref<!hal.fence>
  %31 = vm.call.variadic @hal.fence.await(%c-1_2, [%ref_6]) : (i32, !vm.ref<!hal.fence> ...) -> i32
  vm.call.variadic @hal.device.queue.execute(%ref_4, %c-1, %null, %ref_10, [%ref_8]) : (!vm.ref<!hal.device>, i64, !vm.ref<!hal.fence>, !vm.ref<!hal.fence>, !vm.ref<!hal.command_buffer> ...)
  %32 = vm.call.variadic @hal.fence.await(%c-1_2, [%ref_10]) : (i32, !vm.ref<!hal.fence> ...) -> i32
  vm.cond_br %32, ^bb4, ^bb3
^bb3:  // pred: ^bb2
  %ref_11 = vm.call.variadic @hal.buffer_view.create(%ref_7, %zero_1, %3, %c553648160, %c1, [%0, %1]) {nosideeffects} : (!vm.ref<!hal.buffer>, i64, i64, i32, i32, i64 ...) -> !vm.ref<!hal.buffer_view>
  vm.return %ref_11 : !vm.ref<!hal.buffer_view>
^bb4:  // pred: ^bb2
  vm.fail %32, "failed to wait on timepoint"
}

