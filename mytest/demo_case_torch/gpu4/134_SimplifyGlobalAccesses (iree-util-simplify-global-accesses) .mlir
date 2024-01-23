
func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
  %_params.weight = util.global.load @_params.weight : !stream.resource<constant>
  %_params.weight__size = util.global.load @_params.weight__size : index
  %_params.bias = util.global.load @_params.bias : !stream.resource<constant>
  %_params.bias__size = util.global.load @_params.bias__size : index
  %c0 = arith.constant 0 : index
  %c4 = arith.constant 4 : index
  %c1_i32 = arith.constant 1 : i32
  %c553648160_i32 = arith.constant 553648160 : i32
  %0 = stream.async.transfer %_params.weight : !stream.resource<constant>{%_params.weight__size} -> !stream.resource<*>{%_params.weight__size}
  %1 = stream.async.transfer %_params.bias : !stream.resource<constant>{%_params.bias__size} -> !stream.resource<*>{%_params.bias__size}
  hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input 0") shape([%c4]) type(%c553648160_i32) encoding(%c1_i32)
  %2 = stream.tensor.sizeof tensor<4xf32> : index
  %3 = stream.tensor.import %arg0 : !hal.buffer_view -> tensor<4xf32> in !stream.resource<external>{%2}
  %4 = stream.async.transfer %3 : !stream.resource<external>{%2} -> !stream.resource<*>{%2}
  %5 = stream.tensor.sizeof tensor<1x4xf32> : index
  %6 = stream.tensor.sizeof tensor<1x3xf32> : index
  %7 = stream.async.dispatch @main_dispatch_0::@main_dispatch_0_matmul_1x3x4_f32(%4[%c0 to %5 for %5], %0[%c0 to %_params.weight__size for %_params.weight__size], %1[%c0 to %6 for %6]) : (!stream.resource<*>{%5}, !stream.resource<*>{%_params.weight__size}, !stream.resource<*>{%6}) -> !stream.resource<*>{%6}
  %8 = stream.tensor.sizeof tensor<3xf32> : index
  %9 = stream.async.transfer %7 : !stream.resource<*>{%8} -> !stream.resource<external>{%8}
  %10 = stream.tensor.export %9 : tensor<3xf32> in !stream.resource<external>{%8} -> !hal.buffer_view
  return %10 : !hal.buffer_view
}

