
func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
  %_params.weight = util.global.load @_params.weight : tensor<4x3xf32>
  %_params.bias = util.global.load @_params.bias : tensor<3xf32>
  %0 = hal.tensor.import %arg0 "input 0" : !hal.buffer_view -> tensor<4xf32>
  %1 = flow.tensor.reshape %0 : tensor<4xf32> -> tensor<1x4xf32>
  %2 = flow.tensor.reshape %_params.bias : tensor<3xf32> -> tensor<1x3xf32>
  %3 = flow.dispatch @main_dispatch_0::@main_dispatch_0_matmul_1x3x4_f32(%1, %_params.weight, %2) : (tensor<1x4xf32>, tensor<4x3xf32>, tensor<1x3xf32>) -> tensor<1x3xf32>
  %4 = flow.tensor.reshape %3 : tensor<1x3xf32> -> tensor<3xf32>
  %5 = hal.tensor.export %4 "output 0" : tensor<3xf32> -> !hal.buffer_view
  return %5 : !hal.buffer_view
}

