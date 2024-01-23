
#executable_target_cuda_nvptx_fb = #hal.executable.target<"cuda", "cuda-nvptx-fb", {target_arch = "sm_75"}>
#device_target_cuda = #hal.device.target<"cuda", {executable_targets = [#executable_target_cuda_nvptx_fb], legacy_sync}>
module @LinearModule attributes {hal.device.targets = [#device_target_cuda]} {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @main(%arg0: tensor<?x?xf32>) -> tensor<?x?xf32> attributes {torch.args_schema = "[1, {\22type\22: \22builtins.tuple\22, \22context\22: \22null\22, \22children_spec\22: [{\22type\22: \22builtins.list\22, \22context\22: \22null\22, \22children_spec\22: [{\22type\22: null, \22context\22: null, \22children_spec\22: []}]}, {\22type\22: \22builtins.dict\22, \22context\22: \22[]\22, \22children_spec\22: []}]}]", torch.assume_strict_symbolic_shapes, torch.return_schema = "[1, {\22type\22: null, \22context\22: null, \22children_spec\22: []}]"} {
    %0 = torch_c.from_builtin_tensor %arg0 : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
    %1 = torch_c.to_builtin_tensor %0 : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
    %2 = call @forward(%1) : (tensor<?x?xf32>) -> tensor<?x?xf32>
    %3 = torch_c.from_builtin_tensor %2 : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
    %4 = torch_c.to_builtin_tensor %3 : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
    return %4 : tensor<?x?xf32>
  }
  func.func private @forward(%arg0: tensor<?x?xf32>) -> tensor<?x?xf32> attributes {torch.assume_strict_symbolic_shapes} {
    %0 = torch_c.from_builtin_tensor %arg0 : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
    %cst = arith.constant 0.000000e+00 : f32
    %c1 = arith.constant 1 : index
    %c0 = arith.constant 0 : index
    %1 = torch_c.to_builtin_tensor %0 : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
    %dim = tensor.dim %1, %c0 : tensor<?x?xf32>
    %dim_0 = tensor.dim %1, %c1 : tensor<?x?xf32>
    %2 = tensor.empty(%dim, %dim_0) : tensor<?x?xf32>
    %3 = linalg.fill ins(%cst : f32) outs(%2 : tensor<?x?xf32>) -> tensor<?x?xf32>
    %4 = linalg.matmul ins(%1, %1 : tensor<?x?xf32>, tensor<?x?xf32>) outs(%3 : tensor<?x?xf32>) -> tensor<?x?xf32>
    %5 = torch_c.from_builtin_tensor %4 : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
    %6 = torch_c.to_builtin_tensor %5 : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
    return %6 : tensor<?x?xf32>
  }
}


