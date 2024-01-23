
func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
  %c1 = arith.constant 1 : index
  %c-1 = arith.constant -1 : index
  %c-1_i32 = arith.constant -1 : i32
  %c0_i64 = arith.constant 0 : i64
  %c-1_i64 = arith.constant -1 : i64
  %c32_i64 = arith.constant 32 : i64
  %c4 = arith.constant 4 : index
  %c0 = arith.constant 0 : index
  %c1_i32 = arith.constant 1 : i32
  %c553648160_i32 = arith.constant 553648160 : i32
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
  %ok, %value = hal.device.query<%device : !hal.device> key("hal.executable.format" :: "cuda-nvptx-fb") : i1, i1 = false
  %13 = arith.select %value, %c0, %c-1 : index
  scf.index_switch %13 
  case 0 {
    %pipeline_layout = hal.pipeline_layout.lookup device(%device : !hal.device) layout(<push_constants = 4, sets = [<0, bindings = [<0, storage_buffer, ReadOnly>, <1, storage_buffer>]>]>) : !hal.pipeline_layout
    hal.command_buffer.push_constants<%cmd : !hal.command_buffer> layout(%pipeline_layout : !hal.pipeline_layout) offset(0) values([%6, %8, %10, %12]) : i32, i32, i32, i32
    hal.command_buffer.push_descriptor_set<%cmd : !hal.command_buffer> layout(%pipeline_layout : !hal.pipeline_layout)[%c0] bindings([
      %c0 = (%buffer : !hal.buffer)[%c0, %3], 
      %c1 = (%transient_buffer : !hal.buffer)[%c0, %3]
    ])
    %14 = affine.apply affine_map<()[s0, s1] -> ((s0 ceildiv 128) * (s1 ceildiv 32))>()[%1, %0]
    hal.command_buffer.dispatch.symbol<%cmd : !hal.command_buffer> target(@main_dispatch_0::@cuda_nvptx_fb::@main_dispatch_0_matmul_DxDxD_f32) workgroups([%14, %c1, %c1])
    scf.yield
  }
  default {
  }
  hal.command_buffer.execution_barrier<%cmd : !hal.command_buffer> source("Dispatch|Transfer|CommandRetire") target("CommandIssue|Dispatch|Transfer") flags("None")
  hal.command_buffer.finalize<%cmd : !hal.command_buffer>
  %fence_0 = hal.fence.create device(%device : !hal.device) flags("None") : !hal.fence
  %status_1 = hal.fence.await until([%fence]) timeout_millis(%c-1_i32) : i32
  hal.device.queue.execute<%device : !hal.device> affinity(%c-1_i64) wait(%4) signal(%fence_0) commands([%cmd])
  %status_2 = hal.fence.await until([%fence_0]) timeout_millis(%c-1_i32) : i32
  util.status.check_ok %status_2, "failed to wait on timepoint"
  %view = hal.buffer_view.create buffer(%transient_buffer : !hal.buffer)[%c0, %3] shape([%0, %1]) type(%c553648160_i32) encoding(%c1_i32) : !hal.buffer_view
  return %view : !hal.buffer_view
}

