
func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
  %c16 = arith.constant 16 : index
  %c12 = arith.constant 12 : index
  %c553648160_i32 = arith.constant 553648160 : i32
  %c1_i32 = arith.constant 1 : i32
  %c4 = arith.constant 4 : index
  %c0 = arith.constant 0 : index
  %c48 = arith.constant 48 : index
  %_params.weight__timepoint = util.global.load @_params.weight__timepoint : !stream.timepoint
  %_params.weight = util.global.load @_params.weight : !stream.resource<constant>
  %_params.bias__timepoint = util.global.load @_params.bias__timepoint : !stream.timepoint
  %_params.bias = util.global.load @_params.bias : !stream.resource<constant>
  hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input 0") shape([%c4]) type(%c553648160_i32) encoding(%c1_i32)
  %0 = stream.tensor.import %arg0 : !hal.buffer_view -> tensor<4xf32> in !stream.resource<external>{%c16}
  %1 = stream.timepoint.join max(%_params.weight__timepoint, %_params.bias__timepoint) => !stream.timepoint
  %results, %result_timepoint = stream.async.execute await(%1) => with(%0 as %arg1: !stream.resource<external>{%c16}, %_params.weight as %arg2: !stream.resource<constant>{%c48}, %_params.bias as %arg3: !stream.resource<constant>{%c12}) -> !stream.resource<external>{%c12} {
    %4 = stream.async.dispatch @main_dispatch_0::@main_dispatch_0_matmul_1x3x4_f32(%arg1[%c0 to %c16 for %c16], %arg2[%c0 to %c48 for %c48], %arg3[%c0 to %c12 for %c12]) : (!stream.resource<external>{%c16}, !stream.resource<constant>{%c48}, !stream.resource<constant>{%c12}) -> !stream.resource<external>{%c12}
    stream.yield %4 : !stream.resource<external>{%c12}
  } => !stream.timepoint
  %2 = stream.timepoint.await %result_timepoint => %results : !stream.resource<external>{%c12}
  %3 = stream.tensor.export %2 : tensor<3xf32> in !stream.resource<external>{%c12} -> !hal.buffer_view
  return %3 : !hal.buffer_view
}

