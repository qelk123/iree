
func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
  %c48 = arith.constant 48 : index
  %c0 = arith.constant 0 : index
  %c4 = arith.constant 4 : index
  %c1_i32 = arith.constant 1 : i32
  %c553648160_i32 = arith.constant 553648160 : i32
  %c12 = arith.constant 12 : index
  %c16 = arith.constant 16 : index
  %_params.weight = util.global.load @_params.weight : !stream.resource<constant>
  %_params.bias = util.global.load @_params.bias : !stream.resource<constant>
  %0 = stream.async.transfer %_params.weight : !stream.resource<constant>{%c48} -> !stream.resource<*>{%c48}
  %1 = stream.async.transfer %_params.bias : !stream.resource<constant>{%c12} -> !stream.resource<*>{%c12}
  hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input 0") shape([%c4]) type(%c553648160_i32) encoding(%c1_i32)
  %2 = stream.tensor.import %arg0 : !hal.buffer_view -> tensor<4xf32> in !stream.resource<external>{%c16}
  %3 = stream.async.transfer %2 : !stream.resource<external>{%c16} -> !stream.resource<*>{%c16}
  %4 = stream.async.dispatch @main_dispatch_0::@main_dispatch_0_matmul_1x3x4_f32(%3[%c0 to %c16 for %c16], %0[%c0 to %c48 for %c48], %1[%c0 to %c12 for %c12]) : (!stream.resource<*>{%c16}, !stream.resource<*>{%c48}, !stream.resource<*>{%c12}) -> !stream.resource<*>{%c12}
  %5 = stream.async.transfer %4 : !stream.resource<*>{%c12} -> !stream.resource<external>{%c12}
  %6 = stream.tensor.export %5 : tensor<3xf32> in !stream.resource<external>{%c12} -> !hal.buffer_view
  return %6 : !hal.buffer_view
}

