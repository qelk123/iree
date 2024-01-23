
func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
  %0 = hal.tensor.import %arg0 "input 0" : !hal.buffer_view -> tensor<4xf32>
  %1 = call @_main(%0) : (tensor<4xf32>) -> tensor<3xf32>
  %2 = hal.tensor.export %1 "output 0" : tensor<3xf32> -> !hal.buffer_view
  return %2 : !hal.buffer_view
}

