
func.func private @forward(%arg0: !torch.vtensor<[4],f32>) -> !torch.vtensor<[3],f32> attributes {torch.assume_strict_symbolic_shapes} {
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
  %6 = torch.aten.abs %3 : !torch.vtensor<[3],f32> -> !torch.vtensor<[3],f32>
  %7 = torch.aten.add.Tensor %5, %6, %int1 : !torch.vtensor<[3],f32>, !torch.vtensor<[3],f32>, !torch.int -> !torch.vtensor<[3],f32>
  return %7 : !torch.vtensor<[3],f32>
}

