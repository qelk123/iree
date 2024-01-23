
func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
  %cst = arith.constant 0.000000e+00 : f32
  %_params.weight = util.global.load @_params.weight : tensor<4x3xf32>
  %_params.bias = util.global.load @_params.bias : tensor<3xf32>
  %0 = hal.tensor.import %arg0 "input 0" : !hal.buffer_view -> tensor<4xf32>
  %expanded = tensor.expand_shape %0 [[0, 1]] : tensor<4xf32> into tensor<1x4xf32>
  %1 = tensor.empty() : tensor<1x3xf32>
  %2 = linalg.fill ins(%cst : f32) outs(%1 : tensor<1x3xf32>) -> tensor<1x3xf32>
  %expanded_0 = tensor.expand_shape %_params.bias [[0, 1]] : tensor<3xf32> into tensor<1x3xf32>
  %3 = flow.dispatch.region -> (tensor<1x3xf32>) {
    %5 = linalg.matmul ins(%expanded, %_params.weight : tensor<1x4xf32>, tensor<4x3xf32>) outs(%2 : tensor<1x3xf32>) -> tensor<1x3xf32>
    %6 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%5, %expanded_0 : tensor<1x3xf32>, tensor<1x3xf32>) outs(%1 : tensor<1x3xf32>) {
    ^bb0(%in: f32, %in_1: f32, %out: f32):
      %7 = math.absf %in : f32
      %8 = arith.addf %in, %in_1 : f32
      %9 = arith.addf %8, %7 : f32
      linalg.yield %9 : f32
    } -> tensor<1x3xf32>
    flow.return %6 : tensor<1x3xf32>
  }
  %collapsed = tensor.collapse_shape %3 [[0, 1]] : tensor<1x3xf32> into tensor<3xf32>
  %4 = hal.tensor.export %collapsed "output 0" : tensor<3xf32> -> !hal.buffer_view
  return %4 : !hal.buffer_view
}

