
func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
  %c1 = arith.constant 1 : index
  %c0 = arith.constant 0 : index
  %0 = hal.buffer_view.dim<%arg0 : !hal.buffer_view>[0] : index
  %1 = hal.buffer_view.dim<%arg0 : !hal.buffer_view>[1] : index
  %2 = hal.tensor.import %arg0 "input 0" : !hal.buffer_view -> tensor<?x?xf32>{%0, %1}
  %3 = call @_main(%2) : (tensor<?x?xf32>) -> tensor<?x?xf32>
  %dim = tensor.dim %3, %c0 : tensor<?x?xf32>
  %dim_0 = tensor.dim %3, %c1 : tensor<?x?xf32>
  %4 = hal.tensor.export %3 "output 0" : tensor<?x?xf32>{%dim, %dim_0} -> !hal.buffer_view
  return %4 : !hal.buffer_view
}

