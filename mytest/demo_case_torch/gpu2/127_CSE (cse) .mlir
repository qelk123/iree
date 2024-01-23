
func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
  %c0 = arith.constant 0 : index
  %c1_i32 = arith.constant 1 : i32
  %c553648160_i32 = arith.constant 553648160 : i32
  %0 = hal.buffer_view.dim<%arg0 : !hal.buffer_view>[0] : index
  %1 = hal.buffer_view.dim<%arg0 : !hal.buffer_view>[1] : index
  hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input 0") shape([%0, %1]) type(%c553648160_i32) encoding(%c1_i32)
  %2 = stream.tensor.sizeof tensor<?x?xf32>{%0, %1} : index
  %3 = stream.tensor.import %arg0 : !hal.buffer_view -> tensor<?x?xf32>{%0, %1} in !stream.resource<external>{%2}
  %4 = stream.async.transfer %3 : !stream.resource<external>{%2} -> !stream.resource<*>{%2}
  %5 = stream.async.dispatch @main_dispatch_0::@main_dispatch_0_matmul_DxDxD_f32[%0, %1](%4[%c0 to %2 for %2], %0, %1) : (!stream.resource<*>{%2}, index, index) -> !stream.resource<*>{%2}
  %6 = stream.async.transfer %5 : !stream.resource<*>{%2} -> !stream.resource<external>{%2}
  %7 = stream.tensor.export %6 : tensor<?x?xf32>{%0, %1} in !stream.resource<external>{%2} -> !hal.buffer_view
  return %7 : !hal.buffer_view
}

