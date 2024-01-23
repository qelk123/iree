
func.func @main_dispatch_0_matmul_1x3x4_f32() {
  %cst = arith.constant dense<0.000000e+00> : vector<1x1xf32>
  %c0 = arith.constant 0 : index
  %c64 = arith.constant 64 : index
  %cst_0 = arith.constant 0.000000e+00 : f32
  %0 = hal.interface.binding.subspan set(0) binding(0) type(storage_buffer) alignment(64) offset(%c0) flags(ReadOnly) : memref<1x4xf32, #hal.descriptor_type<storage_buffer>>
  memref.assume_alignment %0, 64 : memref<1x4xf32, #hal.descriptor_type<storage_buffer>>
  %1 = hal.interface.binding.subspan set(0) binding(1) type(storage_buffer) alignment(64) offset(%c0) flags(ReadOnly) : memref<4x3xf32, #hal.descriptor_type<storage_buffer>>
  memref.assume_alignment %1, 64 : memref<4x3xf32, #hal.descriptor_type<storage_buffer>>
  %2 = hal.interface.binding.subspan set(0) binding(1) type(storage_buffer) alignment(64) offset(%c64) flags(ReadOnly) : memref<1x3xf32, strided<[3, 1], offset: 16>, #hal.descriptor_type<storage_buffer>>
  memref.assume_alignment %2, 64 : memref<1x3xf32, strided<[3, 1], offset: 16>, #hal.descriptor_type<storage_buffer>>
  %3 = hal.interface.binding.subspan set(0) binding(2) type(storage_buffer) alignment(64) offset(%c0) : memref<1x3xf32, #hal.descriptor_type<storage_buffer>>
  memref.assume_alignment %3, 64 : memref<1x3xf32, #hal.descriptor_type<storage_buffer>>
  %workgroup_id_x = hal.interface.workgroup.id[0] : index
  %subview = memref.subview %3[0, %workgroup_id_x] [1, 1] [1, 1] : memref<1x3xf32, #hal.descriptor_type<storage_buffer>> to memref<1x1xf32, strided<[3, 1], offset: ?>, #hal.descriptor_type<storage_buffer>>
  %subview_1 = memref.subview %1[0, %workgroup_id_x] [4, 1] [1, 1] : memref<4x3xf32, #hal.descriptor_type<storage_buffer>> to memref<4x1xf32, strided<[3, 1], offset: ?>, #hal.descriptor_type<storage_buffer>>
  %4 = vector.transfer_read %0[%c0, %c0], %cst_0 {in_bounds = [true, true]} : memref<1x4xf32, #hal.descriptor_type<storage_buffer>>, vector<1x4xf32>
  %5 = vector.transfer_read %subview_1[%c0, %c0], %cst_0 {in_bounds = [true, true]} : memref<4x1xf32, strided<[3, 1], offset: ?>, #hal.descriptor_type<storage_buffer>>, vector<4x1xf32>
  %6 = vector.contract {indexing_maps = [affine_map<(d0, d1, d2) -> (d0, d2)>, affine_map<(d0, d1, d2) -> (d2, d1)>, affine_map<(d0, d1, d2) -> (d0, d1)>], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %4, %5, %cst : vector<1x4xf32>, vector<4x1xf32> into vector<1x1xf32>
  %subview_2 = memref.subview %2[0, %workgroup_id_x] [1, 1] [1, 1] : memref<1x3xf32, strided<[3, 1], offset: 16>, #hal.descriptor_type<storage_buffer>> to memref<1x1xf32, strided<[3, 1], offset: ?>, #hal.descriptor_type<storage_buffer>>
  %7 = vector.transfer_read %subview_2[%c0, %c0], %cst_0 {in_bounds = [true, true]} : memref<1x1xf32, strided<[3, 1], offset: ?>, #hal.descriptor_type<storage_buffer>>, vector<1x1xf32>
  %8 = math.absf %6 : vector<1x1xf32>
  %9 = vector.contract {indexing_maps = [affine_map<(d0, d1, d2) -> (d0, d2)>, affine_map<(d0, d1, d2) -> (d2, d1)>, affine_map<(d0, d1, d2) -> (d0, d1)>], iterator_types = ["parallel", "parallel", "reduction"], kind = #vector.kind<add>} %4, %5, %7 : vector<1x4xf32>, vector<4x1xf32> into vector<1x1xf32>
  %10 = arith.addf %9, %8 : vector<1x1xf32>
  vector.transfer_write %10, %subview[%c0, %c0] {in_bounds = [true, true]} : vector<1x1xf32>, memref<1x1xf32, strided<[3, 1], offset: ?>, #hal.descriptor_type<storage_buffer>>
  %subview_3 = memref.subview %3[0, %workgroup_id_x] [1, 1] [1, 1] : memref<1x3xf32, #hal.descriptor_type<storage_buffer>> to memref<1x1xf32, strided<[3, 1], offset: ?>, #hal.descriptor_type<storage_buffer>>
  memref.copy %subview, %subview_3 : memref<1x1xf32, strided<[3, 1], offset: ?>, #hal.descriptor_type<storage_buffer>> to memref<1x1xf32, strided<[3, 1], offset: ?>, #hal.descriptor_type<storage_buffer>>
  return
}

