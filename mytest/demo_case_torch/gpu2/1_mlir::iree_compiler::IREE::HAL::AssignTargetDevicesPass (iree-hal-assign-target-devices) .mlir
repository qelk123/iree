
#executable_target_cuda_nvptx_fb = #hal.executable.target<"cuda", "cuda-nvptx-fb", {target_arch = "sm_75"}>
#device_target_cuda = #hal.device.target<"cuda", {executable_targets = [#executable_target_cuda_nvptx_fb], legacy_sync}>
module @LinearModule attributes {hal.device.targets = [#device_target_cuda]} {
  func.func @main(%arg0: tensor<?x?xf32>) -> tensor<?x?xf32> attributes {torch.args_schema = "[1, {\22type\22: \22builtins.tuple\22, \22context\22: \22null\22, \22children_spec\22: [{\22type\22: \22builtins.list\22, \22context\22: \22null\22, \22children_spec\22: [{\22type\22: null, \22context\22: null, \22children_spec\22: []}]}, {\22type\22: \22builtins.dict\22, \22context\22: \22[]\22, \22children_spec\22: []}]}]", torch.return_schema = "[1, {\22type\22: null, \22context\22: null, \22children_spec\22: []}]"} {
    %0 = torch_c.from_builtin_tensor %arg0 : tensor<?x?xf32> -> !torch.vtensor<[?,?],f32>
    %1 = call @forward(%0) : (!torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32>
    %2 = torch_c.to_builtin_tensor %1 : !torch.vtensor<[?,?],f32> -> tensor<?x?xf32>
    return %2 : tensor<?x?xf32>
  }
  func.func private @forward(%arg0: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> {
    %0 = torch.aten.mm %arg0, %arg0 : !torch.vtensor<[?,?],f32>, !torch.vtensor<[?,?],f32> -> !torch.vtensor<[?,?],f32>
    return %0 : !torch.vtensor<[?,?],f32>
  }
}


