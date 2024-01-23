
func.func private @forward(%arg0: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> attributes {torch.assume_strict_symbolic_shapes} {
  %cst = arith.constant 0.000000e+00 : f32
  %c1 = arith.constant 1 : index
  %c0 = arith.constant 0 : index
  %0 = torch_c.to_builtin_tensor %arg0 : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
  %dim = tensor.dim %0, %c0 : tensor<?x?xf32>
  %dim_0 = tensor.dim %0, %c1 : tensor<?x?xf32>
  %1 = tensor.empty(%dim, %dim_0) : tensor<?x?xf32>
  %2 = linalg.fill ins(%cst : f32) outs(%1 : tensor<?x?xf32>) -> tensor<?x?xf32>
  %3 = linalg.matmul ins(%0, %0 : tensor<?x?xf32>, tensor<?x?xf32>) outs(%2 : tensor<?x?xf32>) -> tensor<?x?xf32>
  %4 = torch_c.from_builtin_tensor %3 : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
  return %4 : !torch.vtensor<[?,?],f32>
}

