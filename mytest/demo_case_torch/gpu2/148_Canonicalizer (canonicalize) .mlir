
func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
  %c4 = arith.constant 4 : index
  %c0 = arith.constant 0 : index
  %c1_i32 = arith.constant 1 : i32
  %c553648160_i32 = arith.constant 553648160 : i32
  %0 = hal.buffer_view.dim<%arg0 : !hal.buffer_view>[0] : index
  %1 = hal.buffer_view.dim<%arg0 : !hal.buffer_view>[1] : index
  hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input 0") shape([%0, %1]) type(%c553648160_i32) encoding(%c1_i32)
  %2 = arith.muli %0, %c4 : index
  %3 = arith.muli %2, %1 : index
  %4 = stream.tensor.import %arg0 : !hal.buffer_view -> tensor<?x?xf32>{%0, %1} in !stream.resource<external>{%3}
  %5 = stream.async.dispatch @main_dispatch_0::@main_dispatch_0_matmul_DxDxD_f32[%0, %1](%4[%c0 to %3 for %3], %0, %1) : (!stream.resource<external>{%3}, index, index) -> !stream.resource<external>{%3}
  %6 = stream.tensor.export %5 : tensor<?x?xf32>{%0, %1} in !stream.resource<external>{%3} -> !hal.buffer_view
  return %6 : !hal.buffer_view
}

