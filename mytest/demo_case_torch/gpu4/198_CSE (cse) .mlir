
func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
  %c48 = arith.constant 48 : index
  %c0 = arith.constant 0 : index
  %c4 = arith.constant 4 : index
  %c1_i32 = arith.constant 1 : i32
  %c553648160_i32 = arith.constant 553648160 : i32
  %c12 = arith.constant 12 : index
  %c16 = arith.constant 16 : index
  %_params.weight__timepoint = util.global.load @_params.weight__timepoint : !stream.timepoint
  %_params.weight = util.global.load @_params.weight : !stream.resource<constant>
  %_params.weight__storage_size = util.global.load @_params.weight__storage_size : index
  %_params.weight__offset = util.global.load @_params.weight__offset : index
  %_params.bias = util.global.load @_params.bias : !stream.resource<constant>
  %_params.bias__storage_size = util.global.load @_params.bias__storage_size : index
  %_params.bias__offset = util.global.load @_params.bias__offset : index
  hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input 0") shape([%c4]) type(%c553648160_i32) encoding(%c1_i32)
  %0 = stream.tensor.import %arg0 : !hal.buffer_view -> tensor<4xf32> in !stream.resource<external>{%c16}
  %1 = stream.timepoint.join max(%_params.weight__timepoint, %_params.weight__timepoint) => !stream.timepoint
  %result, %result_timepoint = stream.resource.alloca uninitialized await(%1) => !stream.resource<external>{%c12} => !stream.timepoint
  %2 = stream.timepoint.join max(%_params.weight__timepoint, %_params.weight__timepoint, %result_timepoint) => !stream.timepoint
  %3 = stream.cmd.execute await(%2) => with(%0 as %arg1: !stream.resource<external>{%c16}, %_params.weight as %arg2: !stream.resource<constant>{%_params.weight__storage_size}, %_params.bias as %arg3: !stream.resource<constant>{%_params.bias__storage_size}, %result as %arg4: !stream.resource<external>{%c12}) {
    stream.cmd.dispatch @main_dispatch_0::@main_dispatch_0_matmul_1x3x4_f32 {
      ro %arg1[%c0 for %c16] : !stream.resource<external>{%c16},
      ro %arg2[%_params.weight__offset for %c48] : !stream.resource<constant>{%_params.weight__storage_size},
      ro %arg3[%_params.bias__offset for %c12] : !stream.resource<constant>{%_params.bias__storage_size},
      wo %arg4[%c0 for %c12] : !stream.resource<external>{%c12}
    }
  } => !stream.timepoint
  %4 = stream.timepoint.await %3 => %result : !stream.resource<external>{%c12}
  %5 = stream.tensor.export %4 : tensor<3xf32> in !stream.resource<external>{%c12} -> !hal.buffer_view
  return %5 : !hal.buffer_view
}

