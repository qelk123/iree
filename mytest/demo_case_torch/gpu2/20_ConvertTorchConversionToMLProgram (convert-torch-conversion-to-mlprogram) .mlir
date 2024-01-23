
#executable_target_cuda_nvptx_fb = #hal.executable.target<"cuda", "cuda-nvptx-fb", {target_arch = "sm_75"}>
#device_target_cuda = #hal.device.target<"cuda", {executable_targets = [#executable_target_cuda_nvptx_fb], legacy_sync}>
module @LinearModule attributes {hal.device.targets = [#device_target_cuda]} {
  ml_program.global private mutable @global_seed(dense<0> : tensor<i64>) : tensor<i64>
  func.func @main(%arg0: tensor<?x?xf32>) -> tensor<?x?xf32> attributes {torch.args_schema = "[1, {\22type\22: \22builtins.tuple\22, \22context\22: \22null\22, \22children_spec\22: [{\22type\22: \22builtins.list\22, \22context\22: \22null\22, \22children_spec\22: [{\22type\22: null, \22context\22: null, \22children_spec\22: []}]}, {\22type\22: \22builtins.dict\22, \22context\22: \22[]\22, \22children_spec\22: []}]}]", torch.assume_strict_symbolic_shapes, torch.return_schema = "[1, {\22type\22: null, \22context\22: null, \22children_spec\22: []}]"} {
    %0 = torch_c.from_builtin_tensor %arg0 : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
    %1 = call @forward(%0) : (!torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32>
    %2 = torch_c.to_builtin_tensor %1 : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
    return %2 : tensor<?x?xf32>
  }
  func.func private @forward(%arg0: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> attributes {torch.assume_strict_symbolic_shapes} {
    %0 = torch_c.to_builtin_tensor %arg0 : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %0, %c0 : tensor<?x?xf32>
    %c1 = arith.constant 1 : index
    %dim_0 = tensor.dim %0, %c1 : tensor<?x?xf32>
    %1 = tensor.empty(%dim, %dim_0) : tensor<?x?xf32>
    %cst = arith.constant 0.000000e+00 : f32
    %2 = linalg.fill ins(%cst : f32) outs(%1 : tensor<?x?xf32>) -> tensor<?x?xf32>
    %3 = linalg.matmul ins(%0, %0 : tensor<?x?xf32>, tensor<?x?xf32>) outs(%2 : tensor<?x?xf32>) -> tensor<?x?xf32>
    %4 = torch_c.from_builtin_tensor %3 : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
    return %4 : !torch.vtensor<[?,?],f32>
  }
}


