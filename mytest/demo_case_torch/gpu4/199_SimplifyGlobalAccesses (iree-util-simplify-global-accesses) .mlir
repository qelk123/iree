
util.initializer {
  %0 = stream.timepoint.immediate => !stream.timepoint
  %c64 = arith.constant 64 : index
  %c0_i64 = arith.constant 0 : i64
  %c128 = arith.constant 128 : index
  %c0 = arith.constant 0 : index
  %c48 = arith.constant 48 : index
  %c12 = arith.constant 12 : index
  %buffer_cst = util.buffer.constant {alignment = 64 : index} : !util.buffer = #util.composite<128xi8, [
    dense<[[1.54099607, -0.293428898, -2.17878938], [0.568431258, -1.08452237, -1.39859545], [0.403346837, 0.838026344, -0.719257593], [-0.403343529, -0.596635341, 0.182036489]]> : tensor<4x3xf32>,
    dense<0> : vector<16xi8>,
    dense<[-0.856674611, 1.10060418, -1.07118738]> : tensor<3xf32>,
    dense<0> : vector<52xi8>,
]>
  %did_map, %result = stream.resource.try_map %buffer_cst[%c0] : !util.buffer -> i1, !stream.resource<constant>{%c128}
  %1:2 = scf.if %did_map -> (!stream.timepoint, !stream.resource<constant>) {
    scf.yield %0, %result : !stream.timepoint, !stream.resource<constant>
  } else {
    %2 = stream.resource.alloc uninitialized : !stream.resource<constant>{%c128}
    %file = stream.file.constant %buffer_cst[%c0 for %c128] : !util.buffer{%c128} -> !stream.file
    %3 = stream.file.read await(%0) => %file[%c0_i64], %2[%c0], %c128 : !stream.file -> !stream.resource<constant>{%c128} => !stream.timepoint
    scf.yield %3, %2 : !stream.timepoint, !stream.resource<constant>
  }
  util.global.store %1#1, @_params.bias : !stream.resource<constant>
  util.global.store %c12, @_params.bias__length : index
  util.global.store %c64, @_params.bias__offset : index
  util.global.store %c128, @_params.bias__storage_size : index
  util.global.store %1#1, @_params.weight : !stream.resource<constant>
  util.global.store %c48, @_params.weight__length : index
  util.global.store %c0, @_params.weight__offset : index
  util.global.store %c128, @_params.weight__storage_size : index
  util.global.store %1#0, @_params.weight__timepoint : !stream.timepoint
  util.initializer.return
}

