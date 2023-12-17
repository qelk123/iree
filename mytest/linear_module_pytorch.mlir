module @LinearModule {
  util.global private @_params.weight {noinline} = dense<[[1.54099607, -0.293428898, -2.17878938], [0.568431258, -1.08452237, -1.39859545], [0.403346837, 0.838026344, -0.719257593], [-0.403343529, -0.596635341, 0.182036489]]> : tensor<4x3xf32>
  util.global private @_params.bias {noinline} = dense<[-0.856674611, 1.10060418, -1.07118738]> : tensor<3xf32>
  func.func @main(%arg0: tensor<4xf32>) -> tensor<3xf32> attributes {torch.args_schema = "[1, {\22type\22: \22builtins.tuple\22, \22context\22: \22null\22, \22children_spec\22: [{\22type\22: \22builtins.list\22, \22context\22: \22null\22, \22children_spec\22: [{\22type\22: null, \22context\22: null, \22children_spec\22: []}]}, {\22type\22: \22builtins.dict\22, \22context\22: \22[]\22, \22children_spec\22: []}]}]", torch.return_schema = "[1, {\22type\22: null, \22context\22: null, \22children_spec\22: []}]"} {
    %0 = torch_c.from_builtin_tensor %arg0 : tensor<4xf32> -> !torch.vtensor<[4],f32>
    %1 = call @forward(%0) : (!torch.vtensor<[4],f32>) -> !torch.vtensor<[3],f32>
    %2 = torch_c.to_builtin_tensor %1 : !torch.vtensor<[3],f32> -> tensor<3xf32>
    return %2 : tensor<3xf32>
  }
  func.func private @forward(%arg0: !torch.vtensor<[4],f32>) -> !torch.vtensor<[3],f32> {
    %int0 = torch.constant.int 0
    %0 = torch.aten.unsqueeze %arg0, %int0 : !torch.vtensor<[4],f32>, !torch.int -> !torch.vtensor<[1,4],f32>
    %_params.weight = util.global.load @_params.weight : tensor<4x3xf32>
    %1 = torch_c.from_builtin_tensor %_params.weight : tensor<4x3xf32> -> !torch.vtensor<[4,3],f32>
    %2 = torch.aten.mm %0, %1 : !torch.vtensor<[1,4],f32>, !torch.vtensor<[4,3],f32> -> !torch.vtensor<[1,3],f32>
    %int0_0 = torch.constant.int 0
    %3 = torch.aten.squeeze.dim %2, %int0_0 : !torch.vtensor<[1,3],f32>, !torch.int -> !torch.vtensor<[3],f32>
    %_params.bias = util.global.load @_params.bias : tensor<3xf32>
    %4 = torch_c.from_builtin_tensor %_params.bias : tensor<3xf32> -> !torch.vtensor<[3],f32>
    %int1 = torch.constant.int 1
    %5 = torch.aten.add.Tensor %3, %4, %int1 : !torch.vtensor<[3],f32>, !torch.vtensor<[3],f32>, !torch.int -> !torch.vtensor<[3],f32>
    return %5 : !torch.vtensor<[3],f32>
  }
}
