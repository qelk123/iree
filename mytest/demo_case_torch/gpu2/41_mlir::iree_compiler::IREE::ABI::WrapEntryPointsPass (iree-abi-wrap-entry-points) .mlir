
#executable_target_cuda_nvptx_fb = #hal.executable.target<"cuda", "cuda-nvptx-fb", {target_arch = "sm_75"}>
#device_target_cuda = #hal.device.target<"cuda", {executable_targets = [#executable_target_cuda_nvptx_fb], legacy_sync}>
module @LinearModule attributes {hal.device.targets = [#device_target_cuda]} {
  func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
    %0 = hal.buffer_view.dim<%arg0 : !hal.buffer_view>[0] : index
    %1 = hal.buffer_view.dim<%arg0 : !hal.buffer_view>[1] : index
    %2 = hal.tensor.import %arg0 "input 0" : !hal.buffer_view -> tensor<?x?xf32>{%0, %1}
    %3 = call @_main(%2) : (tensor<?x?xf32>) -> tensor<?x?xf32>
    %c0 = arith.constant 0 : index
    %dim = tensor.dim %3, %c0 : tensor<?x?xf32>
    %c1 = arith.constant 1 : index
    %dim_0 = tensor.dim %3, %c1 : tensor<?x?xf32>
    %4 = hal.tensor.export %3 "output 0" : tensor<?x?xf32>{%dim, %dim_0} -> !hal.buffer_view
    return %4 : !hal.buffer_view
  }
  func.func private @_main(%arg0: tensor<?x?xf32>) -> tensor<?x?xf32> attributes {torch.args_schema = "[1, {\22type\22: \22builtins.tuple\22, \22context\22: \22null\22, \22children_spec\22: [{\22type\22: \22builtins.list\22, \22context\22: \22null\22, \22children_spec\22: [{\22type\22: null, \22context\22: null, \22children_spec\22: []}]}, {\22type\22: \22builtins.dict\22, \22context\22: \22[]\22, \22children_spec\22: []}]}]", torch.assume_strict_symbolic_shapes, torch.return_schema = "[1, {\22type\22: null, \22context\22: null, \22children_spec\22: []}]"} {
    %0 = call @forward(%arg0) : (tensor<?x?xf32>) -> tensor<?x?xf32>
    return %0 : tensor<?x?xf32>
  }
  func.func private @forward(%arg0: tensor<?x?xf32>) -> tensor<?x?xf32> attributes {torch.assume_strict_symbolic_shapes} {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f32
    %dim = tensor.dim %arg0, %c0 : tensor<?x?xf32>
    %dim_0 = tensor.dim %arg0, %c1 : tensor<?x?xf32>
    %0 = tensor.empty(%dim, %dim_0) : tensor<?x?xf32>
    %1 = linalg.fill ins(%cst : f32) outs(%0 : tensor<?x?xf32>) -> tensor<?x?xf32>
    %2 = linalg.matmul ins(%arg0, %arg0 : tensor<?x?xf32>, tensor<?x?xf32>) outs(%1 : tensor<?x?xf32>) -> tensor<?x?xf32>
    return %2 : tensor<?x?xf32>
  }
}


