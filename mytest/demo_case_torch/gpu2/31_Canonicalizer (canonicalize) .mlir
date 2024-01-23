
func.func private @forward(%arg0: tensor<?x?xf32>) -> tensor<?x?xf32> attributes {torch.assume_strict_symbolic_shapes} {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %cst = arith.constant 0.000000e+00 : f32
  %0 = torch_c.from_builtin_tensor %arg0 : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
  %1 = torch_c.to_builtin_tensor %0 : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
  %dim = tensor.dim %1, %c0 : tensor<?x?xf32>
  %dim_0 = tensor.dim %1, %c1 : tensor<?x?xf32>
  %2 = tensor.empty(%dim, %dim_0) : tensor<?x?xf32>
  %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<?x?xf32>) -> tensor<?x?xf32>
  %4 = linalg.matmul ins(%1, %1 : tensor<?x?xf32>, tensor<?x?xf32>) outs(%3 : tensor<?x?xf32>) -> tensor<?x?xf32>
  %5 = torch_c.from_builtin_tensor %4 : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
  %6 = torch_c.to_builtin_tensor %5 : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
  return %6 : tensor<?x?xf32>
}

