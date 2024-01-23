
#executable_target_cuda_nvptx_fb = #hal.executable.target<"cuda", "cuda-nvptx-fb", {target_arch = "sm_75"}>
#map = affine_map<(d0, d1) -> (d0, d1)>
#device_target_cuda = #hal.device.target<"cuda", {executable_targets = [#executable_target_cuda_nvptx_fb], legacy_sync}>
module @LinearModule attributes {hal.device.targets = [#device_target_cuda]} {
  util.global private @_params.weight {noinline} = dense<[[1.54099607, -0.293428898, -2.17878938], [0.568431258, -1.08452237, -1.39859545], [0.403346837, 0.838026344, -0.719257593], [-0.403343529, -0.596635341, 0.182036489]]> : tensor<4x3xf32>
  util.global private @_params.bias {noinline} = dense<[-0.856674611, 1.10060418, -1.07118738]> : tensor<3xf32>
  flow.executable private @main_dispatch_0 {
    flow.executable.export public @main_dispatch_0_matmul_1x3x4_f32 workgroups() -> (index, index, index) {
      %x, %y, %z = flow.dispatch.workgroup_count_from_slice 
      flow.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_0_matmul_1x3x4_f32(%arg0: !flow.dispatch.tensor<readonly:tensor<1x4xf32>>, %arg1: !flow.dispatch.tensor<readonly:tensor<4x3xf32>>, %arg2: !flow.dispatch.tensor<readonly:tensor<1x3xf32>>, %arg3: !flow.dispatch.tensor<writeonly:tensor<1x3xf32>>) {
        %cst = arith.constant 0.000000e+00 : f32
        %0 = flow.dispatch.tensor.load %arg0, offsets = [0, 0], sizes = [1, 4], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<1x4xf32>> -> tensor<1x4xf32>
        %1 = flow.dispatch.tensor.load %arg1, offsets = [0, 0], sizes = [4, 3], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<4x3xf32>> -> tensor<4x3xf32>
        %2 = flow.dispatch.tensor.load %arg2, offsets = [0, 0], sizes = [1, 3], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<1x3xf32>> -> tensor<1x3xf32>
        %3 = tensor.empty() : tensor<1x3xf32>
        %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<1x3xf32>) -> tensor<1x3xf32>
        %5 = linalg.matmul ins(%0, %1 : tensor<1x4xf32>, tensor<4x3xf32>) outs(%4 : tensor<1x3xf32>) -> tensor<1x3xf32>
        %6 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%5, %2 : tensor<1x3xf32>, tensor<1x3xf32>) outs(%3 : tensor<1x3xf32>) {
        ^bb0(%in: f32, %in_0: f32, %out: f32):
          %7 = math.absf %in : f32
          %8 = arith.addf %in, %in_0 : f32
          %9 = arith.addf %8, %7 : f32
          linalg.yield %9 : f32
        } -> tensor<1x3xf32>
        flow.dispatch.tensor.store %6, %arg3, offsets = [0, 0], sizes = [1, 3], strides = [1, 1] : tensor<1x3xf32> -> !flow.dispatch.tensor<writeonly:tensor<1x3xf32>>
        return
      }
    }
  }
  func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
    %_params.weight = util.global.load @_params.weight : tensor<4x3xf32>
    %_params.bias = util.global.load @_params.bias : tensor<3xf32>
    %0 = hal.tensor.import %arg0 "input 0" : !hal.buffer_view -> tensor<4xf32>
    %1 = flow.tensor.reshape %0 : tensor<4xf32> -> tensor<1x4xf32>
    %2 = flow.tensor.reshape %_params.bias : tensor<3xf32> -> tensor<1x3xf32>
    %3 = flow.dispatch @main_dispatch_0::@main_dispatch_0_matmul_1x3x4_f32(%1, %_params.weight, %2) : (tensor<1x4xf32>, tensor<4x3xf32>, tensor<1x3xf32>) -> tensor<1x3xf32>
    %4 = flow.tensor.reshape %3 : tensor<1x3xf32> -> tensor<3xf32>
    %5 = hal.tensor.export %4 "output 0" : tensor<3xf32> -> !hal.buffer_view
    return %5 : !hal.buffer_view
  }
}


