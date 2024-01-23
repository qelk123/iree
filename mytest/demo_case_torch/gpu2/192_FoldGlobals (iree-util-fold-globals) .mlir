
#executable_target_cuda_nvptx_fb = #hal.executable.target<"cuda", "cuda-nvptx-fb", {target_arch = "sm_75"}>
#device_target_cuda = #hal.device.target<"cuda", {executable_targets = [#executable_target_cuda_nvptx_fb], legacy_sync}>
module @LinearModule attributes {hal.device.targets = [#device_target_cuda], iree.fixedpoint.iteration = 0 : index} {
  stream.executable private @main_dispatch_0 {
    stream.executable.export public @main_dispatch_0_matmul_DxDxD_f32 workgroups(%arg0: index, %arg1: index) -> (index, index, index) {
      %x, %y, %z = flow.dispatch.workgroup_count_from_slice %arg0, %arg1
      stream.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_0_matmul_DxDxD_f32(%arg0: !stream.binding, %arg1: index, %arg2: index, %arg3: !stream.binding) {
        %c0 = arith.constant 0 : index
        %cst = arith.constant 0.000000e+00 : f32
        %0 = flow.dispatch.workload.ordinal %arg1, 0 : index
        %1 = flow.dispatch.workload.ordinal %arg2, 1 : index
        %2 = stream.binding.subspan %arg0[%c0] : !stream.binding -> !flow.dispatch.tensor<readonly:tensor<?x?xf32>>{%0, %1}
        %3 = stream.binding.subspan %arg3[%c0] : !stream.binding -> !flow.dispatch.tensor<writeonly:tensor<?x?xf32>>{%0, %1}
        %4 = flow.dispatch.tensor.load %2, offsets = [0, 0], sizes = [%0, %1], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<?x?xf32>>{%0, %1} -> tensor<?x?xf32>
        %5 = tensor.empty(%0, %1) : tensor<?x?xf32>
        %6 = linalg.fill ins(%cst : f32) outs(%5 : tensor<?x?xf32>) -> tensor<?x?xf32>
        %7 = linalg.matmul ins(%4, %4 : tensor<?x?xf32>, tensor<?x?xf32>) outs(%6 : tensor<?x?xf32>) -> tensor<?x?xf32>
        flow.dispatch.tensor.store %7, %3, offsets = [0, 0], sizes = [%0, %1], strides = [1, 1] : tensor<?x?xf32> -> !flow.dispatch.tensor<writeonly:tensor<?x?xf32>>{%0, %1}
        return
      }
    }
  }
  func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
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
    %5 = stream.cmd.execute await(%result_timepoint) => with(%4 as %arg1: !stream.resource<external>{%3}, %result as %arg2: !stream.resource<external>{%3}) {
      stream.cmd.dispatch @main_dispatch_0::@main_dispatch_0_matmul_DxDxD_f32[%0, %1](%0, %1 : index, index) {
        ro %arg1[%c0 for %3] : !stream.resource<external>{%3},
        wo %arg2[%c0 for %3] : !stream.resource<external>{%3}
      }
    } => !stream.timepoint
    %6 = stream.timepoint.await %5 => %result : !stream.resource<external>{%3}
    %7 = stream.tensor.export %6 : tensor<?x?xf32>{%0, %1} in !stream.resource<external>{%3} -> !hal.buffer_view
    return %7 : !hal.buffer_view
  }
}


