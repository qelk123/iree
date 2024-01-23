
flow.executable private @main_dispatch_0 {
  flow.executable.export public @main_dispatch_0_matmul_DxDxD_f32 workgroups(%arg0: index, %arg1: index) -> (index, index, index) {
    %x, %y, %z = flow.dispatch.workgroup_count_from_slice %arg0, %arg1
    flow.return %x, %y, %z : index, index, index
  }
  builtin.module {
    func.func @main_dispatch_0_matmul_DxDxD_f32(%arg0: !flow.dispatch.tensor<readonly:tensor<?x?xf32>>, %arg1: index, %arg2: index, %arg3: !flow.dispatch.tensor<writeonly:tensor<?x?xf32>>) {
      %cst = arith.constant 0.000000e+00 : f32
      %0 = flow.dispatch.workload.ordinal %arg1, 0 : index
      %1 = flow.dispatch.workload.ordinal %arg2, 1 : index
      %2 = flow.dispatch.tie_shape %arg0 : !flow.dispatch.tensor<readonly:tensor<?x?xf32>>{%0, %1}
      %3 = flow.dispatch.tie_shape %arg3 : !flow.dispatch.tensor<writeonly:tensor<?x?xf32>>{%0, %1}
      %4 = flow.dispatch.tensor.load %2, offsets = [0, 0], sizes = [%0, %1], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<?x?xf32>>{%0, %1} -> tensor<?x?xf32>
      %5 = tensor.empty(%0, %1) : tensor<?x?xf32>
      %6 = linalg.fill ins(%cst : f32) outs(%5 : tensor<?x?xf32>) -> tensor<?x?xf32>
      %7 = linalg.matmul ins(%4, %4 : tensor<?x?xf32>, tensor<?x?xf32>) outs(%6 : tensor<?x?xf32>) -> tensor<?x?xf32>
      flow.dispatch.tensor.store %7, %3, offsets = [0, 0], sizes = [%0, %1], strides = [1, 1] : tensor<?x?xf32> -> !flow.dispatch.tensor<writeonly:tensor<?x?xf32>>{%0, %1}
      return
    }
  }
}

