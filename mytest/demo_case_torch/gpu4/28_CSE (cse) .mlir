
func.func private @forward(%arg0: !torch.vtensor<[4],f32>) -> !torch.vtensor<[3],f32> attributes {torch.assume_strict_symbolic_shapes} {
  %cst = arith.constant 0.000000e+00 : f32
  %0 = torch_c.to_builtin_tensor %arg0 : !torch.vtensor<[4],f32> -> tensor<4xf32>
  %expanded = tensor.expand_shape %0 [[0, 1]] : tensor<4xf32> into tensor<1x4xf32>
  %_params.weight = util.global.load @_params.weight : tensor<4x3xf32>
  %1 = torch_c.from_builtin_tensor %_params.weight : tensor<4x3xf32> -> !torch.vtensor<[4,3],f32>
  %2 = torch_c.to_builtin_tensor %1 : !torch.vtensor<[4,3],f32> -> tensor<4x3xf32>
  %3 = tensor.empty() : tensor<1x3xf32>
  %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<1x3xf32>) -> tensor<1x3xf32>
  %5 = linalg.matmul ins(%expanded, %2 : tensor<1x4xf32>, tensor<4x3xf32>) outs(%4 : tensor<1x3xf32>) -> tensor<1x3xf32>
  %collapsed = tensor.collapse_shape %5 [[0, 1]] : tensor<1x3xf32> into tensor<3xf32>
  %_params.bias = util.global.load @_params.bias : tensor<3xf32>
  %6 = torch_c.from_builtin_tensor %_params.bias : tensor<3xf32> -> !torch.vtensor<[3],f32>
  %7 = torch_c.to_builtin_tensor %6 : !torch.vtensor<[3],f32> -> tensor<3xf32>
  %8 = tensor.empty() : tensor<3xf32>
  %9 = linalg.generic {indexing_maps = [affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>], iterator_types = ["parallel"]} ins(%collapsed, %7 : tensor<3xf32>, tensor<3xf32>) outs(%8 : tensor<3xf32>) {
  ^bb0(%in: f32, %in_0: f32, %out: f32):
    %13 = arith.addf %in, %in_0 : f32
    linalg.yield %13 : f32
  } -> tensor<3xf32>
  %10 = linalg.generic {indexing_maps = [affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>], iterator_types = ["parallel"]} ins(%collapsed : tensor<3xf32>) outs(%8 : tensor<3xf32>) {
  ^bb0(%in: f32, %out: f32):
    %13 = math.absf %in : f32
    linalg.yield %13 : f32
  } -> tensor<3xf32>
  %11 = linalg.generic {indexing_maps = [affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>], iterator_types = ["parallel"]} ins(%9, %10 : tensor<3xf32>, tensor<3xf32>) outs(%8 : tensor<3xf32>) {
  ^bb0(%in: f32, %in_0: f32, %out: f32):
    %13 = arith.addf %in, %in_0 : f32
    linalg.yield %13 : f32
  } -> tensor<3xf32>
  %12 = torch_c.from_builtin_tensor %11 : tensor<3xf32> -> !torch.vtensor<[3],f32>
  return %12 : !torch.vtensor<[3],f32>
}

