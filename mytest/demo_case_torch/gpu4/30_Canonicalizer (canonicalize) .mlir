
func.func @main(%arg0: tensor<4xf32>) -> tensor<3xf32> attributes {torch.args_schema = "[1, {\22type\22: \22builtins.tuple\22, \22context\22: \22null\22, \22children_spec\22: [{\22type\22: \22builtins.list\22, \22context\22: \22null\22, \22children_spec\22: [{\22type\22: null, \22context\22: null, \22children_spec\22: []}]}, {\22type\22: \22builtins.dict\22, \22context\22: \22[]\22, \22children_spec\22: []}]}]", torch.assume_strict_symbolic_shapes, torch.return_schema = "[1, {\22type\22: null, \22context\22: null, \22children_spec\22: []}]"} {
  %0 = torch_c.from_builtin_tensor %arg0 : tensor<4xf32> -> !torch.vtensor<[4],f32>
  %1 = torch_c.to_builtin_tensor %0 : !torch.vtensor<[4],f32> -> tensor<4xf32>
  %2 = call @forward(%1) : (tensor<4xf32>) -> tensor<3xf32>
  %3 = torch_c.from_builtin_tensor %2 : tensor<3xf32> -> !torch.vtensor<[3],f32>
  %4 = torch_c.to_builtin_tensor %3 : !torch.vtensor<[3],f32> -> tensor<3xf32>
  return %4 : tensor<3xf32>
}

