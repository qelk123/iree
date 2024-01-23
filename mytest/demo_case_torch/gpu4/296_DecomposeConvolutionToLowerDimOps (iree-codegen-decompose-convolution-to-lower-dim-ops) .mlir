
func.func @main_dispatch_0_matmul_1x3x4_f32() {
  %c0 = arith.constant 0 : index
  %c64 = arith.constant 64 : index
  %cst = arith.constant 0.000000e+00 : f32
  %0 = hal.interface.binding.subspan set(0) binding(0) type(storage_buffer) alignment(64) offset(%c0) flags(ReadOnly) : !flow.dispatch.tensor<readonly:tensor<1x4xf32>>
  %1 = hal.interface.binding.subspan set(0) binding(1) type(storage_buffer) alignment(64) offset(%c0) flags(ReadOnly) : !flow.dispatch.tensor<readonly:tensor<4x3xf32>>
  %2 = hal.interface.binding.subspan set(0) binding(1) type(storage_buffer) alignment(64) offset(%c64) flags(ReadOnly) : !flow.dispatch.tensor<readonly:tensor<1x3xf32>>
  %3 = hal.interface.binding.subspan set(0) binding(2) type(storage_buffer) alignment(64) offset(%c0) : !flow.dispatch.tensor<writeonly:tensor<1x3xf32>>
  %workgroup_id_x = hal.interface.workgroup.id[0] : index
  %4 = flow.dispatch.tensor.load %3, offsets = [0, %workgroup_id_x], sizes = [1, 1], strides = [1, 1] : !flow.dispatch.tensor<writeonly:tensor<1x3xf32>> -> tensor<1x1xf32>
  %5 = flow.dispatch.tensor.load %0, offsets = [0, 0], sizes = [1, 4], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<1x4xf32>> -> tensor<1x4xf32>
  %6 = flow.dispatch.tensor.load %1, offsets = [0, %workgroup_id_x], sizes = [4, 1], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<4x3xf32>> -> tensor<4x1xf32>
  %7 = tensor.empty() : tensor<1x1xf32>
  %8 = linalg.fill {__internal_linalg_transform__ = "workgroup_k_tiled", lowering_config = #iree_codegen.lowering_config<tile_sizes = [[0, 1, 4]]>} ins(%cst : f32) outs(%7 : tensor<1x1xf32>) -> tensor<1x1xf32>
  %9 = linalg.matmul {__internal_linalg_transform__ = "workgroup_k_tiled", lowering_config = #iree_codegen.lowering_config<tile_sizes = [[0, 1, 4]]>} ins(%5, %6 : tensor<1x4xf32>, tensor<4x1xf32>) outs(%8 : tensor<1x1xf32>) -> tensor<1x1xf32>
  %10 = flow.dispatch.tensor.load %2, offsets = [0, %workgroup_id_x], sizes = [1, 1], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<1x3xf32>> -> tensor<1x1xf32>
  %11 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%9, %10 : tensor<1x1xf32>, tensor<1x1xf32>) outs(%4 : tensor<1x1xf32>) attrs =  {__internal_linalg_transform__ = "workgroup_k_tiled", lowering_config = #iree_codegen.lowering_config<tile_sizes = [[0, 1, 4]]>} {
  ^bb0(%in: f32, %in_0: f32, %out: f32):
    %12 = math.absf %in : f32
    %13 = arith.addf %in, %in_0 : f32
    %14 = arith.addf %13, %12 : f32
    linalg.yield %14 : f32
  } -> tensor<1x1xf32>
  flow.dispatch.tensor.store %11, %3, offsets = [0, %workgroup_id_x], sizes = [1, 1], strides = [1, 1] : tensor<1x1xf32> -> !flow.dispatch.tensor<writeonly:tensor<1x3xf32>>
  return
}

