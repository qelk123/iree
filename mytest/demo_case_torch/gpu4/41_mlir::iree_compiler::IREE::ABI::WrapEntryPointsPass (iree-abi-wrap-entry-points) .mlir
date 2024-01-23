
#executable_target_cuda_nvptx_fb = #hal.executable.target<"cuda", "cuda-nvptx-fb", {target_arch = "sm_75"}>
#map = affine_map<(d0) -> (d0)>
#device_target_cuda = #hal.device.target<"cuda", {executable_targets = [#executable_target_cuda_nvptx_fb], legacy_sync}>
module @LinearModule attributes {hal.device.targets = [#device_target_cuda]} {
  util.global private @_params.weight {noinline} = dense<[[1.54099607, -0.293428898, -2.17878938], [0.568431258, -1.08452237, -1.39859545], [0.403346837, 0.838026344, -0.719257593], [-0.403343529, -0.596635341, 0.182036489]]> : tensor<4x3xf32>
  util.global private @_params.bias {noinline} = dense<[-0.856674611, 1.10060418, -1.07118738]> : tensor<3xf32>
  func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
    %0 = hal.tensor.import %arg0 "input 0" : !hal.buffer_view -> tensor<4xf32>
    %1 = call @_main(%0) : (tensor<4xf32>) -> tensor<3xf32>
    %2 = hal.tensor.export %1 "output 0" : tensor<3xf32> -> !hal.buffer_view
    return %2 : !hal.buffer_view
  }
  func.func private @_main(%arg0: tensor<4xf32>) -> tensor<3xf32> attributes {torch.args_schema = "[1, {\22type\22: \22builtins.tuple\22, \22context\22: \22null\22, \22children_spec\22: [{\22type\22: \22builtins.list\22, \22context\22: \22null\22, \22children_spec\22: [{\22type\22: null, \22context\22: null, \22children_spec\22: []}]}, {\22type\22: \22builtins.dict\22, \22context\22: \22[]\22, \22children_spec\22: []}]}]", torch.assume_strict_symbolic_shapes, torch.return_schema = "[1, {\22type\22: null, \22context\22: null, \22children_spec\22: []}]"} {
    %0 = call @forward(%arg0) : (tensor<4xf32>) -> tensor<3xf32>
    return %0 : tensor<3xf32>
  }
  func.func private @forward(%arg0: tensor<4xf32>) -> tensor<3xf32> attributes {torch.assume_strict_symbolic_shapes} {
    %cst = arith.constant 0.000000e+00 : f32
    %expanded = tensor.expand_shape %arg0 [[0, 1]] : tensor<4xf32> into tensor<1x4xf32>
    %_params.weight = util.global.load @_params.weight : tensor<4x3xf32>
    %0 = tensor.empty() : tensor<1x3xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<1x3xf32>) -> tensor<1x3xf32>
    %2 = linalg.matmul ins(%expanded, %_params.weight : tensor<1x4xf32>, tensor<4x3xf32>) outs(%1 : tensor<1x3xf32>) -> tensor<1x3xf32>
    %collapsed = tensor.collapse_shape %2 [[0, 1]] : tensor<1x3xf32> into tensor<3xf32>
    %_params.bias = util.global.load @_params.bias : tensor<3xf32>
    %3 = tensor.empty() : tensor<3xf32>
    %4 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%collapsed, %_params.bias : tensor<3xf32>, tensor<3xf32>) outs(%3 : tensor<3xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %7 = arith.addf %in, %in_0 : f32
      linalg.yield %7 : f32
    } -> tensor<3xf32>
    %5 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%collapsed : tensor<3xf32>) outs(%3 : tensor<3xf32>) {
    ^bb0(%in: f32, %out: f32):
      %7 = math.absf %in : f32
      linalg.yield %7 : f32
    } -> tensor<3xf32>
    %6 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%4, %5 : tensor<3xf32>, tensor<3xf32>) outs(%3 : tensor<3xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %7 = arith.addf %in, %in_0 : f32
      linalg.yield %7 : f32
    } -> tensor<3xf32>
    return %6 : tensor<3xf32>
  }
}


