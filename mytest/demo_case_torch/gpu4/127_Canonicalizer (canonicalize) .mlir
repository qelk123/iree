
util.initializer {
  %cst = stream.tensor.constant : tensor<3xf32> in !stream.resource<constant> = dense<[-0.856674611, 1.10060418, -1.07118738]> : tensor<3xf32>
  %0 = stream.resource.size %cst : !stream.resource<constant>
  util.global.store %cst, @_params.bias : !stream.resource<constant>
  util.global.store %0, @_params.bias__size : index
  util.initializer.return
}

