
func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
  %c32_i64 = arith.constant 32 : i64
  %c0_i32 = arith.constant 0 : i32
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
  %result, %result_timepoint = stream.resource.alloca uninitialized : !stream.resource<external>{%3} => !stream.timepoint
  %5 = arith.index_castui %0 : index to i64
  %6 = arith.trunci %5 : i64 to i32
  %7 = arith.shrui %5, %c32_i64 : i64
  %8 = arith.trunci %7 : i64 to i32
  %9 = arith.index_castui %1 : index to i64
  %10 = arith.trunci %9 : i64 to i32
  %11 = arith.shrui %9, %c32_i64 : i64
  %12 = arith.trunci %11 : i64 to i32
  %13 = stream.cmd.execute await(%result_timepoint) => with(%4 as %arg1: !stream.resource<external>{%3}, %result as %arg2: !stream.resource<external>{%3}) {
    stream.cmd.dispatch @main_dispatch_0::@main_dispatch_0_matmul_DxDxD_f32[%0, %1](%c0_i32, %c0_i32, %c0_i32, %c0_i32, %6, %8, %10, %12 : i32, i32, i32, i32, i32, i32, i32, i32) {
      ro %arg1[%c0 for %3] : !stream.resource<external>{%3},
      wo %arg2[%c0 for %3] : !stream.resource<external>{%3}
    }
  } => !stream.timepoint
  %14 = stream.timepoint.await %13 => %result : !stream.resource<external>{%3}
  %15 = stream.tensor.export %14 : tensor<?x?xf32>{%0, %1} in !stream.resource<external>{%3} -> !hal.buffer_view
  return %15 : !hal.buffer_view
}

