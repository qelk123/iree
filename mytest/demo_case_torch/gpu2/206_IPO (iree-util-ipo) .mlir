
#executable_target_cuda_nvptx_fb = #hal.executable.target<"cuda", "cuda-nvptx-fb", {target_arch = "sm_75"}>
#device_target_cuda = #hal.device.target<"cuda", {executable_targets = [#executable_target_cuda_nvptx_fb], legacy_sync}>
module @LinearModule attributes {hal.device.targets = [#device_target_cuda]} {
  stream.executable private @main_dispatch_0 {
    stream.executable.export public @main_dispatch_0_matmul_DxDxD_f32 workgroups(%arg0: index, %arg1: index) -> (index, index, index) {
      %x, %y, %z = flow.dispatch.workgroup_count_from_slice %arg0, %arg1
      stream.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_0_matmul_DxDxD_f32(%arg0: !stream.binding {stream.alignment = 64 : index}, %arg1: !stream.binding {stream.alignment = 64 : index}, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32) {
        %cst = arith.constant 0.000000e+00 : f32
        %c32_i64 = arith.constant 32 : i64
        %0 = arith.extui %arg2 : i32 to i64
        %1 = arith.extui %arg3 : i32 to i64
        %2 = arith.shli %1, %c32_i64 : i64
        %3 = arith.ori %0, %2 : i64
        %4 = arith.index_castui %3 {stream.values = [0 : index]} : i64 to index
        %5 = arith.extui %arg4 : i32 to i64
        %6 = arith.extui %arg5 : i32 to i64
        %7 = arith.shli %6, %c32_i64 : i64
        %8 = arith.ori %5, %7 : i64
        %9 = arith.index_castui %8 {stream.values = [0 : index]} : i64 to index
        %10 = arith.extui %arg6 : i32 to i64
        %11 = arith.extui %arg7 : i32 to i64
        %12 = arith.shli %11, %c32_i64 : i64
        %13 = arith.ori %10, %12 : i64
        %14 = arith.index_castui %13 : i64 to index
        %15 = arith.extui %arg8 : i32 to i64
        %16 = arith.extui %arg9 : i32 to i64
        %17 = arith.shli %16, %c32_i64 : i64
        %18 = arith.ori %15, %17 : i64
        %19 = arith.index_castui %18 : i64 to index
        %20 = flow.dispatch.workload.ordinal %14, 0 : index
        %21 = flow.dispatch.workload.ordinal %19, 1 : index
        %22 = stream.binding.subspan %arg0[%4] : !stream.binding -> !flow.dispatch.tensor<readonly:tensor<?x?xf32>>{%20, %21}
        %23 = stream.binding.subspan %arg1[%9] : !stream.binding -> !flow.dispatch.tensor<writeonly:tensor<?x?xf32>>{%20, %21}
        %24 = flow.dispatch.tensor.load %22, offsets = [0, 0], sizes = [%20, %21], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<?x?xf32>>{%20, %21} -> tensor<?x?xf32>
        %25 = tensor.empty(%20, %21) : tensor<?x?xf32>
        %26 = linalg.fill ins(%cst : f32) outs(%25 : tensor<?x?xf32>) -> tensor<?x?xf32>
        %27 = linalg.matmul ins(%24, %24 : tensor<?x?xf32>, tensor<?x?xf32>) outs(%26 : tensor<?x?xf32>) -> tensor<?x?xf32>
        flow.dispatch.tensor.store %27, %23, offsets = [0, 0], sizes = [%20, %21], strides = [1, 1] : tensor<?x?xf32> -> !flow.dispatch.tensor<writeonly:tensor<?x?xf32>>{%20, %21}
        return
      }
    }
  }
  func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
    %c32_i64 = arith.constant 32 : i64
    %c0_i32 = arith.constant 0 : i32
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
      stream.cmd.dispatch @main_dispatch_0::@main_dispatch_0_matmul_DxDxD_f32[%0, %1](%c0_i32, %c0_i32, %c0_i32, %c0_i32, %6, %8, %10, %12 : i32, i32, i32, i32, i32, i32, i32, i32) {
        ro %arg1[%c0 for %3] : !stream.resource<external>{%3},
        wo %arg2[%c0 for %3] : !stream.resource<external>{%3}
      }
    } => !stream.timepoint
    %14 = stream.timepoint.await %13 => %result : !stream.resource<external>{%3}
    %15 = stream.tensor.export %14 : tensor<?x?xf32>{%0, %1} in !stream.resource<external>{%3} -> !hal.buffer_view
    return %15 : !hal.buffer_view
  }
}


