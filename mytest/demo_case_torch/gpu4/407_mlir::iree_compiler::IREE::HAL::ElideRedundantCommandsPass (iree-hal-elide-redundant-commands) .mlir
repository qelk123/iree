
func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
  %c3 = arith.constant 3 : index
  %c2 = arith.constant 2 : index
  %c1 = arith.constant 1 : index
  %c-1 = arith.constant -1 : index
  %c-1_i32 = arith.constant -1 : i32
  %c0_i64 = arith.constant 0 : i64
  %c-1_i64 = arith.constant -1 : i64
  %c128 = arith.constant 128 : index
  %c16 = arith.constant 16 : index
  %c12 = arith.constant 12 : index
  %c553648160_i32 = arith.constant 553648160 : i32
  %c1_i32 = arith.constant 1 : i32
  %c4 = arith.constant 4 : index
  %c0 = arith.constant 0 : index
  %_params.weight__timepoint = util.global.load @_params.weight__timepoint : !hal.fence
  %_params.weight = util.global.load @_params.weight : !hal.buffer
  %_device_query_0 = util.global.load @_device_query_0 : i1
  hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input 0") shape([%c4]) type(%c553648160_i32) encoding(%c1_i32)
  %buffer = hal.buffer_view.buffer<%arg0 : !hal.buffer_view> : !hal.buffer
  %device = hal.ex.shared_device : !hal.device
  %allocator = hal.device.allocator<%device : !hal.device> : !hal.allocator
  hal.buffer.assert<%buffer : !hal.buffer> message("tensor") allocator(%allocator : !hal.allocator) minimum_length(%c16) type(DeviceVisible) usage("TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage")
  %fence = hal.fence.create device(%device : !hal.device) flags("None") : !hal.fence
  %status = hal.fence.await until([%_params.weight__timepoint]) timeout_millis(%c-1_i32) : i32
  %0 = util.null : !hal.fence
  %transient_buffer = hal.device.queue.alloca<%device : !hal.device> affinity(%c-1_i64) wait(%0) signal(%fence) pool(%c0_i64) type("DeviceVisible|DeviceLocal") usage("TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage") : !hal.buffer{%c12}
  %status_0 = hal.fence.await until([%fence]) timeout_millis(%c-1_i32) : i32
  %cmd = hal.command_buffer.create device(%device : !hal.device) mode("OneShot|AllowInlineExecution") categories("Transfer|Dispatch") : !hal.command_buffer
  %1 = arith.select %_device_query_0, %c0, %c-1 : index
  scf.index_switch %1 
  case 0 {
    %_pipeline_layout_0 = util.global.load @_pipeline_layout_0 : !hal.pipeline_layout
    hal.command_buffer.push_descriptor_set<%cmd : !hal.command_buffer> layout(%_pipeline_layout_0 : !hal.pipeline_layout)[%c0] bindings([
      %c0 = (%buffer : !hal.buffer)[%c0, %c16], 
      %c1 = (%_params.weight : !hal.buffer)[%c0, %c128], 
      %c2 = (%transient_buffer : !hal.buffer)[%c0, %c12]
    ])
    %_executable_main_dispatch_0 = util.global.load @_executable_main_dispatch_0 : !hal.executable
    hal.command_buffer.dispatch<%cmd : !hal.command_buffer> target(%_executable_main_dispatch_0 : !hal.executable)[0] workgroups([%c3, %c1, %c1])
    scf.yield
  }
  default {
  }
  hal.command_buffer.execution_barrier<%cmd : !hal.command_buffer> source("Dispatch|Transfer|CommandRetire") target("CommandIssue|Dispatch|Transfer") flags("None")
  hal.command_buffer.finalize<%cmd : !hal.command_buffer>
  %fence_1 = hal.fence.create device(%device : !hal.device) flags("None") : !hal.fence
  %status_2 = hal.fence.await until([%fence]) timeout_millis(%c-1_i32) : i32
  hal.device.queue.execute<%device : !hal.device> affinity(%c-1_i64) wait(%0) signal(%fence_1) commands([%cmd])
  %status_3 = hal.fence.await until([%fence_1]) timeout_millis(%c-1_i32) : i32
  util.status.check_ok %status_3, "failed to wait on timepoint"
  %view = hal.buffer_view.create buffer(%transient_buffer : !hal.buffer)[%c0, %c12] shape([%c3]) type(%c553648160_i32) encoding(%c1_i32) : !hal.buffer_view
  return %view : !hal.buffer_view
}

