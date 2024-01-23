
util.initializer {
  %cst = stream.tensor.constant : tensor<4x3xf32> in !stream.resource<constant> = dense<[[1.54099607, -0.293428898, -2.17878938], [0.568431258, -1.08452237, -1.39859545], [0.403346837, 0.838026344, -0.719257593], [-0.403343529, -0.596635341, 0.182036489]]> : tensor<4x3xf32>
  %0 = stream.resource.size %cst : !stream.resource<constant>
  util.global.store %cst, @_params.weight : !stream.resource<constant>
  util.global.store %0, @_params.weight__size : index
  util.initializer.return
}

