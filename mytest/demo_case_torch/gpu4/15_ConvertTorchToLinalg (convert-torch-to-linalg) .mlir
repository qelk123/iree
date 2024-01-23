
func.func private @forward(%arg0: !torch.vtensor<[4],f32>) -> !torch.vtensor<[3],f32> attributes {torch.assume_strict_symbolic_shapes} {
  %0 = torch_c.to_builtin_tensor %arg0 : !torch.vtensor<[4],f32> -> tensor<4xf32>
  %int1 = torch.constant.int 1
  %1 = torch_c.to_i64 %int1
  %int0 = torch.constant.int 0
  %expanded = tensor.expand_shape %0 [[0, 1]] : tensor<4xf32> into tensor<1x4xf32>
  %_params.weight = util.global.load @_params.weight : tensor<4x3xf32>
  %2 = torch_c.from_builtin_tensor %_params.weight : tensor<4x3xf32> -> !torch.vtensor<[4,3],f32>
  %3 = torch_c.to_builtin_tensor %2 : !torch.vtensor<[4,3],f32> -> tensor<4x3xf32>
  %c0 = arith.constant 0 : index
  %dim = tensor.dim %expanded, %c0 : tensor<1x4xf32>
  %c1 = arith.constant 1 : index
  %dim_0 = tensor.dim %3, %c1 : tensor<4x3xf32>
  %4 = tensor.empty(%dim, %dim_0) : tensor<?x?xf32>
  %cst = arith.constant 0.000000e+00 : f32
  %5 = linalg.fill ins(%cst : f32) outs(%4 : tensor<?x?xf32>) -> tensor<?x?xf32>
  %6 = linalg.matmul ins(%expanded, %3 : tensor<1x4xf32>, tensor<4x3xf32>) outs(%5 : tensor<?x?xf32>) -> tensor<?x?xf32>
  %cast = tensor.cast %6 : tensor<?x?xf32> to tensor<1x3xf32>
  %collapsed = tensor.collapse_shape %cast [[0, 1]] : tensor<1x3xf32> into tensor<3xf32>
  %_params.bias = util.global.load @_params.bias : tensor<3xf32>
  %7 = torch_c.from_builtin_tensor %_params.bias : tensor<3xf32> -> !torch.vtensor<[3],f32>
  %8 = torch_c.to_builtin_tensor %7 : !torch.vtensor<[3],f32> -> tensor<3xf32>
  %c1_1 = arith.constant 1 : index
  %c0_2 = arith.constant 0 : index
  %c3 = arith.constant 3 : index
  %c0_3 = arith.constant 0 : index
  %c3_4 = arith.constant 3 : index
  %9 = tensor.empty() : tensor<3xf32>
  %10 = linalg.generic {indexing_maps = [affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>], iterator_types = ["parallel"]} ins(%collapsed, %8 : tensor<3xf32>, tensor<3xf32>) outs(%9 : tensor<3xf32>) {
  ^bb0(%in: f32, %in_16: f32, %out: f32):
    %16 = arith.sitofp %1 : i64 to f32
    %17 = arith.mulf %in_16, %16 : f32
    %18 = arith.addf %in, %17 : f32
    linalg.yield %18 : f32
  } -> tensor<3xf32>
  %cast_5 = tensor.cast %10 : tensor<3xf32> to tensor<3xf32>
  %c1_6 = arith.constant 1 : index
  %c0_7 = arith.constant 0 : index
  %c3_8 = arith.constant 3 : index
  %11 = tensor.empty() : tensor<3xf32>
  %12 = linalg.generic {indexing_maps = [affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>], iterator_types = ["parallel"]} ins(%collapsed : tensor<3xf32>) outs(%11 : tensor<3xf32>) {
  ^bb0(%in: f32, %out: f32):
    %16 = math.absf %in : f32
    linalg.yield %16 : f32
  } -> tensor<3xf32>
  %cast_9 = tensor.cast %12 : tensor<3xf32> to tensor<3xf32>
  %c1_10 = arith.constant 1 : index
  %c0_11 = arith.constant 0 : index
  %c3_12 = arith.constant 3 : index
  %c0_13 = arith.constant 0 : index
  %c3_14 = arith.constant 3 : index
  %13 = tensor.empty() : tensor<3xf32>
  %14 = linalg.generic {indexing_maps = [affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>, affine_map<(d0) -> (d0)>], iterator_types = ["parallel"]} ins(%cast_5, %cast_9 : tensor<3xf32>, tensor<3xf32>) outs(%13 : tensor<3xf32>) {
  ^bb0(%in: f32, %in_16: f32, %out: f32):
    %16 = arith.sitofp %1 : i64 to f32
    %17 = arith.mulf %in_16, %16 : f32
    %18 = arith.addf %in, %17 : f32
    linalg.yield %18 : f32
  } -> tensor<3xf32>
  %cast_15 = tensor.cast %14 : tensor<3xf32> to tensor<3xf32>
  %15 = torch_c.from_builtin_tensor %cast_15 : tensor<3xf32> -> !torch.vtensor<[3],f32>
  return %15 : !torch.vtensor<[3],f32>
}

