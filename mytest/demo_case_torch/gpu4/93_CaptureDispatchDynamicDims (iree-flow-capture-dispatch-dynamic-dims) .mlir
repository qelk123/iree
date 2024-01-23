
func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
  %_params.weight = util.global.load @_params.weight : tensor<4x3xf32>
  %_params.bias = util.global.load @_params.bias : tensor<3xf32>
  %0 = hal.tensor.import %arg0 "input 0" : !hal.buffer_view -> tensor<4xf32>
  %1 = flow.tensor.reshape %0 : tensor<4xf32> -> tensor<1x4xf32>
  %2 = flow.tensor.reshape %_params.bias : tensor<3xf32> -> tensor<1x3xf32>
  %3 = flow.dispatch.workgroups(%1, %_params.weight, %2) : (tensor<1x4xf32>, tensor<4x3xf32>, tensor<1x3xf32>) -> tensor<1x3xf32> =
      (%arg1: !flow.dispatch.tensor<readonly:tensor<1x4xf32>>, %arg2: !flow.dispatch.tensor<readonly:tensor<4x3xf32>>, %arg3: !flow.dispatch.tensor<readonly:tensor<1x3xf32>>, %arg4: !flow.dispatch.tensor<writeonly:tensor<1x3xf32>>) {
    %cst = arith.constant 0.000000e+00 : f32
    %6 = flow.dispatch.tensor.load %arg1, offsets = [0, 0], sizes = [1, 4], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<1x4xf32>> -> tensor<1x4xf32>
    %7 = flow.dispatch.tensor.load %arg2, offsets = [0, 0], sizes = [4, 3], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<4x3xf32>> -> tensor<4x3xf32>
    %8 = flow.dispatch.tensor.load %arg3, offsets = [0, 0], sizes = [1, 3], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<1x3xf32>> -> tensor<1x3xf32>
    %9 = tensor.empty() : tensor<1x3xf32>
    %10 = linalg.fill ins(%cst : f32) outs(%9 : tensor<1x3xf32>) -> tensor<1x3xf32>
    %11 = linalg.matmul ins(%6, %7 : tensor<1x4xf32>, tensor<4x3xf32>) outs(%10 : tensor<1x3xf32>) -> tensor<1x3xf32>
    %12 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%11, %8 : tensor<1x3xf32>, tensor<1x3xf32>) outs(%9 : tensor<1x3xf32>) {
    ^bb0(%in: f32, %in_0: f32, %out: f32):
      %13 = math.absf %in : f32
      %14 = arith.addf %in, %in_0 : f32
      %15 = arith.addf %14, %13 : f32
      linalg.yield %15 : f32
    } -> tensor<1x3xf32>
    flow.dispatch.tensor.store %12, %arg4, offsets = [0, 0], sizes = [1, 3], strides = [1, 1] : tensor<1x3xf32> -> !flow.dispatch.tensor<writeonly:tensor<1x3xf32>>
    flow.return
  } count() -> (index, index, index) {
    %x, %y, %z = flow.dispatch.workgroup_count_from_slice 
    flow.return %x, %y, %z : index, index, index
  }
  %4 = flow.tensor.reshape %3 : tensor<1x3xf32> -> tensor<3xf32>
  %5 = hal.tensor.export %4 "output 0" : tensor<3xf32> -> !hal.buffer_view
  return %5 : !hal.buffer_view
}

