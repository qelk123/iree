
func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
  %c64 = arith.constant 64 : index
  %c128 = arith.constant 128 : index
  %c16 = arith.constant 16 : index
  %c12 = arith.constant 12 : index
  %c553648160_i32 = arith.constant 553648160 : i32
  %c1_i32 = arith.constant 1 : i32
  %c4 = arith.constant 4 : index
  %c0 = arith.constant 0 : index
  %c48 = arith.constant 48 : index
  %_params.weight__timepoint = util.global.load @_params.weight__timepoint : !stream.timepoint
  %_params.weight = util.global.load @_params.weight : !stream.resource<constant>
  %_params.weight_0 = util.global.load @_params.weight : !stream.resource<constant>
  hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input 0") shape([%c4]) type(%c553648160_i32) encoding(%c1_i32)
  %0 = stream.tensor.import %arg0 : !hal.buffer_view -> tensor<4xf32> in !stream.resource<external>{%c16}
  %result, %result_timepoint = stream.resource.alloca uninitialized await(%_params.weight__timepoint) => !stream.resource<external>{%c12} => !stream.timepoint
  %1 = stream.timepoint.join max(%_params.weight__timepoint, %result_timepoint) => !stream.timepoint
  %2 = stream.cmd.execute await(%1) => with(%0 as %arg1: !stream.resource<external>{%c16}, %_params.weight as %arg2: !stream.resource<constant>{%c128}, %_params.weight_0 as %arg3: !stream.resource<constant>{%c128}, %result as %arg4: !stream.resource<external>{%c12}) {
    stream.cmd.dispatch @main_dispatch_0::@main_dispatch_0_matmul_1x3x4_f32 {
      ro %arg1[%c0 for %c16] : !stream.resource<external>{%c16},
      ro %arg2[%c0 for %c48] : !stream.resource<constant>{%c128},
      ro %arg3[%c64 for %c12] : !stream.resource<constant>{%c128},
      wo %arg4[%c0 for %c12] : !stream.resource<external>{%c12}
    }
  } => !stream.timepoint
  %3 = stream.timepoint.await %2 => %result : !stream.resource<external>{%c12}
  %4 = stream.tensor.export %3 : tensor<3xf32> in !stream.resource<external>{%c12} -> !hal.buffer_view
  return %4 : !hal.buffer_view
}

