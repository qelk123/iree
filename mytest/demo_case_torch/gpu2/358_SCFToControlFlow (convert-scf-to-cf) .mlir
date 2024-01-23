
func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
  %c553648160_i32 = arith.constant 553648160 : i32
  %c1_i32 = arith.constant 1 : i32
  %c0 = arith.constant 0 : index
  %c4 = arith.constant 4 : index
  %c32_i64 = arith.constant 32 : i64
  %c-1_i64 = arith.constant -1 : i64
  %c0_i64 = arith.constant 0 : i64
  %c-1_i32 = arith.constant -1 : i32
  %c-1 = arith.constant -1 : index
  %c1 = arith.constant 1 : index
  %_device_query_0 = util.global.load @_device_query_0 : i1
  %0 = hal.buffer_view.dim<%arg0 : !hal.buffer_view>[0] : index
  %1 = hal.buffer_view.dim<%arg0 : !hal.buffer_view>[1] : index
  hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input 0") shape([%0, %1]) type(%c553648160_i32) encoding(%c1_i32)
  %2 = arith.muli %0, %c4 : index
  %3 = arith.muli %2, %1 : index
  %buffer = hal.buffer_view.buffer<%arg0 : !hal.buffer_view> : !hal.buffer
  %device = hal.ex.shared_device : !hal.device
  %allocator = hal.device.allocator<%device : !hal.device> : !hal.allocator
  hal.buffer.assert<%buffer : !hal.buffer> message("tensor") allocator(%allocator : !hal.allocator) minimum_length(%3) type(DeviceVisible) usage("TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage")
  %4 = util.null : !hal.fence
  %fence = hal.fence.create device(%device : !hal.device) flags("None") : !hal.fence
  %transient_buffer = hal.device.queue.alloca<%device : !hal.device> affinity(%c-1_i64) wait(%4) signal(%fence) pool(%c0_i64) type("DeviceVisible|DeviceLocal") usage("TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage") : !hal.buffer{%3}
  %status = hal.fence.await until([%fence]) timeout_millis(%c-1_i32) : i32
  %5 = arith.index_castui %0 : index to i64
  %6 = arith.trunci %5 : i64 to i32
  %7 = arith.shrui %5, %c32_i64 : i64
  %8 = arith.trunci %7 : i64 to i32
  %9 = arith.index_castui %1 : index to i64
  %10 = arith.trunci %9 : i64 to i32
  %11 = arith.shrui %9, %c32_i64 : i64
  %12 = arith.trunci %11 : i64 to i32
  %cmd = hal.command_buffer.create device(%device : !hal.device) mode("OneShot|AllowInlineExecution") categories("Transfer|Dispatch") : !hal.command_buffer
  %13 = arith.select %_device_query_0, %c0, %c-1 : index
  %14 = arith.index_cast %13 : index to i32
  cf.switch %14 : i32, [
    default: ^bb2,
    0: ^bb1
  ]
^bb1:  // pred: ^bb0
  %_pipeline_layout_0 = util.global.load @_pipeline_layout_0 : !hal.pipeline_layout
  hal.command_buffer.push_constants<%cmd : !hal.command_buffer> layout(%_pipeline_layout_0 : !hal.pipeline_layout) offset(0) values([%6, %8, %10, %12]) : i32, i32, i32, i32
  hal.command_buffer.push_descriptor_set<%cmd : !hal.command_buffer> layout(%_pipeline_layout_0 : !hal.pipeline_layout)[%c0] bindings([
    %c0 = (%buffer : !hal.buffer)[%c0, %3], 
    %c1 = (%transient_buffer : !hal.buffer)[%c0, %3]
  ])
  %c128 = arith.constant 128 : index
  %c0_0 = arith.constant 0 : index
  %c1_1 = arith.constant 1 : index
  %15 = arith.cmpi sle, %1, %c0_0 : index
  %16 = arith.subi %c0_0, %1 : index
  %17 = arith.subi %1, %c1_1 : index
  %18 = arith.select %15, %16, %17 : index
  %19 = arith.divsi %18, %c128 : index
  %20 = arith.subi %c0_0, %19 : index
  %21 = arith.addi %19, %c1_1 : index
  %22 = arith.select %15, %20, %21 : index
  %c32 = arith.constant 32 : index
  %c0_2 = arith.constant 0 : index
  %c1_3 = arith.constant 1 : index
  %23 = arith.cmpi sle, %0, %c0_2 : index
  %24 = arith.subi %c0_2, %0 : index
  %25 = arith.subi %0, %c1_3 : index
  %26 = arith.select %23, %24, %25 : index
  %27 = arith.divsi %26, %c32 : index
  %28 = arith.subi %c0_2, %27 : index
  %29 = arith.addi %27, %c1_3 : index
  %30 = arith.select %23, %28, %29 : index
  %31 = arith.muli %22, %30 : index
  %_executable_main_dispatch_0 = util.global.load @_executable_main_dispatch_0 : !hal.executable
  hal.command_buffer.dispatch<%cmd : !hal.command_buffer> target(%_executable_main_dispatch_0 : !hal.executable)[0] workgroups([%31, %c1, %c1])
  cf.br ^bb3
^bb2:  // pred: ^bb0
  cf.br ^bb3
^bb3:  // 2 preds: ^bb1, ^bb2
  hal.command_buffer.execution_barrier<%cmd : !hal.command_buffer> source("Dispatch|Transfer|CommandRetire") target("CommandIssue|Dispatch|Transfer") flags("None")
  hal.command_buffer.finalize<%cmd : !hal.command_buffer>
  %fence_4 = hal.fence.create device(%device : !hal.device) flags("None") : !hal.fence
  %status_5 = hal.fence.await until([%fence]) timeout_millis(%c-1_i32) : i32
  hal.device.queue.execute<%device : !hal.device> affinity(%c-1_i64) wait(%4) signal(%fence_4) commands([%cmd])
  %status_6 = hal.fence.await until([%fence_4]) timeout_millis(%c-1_i32) : i32
  util.status.check_ok %status_6, "failed to wait on timepoint"
  %view = hal.buffer_view.create buffer(%transient_buffer : !hal.buffer)[%c0, %3] shape([%0, %1]) type(%c553648160_i32) encoding(%c1_i32) : !hal.buffer_view
  return %view : !hal.buffer_view
}

