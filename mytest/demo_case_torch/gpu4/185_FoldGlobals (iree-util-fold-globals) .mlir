
#executable_target_cuda_nvptx_fb = #hal.executable.target<"cuda", "cuda-nvptx-fb", {target_arch = "sm_75"}>
#map = affine_map<(d0, d1) -> (d0, d1)>
#device_target_cuda = #hal.device.target<"cuda", {executable_targets = [#executable_target_cuda_nvptx_fb], legacy_sync}>
module @LinearModule attributes {hal.device.targets = [#device_target_cuda]} {
  util.global private mutable @_params.weight__timepoint = #stream.timepoint<immediate> : !stream.timepoint
  util.global private @_params.weight : !stream.resource<constant>
  util.global private mutable @_params.bias__timepoint = #stream.timepoint<immediate> : !stream.timepoint
  util.global private @_params.bias : !stream.resource<constant>
  util.initializer {
    %c48 = arith.constant 48 : index
    %c12 = arith.constant 12 : index
    %results:2, %result_timepoint = stream.async.execute with() -> (!stream.resource<constant>{%c48}, !stream.resource<constant>{%c12}) {
      %cst = stream.async.constant : !stream.resource<constant>{%c48} = dense<[[1.54099607, -0.293428898, -2.17878938], [0.568431258, -1.08452237, -1.39859545], [0.403346837, 0.838026344, -0.719257593], [-0.403343529, -0.596635341, 0.182036489]]> : tensor<4x3xf32>
      %cst_0 = stream.async.constant : !stream.resource<constant>{%c12} = dense<[-0.856674611, 1.10060418, -1.07118738]> : tensor<3xf32>
      stream.yield %cst, %cst_0 : !stream.resource<constant>{%c48}, !stream.resource<constant>{%c12}
    } => !stream.timepoint
    util.global.store %results#1, @_params.bias : !stream.resource<constant>
    util.global.store %result_timepoint, @_params.bias__timepoint : !stream.timepoint
    util.global.store %results#0, @_params.weight : !stream.resource<constant>
    util.global.store %result_timepoint, @_params.weight__timepoint : !stream.timepoint
    util.initializer.return
  }
  stream.executable private @main_dispatch_0 {
    stream.executable.export public @main_dispatch_0_matmul_1x3x4_f32 workgroups() -> (index, index, index) {
      %x, %y, %z = flow.dispatch.workgroup_count_from_slice 
      stream.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_0_matmul_1x3x4_f32(%arg0: !stream.binding, %arg1: !stream.binding, %arg2: !stream.binding, %arg3: !stream.binding) {
        %cst = arith.constant 0.000000e+00 : f32
        %c0 = arith.constant 0 : index
        %0 = stream.binding.subspan %arg0[%c0] : !stream.binding -> !flow.dispatch.tensor<readonly:tensor<1x4xf32>>
        %1 = stream.binding.subspan %arg1[%c0] : !stream.binding -> !flow.dispatch.tensor<readonly:tensor<4x3xf32>>
        %2 = stream.binding.subspan %arg2[%c0] : !stream.binding -> !flow.dispatch.tensor<readonly:tensor<1x3xf32>>
        %3 = stream.binding.subspan %arg3[%c0] : !stream.binding -> !flow.dispatch.tensor<writeonly:tensor<1x3xf32>>
        %4 = flow.dispatch.tensor.load %0, offsets = [0, 0], sizes = [1, 4], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<1x4xf32>> -> tensor<1x4xf32>
        %5 = flow.dispatch.tensor.load %1, offsets = [0, 0], sizes = [4, 3], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<4x3xf32>> -> tensor<4x3xf32>
        %6 = flow.dispatch.tensor.load %2, offsets = [0, 0], sizes = [1, 3], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<1x3xf32>> -> tensor<1x3xf32>
        %7 = tensor.empty() : tensor<1x3xf32>
        %8 = linalg.fill ins(%cst : f32) outs(%7 : tensor<1x3xf32>) -> tensor<1x3xf32>
        %9 = linalg.matmul ins(%4, %5 : tensor<1x4xf32>, tensor<4x3xf32>) outs(%8 : tensor<1x3xf32>) -> tensor<1x3xf32>
        %10 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%9, %6 : tensor<1x3xf32>, tensor<1x3xf32>) outs(%7 : tensor<1x3xf32>) {
        ^bb0(%in: f32, %in_0: f32, %out: f32):
          %11 = math.absf %in : f32
          %12 = arith.addf %in, %in_0 : f32
          %13 = arith.addf %12, %11 : f32
          linalg.yield %13 : f32
        } -> tensor<1x3xf32>
        flow.dispatch.tensor.store %10, %3, offsets = [0, 0], sizes = [1, 3], strides = [1, 1] : tensor<1x3xf32> -> !flow.dispatch.tensor<writeonly:tensor<1x3xf32>>
        return
      }
    }
  }
  func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
    %c48 = arith.constant 48 : index
    %c0 = arith.constant 0 : index
    %c4 = arith.constant 4 : index
    %c1_i32 = arith.constant 1 : i32
    %c553648160_i32 = arith.constant 553648160 : i32
    %c12 = arith.constant 12 : index
    %c16 = arith.constant 16 : index
    %_params.weight__timepoint = util.global.load @_params.weight__timepoint : !stream.timepoint
    %_params.bias__timepoint = util.global.load @_params.bias__timepoint : !stream.timepoint
    %_params.weight = util.global.load @_params.weight : !stream.resource<constant>
    %_params.bias = util.global.load @_params.bias : !stream.resource<constant>
    hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input 0") shape([%c4]) type(%c553648160_i32) encoding(%c1_i32)
    %0 = stream.tensor.import %arg0 : !hal.buffer_view -> tensor<4xf32> in !stream.resource<external>{%c16}
    %1 = stream.timepoint.join max(%_params.weight__timepoint, %_params.bias__timepoint) => !stream.timepoint
    %results, %result_timepoint = stream.async.execute await(%1) => with(%0 as %arg1: !stream.resource<external>{%c16}, %_params.weight as %arg2: !stream.resource<constant>{%c48}, %_params.bias as %arg3: !stream.resource<constant>{%c12}) -> !stream.resource<external>{%c12} {
      %4 = stream.async.dispatch @main_dispatch_0::@main_dispatch_0_matmul_1x3x4_f32(%arg1[%c0 to %c16 for %c16], %arg2[%c0 to %c48 for %c48], %arg3[%c0 to %c12 for %c12]) : (!stream.resource<external>{%c16}, !stream.resource<constant>{%c48}, !stream.resource<constant>{%c12}) -> !stream.resource<external>{%c12}
      stream.yield %4 : !stream.resource<external>{%c12}
    } => !stream.timepoint
    %2 = stream.timepoint.await %result_timepoint => %results : !stream.resource<external>{%c12}
    %3 = stream.tensor.export %2 : tensor<3xf32> in !stream.resource<external>{%c12} -> !hal.buffer_view
    return %3 : !hal.buffer_view
  }
}


