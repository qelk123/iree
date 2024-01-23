
func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
  %0 = hal.buffer_view.dim<%arg0 : !hal.buffer_view>[0] : index
  %1 = hal.buffer_view.dim<%arg0 : !hal.buffer_view>[1] : index
  %2 = hal.tensor.import %arg0 "input 0" : !hal.buffer_view -> tensor<?x?xf32>{%0, %1}
  %3 = flow.dispatch.workgroups[%0, %1](%2, %0, %1) : (tensor<?x?xf32>{%0, %1}, index, index) -> tensor<?x?xf32>{%0, %1} =
      (%arg1: !flow.dispatch.tensor<readonly:tensor<?x?xf32>>, %arg2: index, %arg3: index, %arg4: !flow.dispatch.tensor<writeonly:tensor<?x?xf32>>) {
    %5 = flow.dispatch.workload.ordinal %arg2, 0 : index
    %6 = flow.dispatch.workload.ordinal %arg3, 1 : index
    %cst = arith.constant 0.000000e+00 : f32
    %7 = flow.dispatch.tensor.load %arg1, offsets = [0, 0], sizes = [%5, %6], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<?x?xf32>>{%5, %6} -> tensor<?x?xf32>
    %8 = tensor.empty(%5, %6) : tensor<?x?xf32>
    %9 = linalg.fill ins(%cst : f32) outs(%8 : tensor<?x?xf32>) -> tensor<?x?xf32>
    %10 = linalg.matmul ins(%7, %7 : tensor<?x?xf32>, tensor<?x?xf32>) outs(%9 : tensor<?x?xf32>) -> tensor<?x?xf32>
    flow.dispatch.tensor.store %10, %arg4, offsets = [0, 0], sizes = [%5, %6], strides = [1, 1] : tensor<?x?xf32> -> !flow.dispatch.tensor<writeonly:tensor<?x?xf32>>{%5, %6}
    flow.return
  } count(%arg1: index, %arg2: index) -> (index, index, index) {
    %x, %y, %z = flow.dispatch.workgroup_count_from_slice %arg1, %arg2
    flow.return %x, %y, %z : index, index, index
  }
  %4 = hal.tensor.export %3 "output 0" : tensor<?x?xf32>{%0, %1} -> !hal.buffer_view
  return %4 : !hal.buffer_view
}

