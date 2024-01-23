
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
  %c0_0 = arith.constant 0 : index
  %result, %result_timepoint = stream.resource.alloca uninitialized : !stream.resource<external>{%3} => !stream.timepoint
  %5 = stream.cmd.execute await(%result_timepoint) => with(%4 as %arg1: !stream.resource<external>{%3}, %result as %arg2: !stream.resource<external>{%3}) {
    stream.cmd.dispatch @main_dispatch_0::@main_dispatch_0_matmul_DxDxD_f32[%0, %1](%0, %1 : index, index) {
      ro %arg1[%c0 for %3] : !stream.resource<external>{%3},
      wo %arg2[%c0_0 for %3] : !stream.resource<external>{%3}
    }
  } => !stream.timepoint
  %6 = stream.timepoint.await %5 => %result : !stream.resource<external>{%3}
  %7 = stream.tensor.export %6 : tensor<?x?xf32>{%0, %1} in !stream.resource<external>{%3} -> !hal.buffer_view
  return %7 : !hal.buffer_view
}

