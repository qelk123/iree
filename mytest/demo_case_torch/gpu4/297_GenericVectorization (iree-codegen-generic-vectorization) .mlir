
func.func @main_dispatch_0_matmul_1x3x4_f32() {
  %cst = arith.constant dense<0.000000e+00> : vector<1x1xf32>
  %c0 = arith.constant 0 : index
  %c64 = arith.constant 64 : index
  %cst_0 = arith.constant 0.000000e+00 : f32
  %0 = hal.interface.binding.subspan set(0) binding(0) type(storage_buffer) alignment(64) offset(%c0) flags(ReadOnly) : !flow.dispatch.tensor<readonly:tensor<1x4xf32>>
  %1 = hal.interface.binding.subspan set(0) binding(1) type(storage_buffer) alignment(64) offset(%c0) flags(ReadOnly) : !flow.dispatch.tensor<readonly:tensor<4x3xf32>>
  %2 = hal.interface.binding.subspan set(0) binding(1) type(storage_buffer) alignment(64) offset(%c64) flags(ReadOnly) : !flow.dispatch.tensor<readonly:tensor<1x3xf32>>
  %3 = hal.interface.binding.subspan set(0) binding(2) type(storage_buffer) alignment(64) offset(%c0) : !flow.dispatch.tensor<writeonly:tensor<1x3xf32>>
  %workgroup_id_x = hal.interface.workgroup.id[0] : index
  %4 = flow.dispatch.tensor.load %3, offsets = [0, %workgroup_id_x], sizes = [1, 1], strides = [1, 1] : !flow.dispatch.tensor<writeonly:tensor<1x3xf32>> -> tensor<1x1xf32>
  %5 = flow.dispatch.tensor.load %0, offsets = [0, 0], sizes = [1, 4], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<1x4xf32>> -> tensor<1x4xf32>
  %6 = flow.dispatch.tensor.load %1, offsets = [0, %workgroup_id_x], sizes = [4, 1], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<4x3xf32>> -> tensor<4x1xf32>
  %7 = vector.transfer_read %5[%c0, %c0], %cst_0 {in_bounds = [true, true]} : tensor<1x4xf32>, vector<1x4xf32>
  %8 = vector.transfer_read %6[%c0, %c0], %cst_0 {in_bounds = [true, true]} : tensor<4x1xf32>, vector<4x1xf32>
  %9 = vector.contract {indexing_maps = [affine_map<(d0, d1, d2) -> (d0, d2)>, affine_map<(d0, d1, d2) -> (d2, d1)>, affine_map<(d0, d1, d2) -> (d0, d1)>], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %7, %8, %cst : vector<1x4xf32>, vector<4x1xf32> into vector<1x1xf32>
  %10 = flow.dispatch.tensor.load %2, offsets = [0, %workgroup_id_x], sizes = [1, 1], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<1x3xf32>> -> tensor<1x1xf32>
  %11 = vector.transfer_read %10[%c0, %c0], %cst_0 {in_bounds = [true, true]} : tensor<1x1xf32>, vector<1x1xf32>
  %12 = math.absf %9 : vector<1x1xf32>
  %13 = arith.addf %9, %11 : vector<1x1xf32>
  %14 = arith.addf %13, %12 : vector<1x1xf32>
  %15 = vector.transfer_write %14, %4[%c0, %c0] {in_bounds = [true, true]} : vector<1x1xf32>, tensor<1x1xf32>
  flow.dispatch.tensor.store %15, %3, offsets = [0, %workgroup_id_x], sizes = [1, 1], strides = [1, 1] : tensor<1x1xf32> -> !flow.dispatch.tensor<writeonly:tensor<1x3xf32>>
  return
}

