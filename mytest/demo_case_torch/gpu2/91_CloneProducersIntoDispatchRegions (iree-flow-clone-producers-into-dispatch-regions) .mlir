
func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
  %cst = arith.constant 0.000000e+00 : f32
  %0 = hal.buffer_view.dim<%arg0 : !hal.buffer_view>[0] : index
  %1 = hal.buffer_view.dim<%arg0 : !hal.buffer_view>[1] : index
  %2 = hal.tensor.import %arg0 "input 0" : !hal.buffer_view -> tensor<?x?xf32>{%0, %1}
  %3 = tensor.empty(%0, %1) : tensor<?x?xf32>
  %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<?x?xf32>) -> tensor<?x?xf32>
  %5 = flow.dispatch.region -> (tensor<?x?xf32>{%0, %1}) {
    %7 = tensor.empty(%0, %1) : tensor<?x?xf32>
    %cst_0 = arith.constant 0.000000e+00 : f32
    %8 = linalg.fill ins(%cst_0 : f32) outs(%7 : tensor<?x?xf32>) -> tensor<?x?xf32>
    %9 = linalg.matmul ins(%2, %2 : tensor<?x?xf32>, tensor<?x?xf32>) outs(%8 : tensor<?x?xf32>) -> tensor<?x?xf32>
    flow.return %9 : tensor<?x?xf32>
  }
  %6 = hal.tensor.export %5 "output 0" : tensor<?x?xf32>{%0, %1} -> !hal.buffer_view
  return %6 : !hal.buffer_view
}

