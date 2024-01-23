
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
  %4 = linalg.generic {indexing_maps = [affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>], iterator_types = ["parallel"]} ins(%collapsed, %_params.bias : tensor<3xf32>, tensor<3xf32>) outs(%3 : tensor<3xf32>) {
  ^bb0(%in: f32, %in_0: f32, %out: f32):
    %7 = arith.addf %in, %in_0 : f32
    linalg.yield %7 : f32
  } -> tensor<3xf32>
  %5 = linalg.generic {indexing_maps = [affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>], iterator_types = ["parallel"]} ins(%collapsed : tensor<3xf32>) outs(%3 : tensor<3xf32>) {
  ^bb0(%in: f32, %out: f32):
    %7 = math.absf %in : f32
    linalg.yield %7 : f32
  } -> tensor<3xf32>
  %6 = linalg.generic {indexing_maps = [affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>], iterator_types = ["parallel"]} ins(%4, %5 : tensor<3xf32>, tensor<3xf32>) outs(%3 : tensor<3xf32>) {
  ^bb0(%in: f32, %in_0: f32, %out: f32):
    %7 = arith.addf %in, %in_0 : f32
    linalg.yield %7 : f32
  } -> tensor<3xf32>
  return %6 : tensor<3xf32>
}

