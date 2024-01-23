
util.initializer {
  %c48 = arith.constant 48 : index
  %c12 = arith.constant 12 : index
  %results:2, %result_timepoint = stream.async.execute with() -> (!stream.resource<constant>{%c48}, !stream.resource<constant>{%c12}) {
    %cst = stream.async.constant : !stream.resource<constant>{%c48} = dense<[[1.54099607, -0.293428898, -2.17878938], [0.568431258, -1.08452237, -1.39859545], [0.403346837, 0.838026344, -0.719257593], [-0.403343529, -0.596635341, 0.182036489]]> : tensor<4x3xf32>
    %cst_0 = stream.async.constant : !stream.resource<constant>{%c12} = dense<[-0.856674611, 1.10060418, -1.07118738]> : tensor<3xf32>
    stream.yield %cst, %cst_0 : !stream.resource<constant>{%c48}, !stream.resource<constant>{%c12}
  } => !stream.timepoint
  util.global.store %results#1, @_params.bias : !stream.resource<constant>
  util.global.store %result_timepoint, @_params.bias__timepoint : !stream.timepoint
  util.global.store %results#0, @_params.weight : !stream.resource<constant>
  util.global.store %result_timepoint, @_params.weight__timepoint : !stream.timepoint
  util.initializer.return
}

