
func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
  %0 = hal.buffer_view.dim<%arg0 : !hal.buffer_view>[0] : index
  %1 = hal.buffer_view.dim<%arg0 : !hal.buffer_view>[1] : index
  %2 = hal.tensor.import %arg0 "input 0" : !hal.buffer_view -> tensor<?x?xf32>{%0, %1}
  %3 = flow.dispatch @main_dispatch_0::@main_dispatch_0_matmul_DxDxD_f32[%0, %1](%2, %0, %1) : (tensor<?x?xf32>{%0, %1}, index, index) -> tensor<?x?xf32>{%0, %1}
  %4 = hal.tensor.export %3 "output 0" : tensor<?x?xf32>{%0, %1} -> !hal.buffer_view
  return %4 : !hal.buffer_view
}

