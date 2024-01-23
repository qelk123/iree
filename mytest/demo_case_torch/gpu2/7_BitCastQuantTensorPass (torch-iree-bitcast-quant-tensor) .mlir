
func.func private @forward(%arg0: !torch.vtensor<[?,?],f32>) -> !torch.vtensor<[?,?],f32> attributes {torch.assume_strict_symbolic_shapes} {
  %0 = torch.aten.mm %arg0, %arg0 : !torch.vtensor<[?,?],f32>, !torch.vtensor<[?,?],f32> -> !torch.vtensor<[?,?],f32>
  return %0 : !torch.vtensor<[?,?],f32>
}

