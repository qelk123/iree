
func.func private @forward(%arg0: !torch.vtensor<[4],f32>) -> !torch.vtensor<[3],f32> attributes {torch.assume_strict_symbolic_shapes} {
  %0 = torch_c.to_builtin_tensor %arg0 : !torch.vtensor<[4],f32> -> tensor<4xf32>
  %c1_i64 = arith.constant 1 : i64
  %1 = torch_c.from_i64 %c1_i64
  %2 = torch_c.to_i64 %1
  %c0_i64 = arith.constant 0 : i64
  %expanded = tensor.expand_shape %0 [[0, 1]] : tensor<4xf32> into tensor<1x4xf32>
  %_params.weight = util.global.load @_params.weight : tensor<4x3xf32>
  %3 = torch_c.from_builtin_tensor %_params.weight : tensor<4x3xf32> -> !torch.vtensor<[4,3],f32>
  %4 = torch_c.to_builtin_tensor %3 : !torch.vtensor<[4,3],f32> -> tensor<4x3xf32>
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c1_0 = arith.constant 1 : index
  %c3 = arith.constant 3 : index
  %5 = tensor.empty(%c1, %c3) : tensor<?x?xf32>
  %cst = arith.constant 0.000000e+00 : f32
  %6 = linalg.fill ins(%cst : f32) outs(%5 : tensor<?x?xf32>) -> tensor<?x?xf32>
  %7 = linalg.matmul ins(%expanded, %4 : tensor<1x4xf32>, tensor<4x3xf32>) outs(%6 : tensor<?x?xf32>) -> tensor<?x?xf32>
  %cast = tensor.cast %7 : tensor<?x?xf32> to tensor<1x3xf32>
  %collapsed = tensor.collapse_shape %cast [[0, 1]] : tensor<1x3xf32> into tensor<3xf32>
  %_params.bias = util.global.load @_params.bias : tensor<3xf32>
  %8 = torch_c.from_builtin_tensor %_params.bias : tensor<3xf32> -> !torch.vtensor<[3],f32>
  %9 = torch_c.to_builtin_tensor %8 : !torch.vtensor<[3],f32> -> tensor<3xf32>
  %c1_1 = arith.constant 1 : index
  %c0_2 = arith.constant 0 : index
  %c3_3 = arith.constant 3 : index
  %c0_4 = arith.constant 0 : index
  %c3_5 = arith.constant 3 : index
  %10 = tensor.empty() : tensor<3xf32>
  %11 = linalg.generic {indexing_maps = [affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>], iterator_types = ["parallel"]} ins(%collapsed, %9 : tensor<3xf32>, tensor<3xf32>) outs(%10 : tensor<3xf32>) {
  ^bb0(%in: f32, %in_14: f32, %out: f32):
    %17 = arith.sitofp %2 : i64 to f32
    %18 = arith.mulf %in_14, %17 : f32
    %19 = arith.addf %in, %18 : f32
    linalg.yield %19 : f32
  } -> tensor<3xf32>
  %c1_6 = arith.constant 1 : index
  %c0_7 = arith.constant 0 : index
  %c3_8 = arith.constant 3 : index
  %12 = tensor.empty() : tensor<3xf32>
  %13 = linalg.generic {indexing_maps = [affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>], iterator_types = ["parallel"]} ins(%collapsed : tensor<3xf32>) outs(%12 : tensor<3xf32>) {
  ^bb0(%in: f32, %out: f32):
    %17 = math.absf %in : f32
    linalg.yield %17 : f32
  } -> tensor<3xf32>
  %c1_9 = arith.constant 1 : index
  %c0_10 = arith.constant 0 : index
  %c3_11 = arith.constant 3 : index
  %c0_12 = arith.constant 0 : index
  %c3_13 = arith.constant 3 : index
  %14 = tensor.empty() : tensor<3xf32>
  %15 = linalg.generic {indexing_maps = [affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>], iterator_types = ["parallel"]} ins(%11, %13 : tensor<3xf32>, tensor<3xf32>) outs(%14 : tensor<3xf32>) {
  ^bb0(%in: f32, %in_14: f32, %out: f32):
    %17 = arith.sitofp %2 : i64 to f32
    %18 = arith.mulf %in_14, %17 : f32
    %19 = arith.addf %in, %18 : f32
    linalg.yield %19 : f32
  } -> tensor<3xf32>
  %16 = torch_c.from_builtin_tensor %15 : tensor<3xf32> -> !torch.vtensor<[3],f32>
  return %16 : !torch.vtensor<[3],f32>
}

