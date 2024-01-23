
#executable_target_cuda_nvptx_fb = #hal.executable.target<"cuda", "cuda-nvptx-fb", {target_arch = "sm_75"}>
#map = affine_map<(d0) -> (d0)>
#device_target_cuda = #hal.device.target<"cuda", {executable_targets = [#executable_target_cuda_nvptx_fb], legacy_sync}>
module @LinearModule attributes {hal.device.targets = [#device_target_cuda]} {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  util.global private @_params.weight {noinline} = dense<[[1.54099607, -0.293428898, -2.17878938], [0.568431258, -1.08452237, -1.39859545], [0.403346837, 0.838026344, -0.719257593], [-0.403343529, -0.596635341, 0.182036489]]> : tensor<4x3xf32>
  util.global private @_params.bias {noinline} = dense<[-0.856674611, 1.10060418, -1.07118738]> : tensor<3xf32>
  func.func @main(%arg0: tensor<4xf32>) -> tensor<3xf32> attributes {torch.args_schema = "[1, {\22type\22: \22builtins.tuple\22, \22context\22: \22null\22, \22children_spec\22: [{\22type\22: \22builtins.list\22, \22context\22: \22null\22, \22children_spec\22: [{\22type\22: null, \22context\22: null, \22children_spec\22: []}]}, {\22type\22: \22builtins.dict\22, \22context\22: \22[]\22, \22children_spec\22: []}]}]", torch.assume_strict_symbolic_shapes, torch.return_schema = "[1, {\22type\22: null, \22context\22: null, \22children_spec\22: []}]"} {
    %0 = torch_c.from_builtin_tensor %arg0 : tensor<4xf32> -> !torch.vtensor<[4],f32>
    %1 = torch_c.to_builtin_tensor %0 : !torch.vtensor<[4],f32> -> tensor<4xf32>
    %2 = call @forward(%1) : (tensor<4xf32>) -> tensor<3xf32>
    %3 = torch_c.from_builtin_tensor %2 : tensor<3xf32> -> !torch.vtensor<[3],f32>
    %4 = torch_c.to_builtin_tensor %3 : !torch.vtensor<[3],f32> -> tensor<3xf32>
    return %4 : tensor<3xf32>
  }
  func.func private @forward(%arg0: tensor<4xf32>) -> tensor<3xf32> attributes {torch.assume_strict_symbolic_shapes} {
    %0 = torch_c.from_builtin_tensor %arg0 : tensor<4xf32> -> !torch.vtensor<[4],f32>
    %cst = arith.constant 0.000000e+00 : f32
    %1 = torch_c.to_builtin_tensor %0 : !torch.vtensor<[4],f32> -> tensor<4xf32>
    %expanded = tensor.expand_shape %1 [[0, 1]] : tensor<4xf32> into tensor<1x4xf32>
    %_params.weight = util.global.load @_params.weight : tensor<4x3xf32>
    %2 = torch_c.from_builtin_tensor %_params.weight : tensor<4x3xf32> -> !torch.vtensor<[4,3],f32>
    %3 = torch_c.to_builtin_tensor %2 : !torch.vtensor<[4,3],f32> -> tensor<4x3xf32>
    %4 = tensor.empty() : tensor<1x3xf32>
    %5 = linalg.fill ins(%cst : f32) outs(%4 : tensor<1x3xf32>) -> tensor<1x3xf32>
    %6 = linalg.matmul ins(%expanded, %3 : tensor<1x4xf32>, tensor<4x3xf32>) outs(%5 : tensor<1x3xf32>) -> tensor<1x3xf32>
    %collapsed = tensor.collapse_shape %6 [[0, 1]] : tensor<1x3xf32> into tensor<3xf32>
    %_params.bias = util.global.load @_params.bias : tensor<3xf32>
    %7 = torch_c.from_builtin_tensor %_params.bias : tensor<3xf32> -> !torch.vtensor<[3],f32>
    %8 = torch_c.to_builtin_tensor %7 : !torch.vtensor<[3],f32> -> tensor<3xf32>
    %9 = tensor.empty() : tensor<3xf32>
    %10 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%collapsed, %8 : tensor<3xf32>, tensor<3xf32>) outs(%9 : tensor<3xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %15 = arith.addf %in, %in_0 : f32
      linalg.yield %15 : f32
    } -> tensor<3xf32>
    %11 = linalg.generic {indexing_maps = [#map, #map], iterator_types = ["parallel"]} ins(%collapsed : tensor<3xf32>) outs(%9 : tensor<3xf32>) {
    ^bb0(%in: f32, %out: f32):
      %15 = math.absf %in : f32
      linalg.yield %15 : f32
    } -> tensor<3xf32>
    %12 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel"]} ins(%10, %11 : tensor<3xf32>, tensor<3xf32>) outs(%9 : tensor<3xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %15 = arith.addf %in, %in_0 : f32
      linalg.yield %15 : f32
    } -> tensor<3xf32>
    %13 = torch_c.from_builtin_tensor %12 : tensor<3xf32> -> !torch.vtensor<[3],f32>
    %14 = torch_c.to_builtin_tensor %13 : !torch.vtensor<[3],f32> -> tensor<3xf32>
    return %14 : tensor<3xf32>
  }
}


