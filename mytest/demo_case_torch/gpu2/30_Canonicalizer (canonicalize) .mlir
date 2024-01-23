
func.func @main(%arg0: tensor<?x?xf32>) -> tensor<?x?xf32> attributes {torch.args_schema = "[1, {\22type\22: \22builtins.tuple\22, \22context\22: \22null\22, \22children_spec\22: [{\22type\22: \22builtins.list\22, \22context\22: \22null\22, \22children_spec\22: [{\22type\22: null, \22context\22: null, \22children_spec\22: []}]}, {\22type\22: \22builtins.dict\22, \22context\22: \22[]\22, \22children_spec\22: []}]}]", torch.assume_strict_symbolic_shapes, torch.return_schema = "[1, {\22type\22: null, \22context\22: null, \22children_spec\22: []}]"} {
  %0 = torch_c.from_builtin_tensor %arg0 : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
  %1 = torch_c.to_builtin_tensor %0 : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
  %2 = call @forward(%1) : (tensor<?x?xf32>) -> tensor<?x?xf32>
  %3 = torch_c.from_builtin_tensor %2 : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
  %4 = torch_c.to_builtin_tensor %3 : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
  return %4 : tensor<?x?xf32>
}

