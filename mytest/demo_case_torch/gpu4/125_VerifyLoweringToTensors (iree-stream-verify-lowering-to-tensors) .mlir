
#executable_target_cuda_nvptx_fb = #hal.executable.target<"cuda", "cuda-nvptx-fb", {target_arch = "sm_75"}>
#map = affine_map<(d0, d1) -> (d0, d1)>
#device_target_cuda = #hal.device.target<"cuda", {executable_targets = [#executable_target_cuda_nvptx_fb], legacy_sync}>
module @LinearModule attributes {hal.device.targets = [#device_target_cuda]} {
  util.global private @_params.weight : !stream.resource<constant>
  util.global private @_params.weight__size : index
  util.initializer {
    %cst = stream.tensor.constant : tensor<4x3xf32> in !stream.resource<constant> = dense<[[1.54099607, -0.293428898, -2.17878938], [0.568431258, -1.08452237, -1.39859545], [0.403346837, 0.838026344, -0.719257593], [-0.403343529, -0.596635341, 0.182036489]]> : tensor<4x3xf32>
    %0 = stream.resource.size %cst : !stream.resource<constant>
    util.global.store %cst, @_params.weight : !stream.resource<constant>
    util.global.store %0, @_params.weight__size : index
    util.initializer.return
  }
  util.global private @_params.bias : !stream.resource<constant>
  util.global private @_params.bias__size : index
  util.initializer {
    %cst = stream.tensor.constant : tensor<3xf32> in !stream.resource<constant> = dense<[-0.856674611, 1.10060418, -1.07118738]> : tensor<3xf32>
    %0 = stream.resource.size %cst : !stream.resource<constant>
    util.global.store %cst, @_params.bias : !stream.resource<constant>
    util.global.store %0, @_params.bias__size : index
    util.initializer.return
  }
  stream.executable private @main_dispatch_0 {
    stream.executable.export public @main_dispatch_0_matmul_1x3x4_f32 workgroups() -> (index, index, index) {
      %x, %y, %z = flow.dispatch.workgroup_count_from_slice 
      stream.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_0_matmul_1x3x4_f32(%arg0: !stream.binding, %arg1: !stream.binding, %arg2: !stream.binding, %arg3: !stream.binding) {
        %c0 = arith.constant 0 : index
        %0 = stream.binding.subspan %arg0[%c0] : !stream.binding -> !flow.dispatch.tensor<readonly:tensor<1x4xf32>>
        %1 = stream.binding.subspan %arg1[%c0] : !stream.binding -> !flow.dispatch.tensor<readonly:tensor<4x3xf32>>
        %2 = stream.binding.subspan %arg2[%c0] : !stream.binding -> !flow.dispatch.tensor<readonly:tensor<1x3xf32>>
        %3 = stream.binding.subspan %arg3[%c0] : !stream.binding -> !flow.dispatch.tensor<writeonly:tensor<1x3xf32>>
        %cst = arith.constant 0.000000e+00 : f32
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
    %_params.weight = util.global.load @_params.weight : !stream.resource<constant>
    %_params.weight__size = util.global.load @_params.weight__size : index
    %0 = stream.async.transfer %_params.weight : !stream.resource<constant>{%_params.weight__size} -> !stream.resource<*>{%_params.weight__size}
    %_params.bias = util.global.load @_params.bias : !stream.resource<constant>
    %_params.bias__size = util.global.load @_params.bias__size : index
    %1 = stream.async.transfer %_params.bias : !stream.resource<constant>{%_params.bias__size} -> !stream.resource<*>{%_params.bias__size}
    %c553648160_i32 = arith.constant 553648160 : i32
    %c1_i32 = arith.constant 1 : i32
    %c4 = arith.constant 4 : index
    hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input 0") shape([%c4]) type(%c553648160_i32) encoding(%c1_i32)
    %2 = stream.tensor.sizeof tensor<4xf32> : index
    %3 = stream.tensor.import %arg0 : !hal.buffer_view -> tensor<4xf32> in !stream.resource<external>{%2}
    %4 = stream.async.transfer %3 : !stream.resource<external>{%2} -> !stream.resource<*>{%2}
    %5 = stream.tensor.sizeof tensor<1x4xf32> : index
    %6 = stream.tensor.clone %4 : tensor<4xf32> in !stream.resource<*>{%2} -> tensor<1x4xf32> in !stream.resource<*>{%5}
    %7 = stream.tensor.sizeof tensor<1x3xf32> : index
    %8 = stream.tensor.clone %1 : tensor<3xf32> in !stream.resource<*>{%_params.bias__size} -> tensor<1x3xf32> in !stream.resource<*>{%7}
    %c0 = arith.constant 0 : index
    %9 = stream.tensor.sizeof tensor<1x3xf32> : index
    %10 = stream.async.dispatch @main_dispatch_0::@main_dispatch_0_matmul_1x3x4_f32(%6[%c0 to %5 for %5], %0[%c0 to %_params.weight__size for %_params.weight__size], %8[%c0 to %7 for %7]) : (!stream.resource<*>{%5}, !stream.resource<*>{%_params.weight__size}, !stream.resource<*>{%7}) -> !stream.resource<*>{%9}
    %11 = stream.tensor.sizeof tensor<3xf32> : index
    %12 = stream.tensor.clone %10 : tensor<1x3xf32> in !stream.resource<*>{%9} -> tensor<3xf32> in !stream.resource<*>{%11}
    %13 = stream.async.transfer %12 : !stream.resource<*>{%11} -> !stream.resource<external>{%11}
    %14 = stream.tensor.export %13 : tensor<3xf32> in !stream.resource<external>{%11} -> !hal.buffer_view
    return %14 : !hal.buffer_view
  }
}


