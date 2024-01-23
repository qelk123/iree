
flow.executable private @main_dispatch_0 {
  flow.executable.export public @main_dispatch_0_matmul_1x3x4_f32 workgroups() -> (index, index, index) {
    %x, %y, %z = flow.dispatch.workgroup_count_from_slice 
    flow.return %x, %y, %z : index, index, index
  }
  builtin.module {
    func.func @main_dispatch_0_matmul_1x3x4_f32(%arg0: !flow.dispatch.tensor<readonly:tensor<1x4xf32>>, %arg1: !flow.dispatch.tensor<readonly:tensor<4x3xf32>>, %arg2: !flow.dispatch.tensor<readonly:tensor<1x3xf32>>, %arg3: !flow.dispatch.tensor<writeonly:tensor<1x3xf32>>) {
      %cst = arith.constant 0.000000e+00 : f32
      %0 = flow.dispatch.tensor.load %arg0, offsets = [0, 0], sizes = [1, 4], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<1x4xf32>> -> tensor<1x4xf32>
      %1 = flow.dispatch.tensor.load %arg1, offsets = [0, 0], sizes = [4, 3], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<4x3xf32>> -> tensor<4x3xf32>
      %2 = flow.dispatch.tensor.load %arg2, offsets = [0, 0], sizes = [1, 3], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<1x3xf32>> -> tensor<1x3xf32>
      %3 = tensor.empty() : tensor<1x3xf32>
      %4 = linalg.fill ins(%cst : f32) outs(%3 : tensor<1x3xf32>) -> tensor<1x3xf32>
      %5 = linalg.matmul ins(%0, %1 : tensor<1x4xf32>, tensor<4x3xf32>) outs(%4 : tensor<1x3xf32>) -> tensor<1x3xf32>
      %6 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%5, %2 : tensor<1x3xf32>, tensor<1x3xf32>) outs(%3 : tensor<1x3xf32>) {
      ^bb0(%in: f32, %in_0: f32, %out: f32):
        %7 = math.absf %in : f32
        %8 = arith.addf %in, %in_0 : f32
        %9 = arith.addf %8, %7 : f32
        linalg.yield %9 : f32
      } -> tensor<1x3xf32>
      flow.dispatch.tensor.store %6, %arg3, offsets = [0, 0], sizes = [1, 3], strides = [1, 1] : tensor<1x3xf32> -> !flow.dispatch.tensor<writeonly:tensor<1x3xf32>>
      return
    }
  }
}

