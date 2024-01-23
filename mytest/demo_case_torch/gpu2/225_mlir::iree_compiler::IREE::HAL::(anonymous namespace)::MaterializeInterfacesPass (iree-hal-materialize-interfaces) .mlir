
#executable_target_cuda_nvptx_fb = #hal.executable.target<"cuda", "cuda-nvptx-fb", {target_arch = "sm_75"}>
#pipeline_layout = #hal.pipeline.layout<push_constants = 4, sets = [<0, bindings = [<0, storage_buffer, ReadOnly>, <1, storage_buffer>]>]>
#device_target_cuda = #hal.device.target<"cuda", {executable_targets = [#executable_target_cuda_nvptx_fb], legacy_sync}>
module @LinearModule attributes {hal.device.targets = [#device_target_cuda]} {
  hal.executable private @main_dispatch_0 {
    hal.executable.variant public @cuda_nvptx_fb target(#executable_target_cuda_nvptx_fb) {
      hal.executable.export public @main_dispatch_0_matmul_DxDxD_f32 ordinal(0) layout(#pipeline_layout) {
      ^bb0(%arg0: !hal.device, %arg1: index, %arg2: index):
        %x, %y, %z = flow.dispatch.workgroup_count_from_slice %arg1, %arg2
        hal.return %x, %y, %z : index, index, index
      }
      builtin.module {
        func.func @main_dispatch_0_matmul_DxDxD_f32() {
          %c32_i64 = arith.constant 32 : i64
          %cst = arith.constant 0.000000e+00 : f32
          %c0 = arith.constant 0 : index
          %0 = hal.interface.constant.load[0] : i32
          %1 = hal.interface.constant.load[1] : i32
          %2 = hal.interface.constant.load[2] : i32
          %3 = hal.interface.constant.load[3] : i32
          %4 = arith.extui %0 : i32 to i64
          %5 = arith.extui %1 : i32 to i64
          %6 = arith.shli %5, %c32_i64 : i64
          %7 = arith.ori %4, %6 : i64
          %8 = arith.index_castui %7 : i64 to index
          %9 = arith.extui %2 : i32 to i64
          %10 = arith.extui %3 : i32 to i64
          %11 = arith.shli %10, %c32_i64 : i64
          %12 = arith.ori %9, %11 : i64
          %13 = arith.index_castui %12 : i64 to index
          %14 = flow.dispatch.workload.ordinal %8, 0 : index
          %15 = flow.dispatch.workload.ordinal %13, 1 : index
          %16 = hal.interface.binding.subspan set(0) binding(0) type(storage_buffer) alignment(64) offset(%c0) flags(ReadOnly) : !flow.dispatch.tensor<readonly:tensor<?x?xf32>>{%14, %15}
          %17 = hal.interface.binding.subspan set(0) binding(1) type(storage_buffer) alignment(64) offset(%c0) : !flow.dispatch.tensor<writeonly:tensor<?x?xf32>>{%14, %15}
          %18 = flow.dispatch.tensor.load %16, offsets = [0, 0], sizes = [%14, %15], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<?x?xf32>>{%14, %15} -> tensor<?x?xf32>
          %19 = tensor.empty(%14, %15) : tensor<?x?xf32>
          %20 = linalg.fill ins(%cst : f32) outs(%19 : tensor<?x?xf32>) -> tensor<?x?xf32>
          %21 = linalg.matmul ins(%18, %18 : tensor<?x?xf32>, tensor<?x?xf32>) outs(%20 : tensor<?x?xf32>) -> tensor<?x?xf32>
          flow.dispatch.tensor.store %21, %17, offsets = [0, 0], sizes = [%14, %15], strides = [1, 1] : tensor<?x?xf32> -> !flow.dispatch.tensor<writeonly:tensor<?x?xf32>>{%14, %15}
          return
        }
      }
    }
  }
  func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
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
    %4 = stream.tensor.import %arg0 : !hal.buffer_view -> tensor<?x?xf32>{%0, %1} in !stream.resource<external>{%3}
    %result, %result_timepoint = stream.resource.alloca uninitialized : !stream.resource<external>{%3} => !stream.timepoint
    %5 = arith.index_castui %0 : index to i64
    %6 = arith.trunci %5 : i64 to i32
    %7 = arith.shrui %5, %c32_i64 : i64
    %8 = arith.trunci %7 : i64 to i32
    %9 = arith.index_castui %1 : index to i64
    %10 = arith.trunci %9 : i64 to i32
    %11 = arith.shrui %9, %c32_i64 : i64
    %12 = arith.trunci %11 : i64 to i32
    %13 = stream.cmd.execute await(%result_timepoint) => with(%4 as %arg1: !stream.resource<external>{%3}, %result as %arg2: !stream.resource<external>{%3}) {
      stream.cmd.dispatch @main_dispatch_0::@cuda_nvptx_fb::@main_dispatch_0_matmul_DxDxD_f32[%0, %1](%6, %8, %10, %12 : i32, i32, i32, i32) {
        ro %arg1[%c0 for %3] : !stream.resource<external>{%3},
        wo %arg2[%c0 for %3] : !stream.resource<external>{%3}
      } attributes {hal.interface.bindings = [#hal.interface.binding<0, 0>, #hal.interface.binding<0, 1>]}
    } => !stream.timepoint
    %14 = stream.timepoint.await %13 => %result : !stream.resource<external>{%3}
    %15 = stream.tensor.export %14 : tensor<?x?xf32>{%0, %1} in !stream.resource<external>{%3} -> !hal.buffer_view
    return %15 : !hal.buffer_view
  }
}


