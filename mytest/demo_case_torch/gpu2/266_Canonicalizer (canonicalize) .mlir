
module {
  func.func @main_dispatch_0_matmul_DxDxD_f32() {
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c32_i64 = arith.constant 32 : i64
    %cst = arith.constant 0.000000e+00 : f32
    %0 = hal.interface.constant.load[0] : i32
    %1 = hal.interface.constant.load[1] : i32
    %2 = hal.interface.constant.load[2] : i32
    %3 = hal.interface.constant.load[3] : i32
    %4 = arith.extui %0 : i32 to i64
    %5 = arith.extui %1 : i32 to i64
    %6 = arith.shli %5, %c32_i64 : i64
    %7 = arith.ori %4, %6 : i64
    %8 = arith.index_castui %7 : i64 to index
    %9 = arith.extui %2 : i32 to i64
    %10 = arith.extui %3 : i32 to i64
    %11 = arith.shli %10, %c32_i64 : i64
    %12 = arith.ori %9, %11 : i64
    %13 = arith.index_castui %12 : i64 to index
    %14 = hal.interface.binding.subspan set(0) binding(0) type(storage_buffer) alignment(64) offset(%c0) flags(ReadOnly) : memref<?x?xf32, #hal.descriptor_type<storage_buffer>>{%8, %13}
    memref.assume_alignment %14, 64 : memref<?x?xf32, #hal.descriptor_type<storage_buffer>>
    %15 = hal.interface.binding.subspan set(0) binding(1) type(storage_buffer) alignment(64) offset(%c0) : memref<?x?xf32, #hal.descriptor_type<storage_buffer>>{%8, %13}
    memref.assume_alignment %15, 64 : memref<?x?xf32, #hal.descriptor_type<storage_buffer>>
    %workgroup_id_x = hal.interface.workgroup.id[0] : index
    %16 = affine.apply affine_map<()[s0, s1] -> ((s0 floordiv (s1 ceildiv 128)) * 32)>()[%workgroup_id_x, %13]
    %17 = affine.apply affine_map<()[s0, s1] -> ((s0 mod (s1 ceildiv 128)) * 128)>()[%workgroup_id_x, %13]
    %18 = affine.min affine_map<()[s0, s1, s2] -> (32, s0 - (s1 floordiv (s2 ceildiv 128)) * 32)>()[%8, %workgroup_id_x, %13]
    %19 = affine.min affine_map<()[s0, s1] -> (128, s0 - (s1 mod (s0 ceildiv 128)) * 128)>()[%13, %workgroup_id_x]
    %subview = memref.subview %15[%16, %17] [%18, %19] [1, 1] : memref<?x?xf32, #hal.descriptor_type<storage_buffer>> to memref<?x?xf32, strided<[?, 1], offset: ?>, #hal.descriptor_type<storage_buffer>>
    %subview_0 = memref.subview %14[%16, 0] [%18, %13] [1, 1] : memref<?x?xf32, #hal.descriptor_type<storage_buffer>> to memref<?x?xf32, strided<[?, 1], offset: ?>, #hal.descriptor_type<storage_buffer>>
    %subview_1 = memref.subview %14[0, %17] [%13, %19] [1, 1] : memref<?x?xf32, #hal.descriptor_type<storage_buffer>> to memref<?x?xf32, strided<[?, 1], offset: ?>, #hal.descriptor_type<storage_buffer>>
    %20 = gpu.thread_id  x
    %21 = gpu.thread_id  y
    %22 = affine.min affine_map<()[s0, s1] -> (s0 - s1 * (s0 ceildiv 8), s0 ceildiv 8)>()[%18, %21]
    %23 = affine.max affine_map<()[s0] -> (0, s0)>()[%22]
    %24 = affine.min affine_map<()[s0, s1] -> (s0 - s1 * (s0 ceildiv 32), s0 ceildiv 32)>()[%19, %20]
    %25 = affine.max affine_map<()[s0] -> (0, s0)>()[%24]
    %26 = affine.apply affine_map<()[s0, s1] -> (s1 * (s0 ceildiv 8))>()[%18, %21]
    %27 = affine.apply affine_map<()[s0, s1] -> (s1 * (s0 ceildiv 32))>()[%19, %20]
    %subview_2 = memref.subview %subview[%26, %27] [%23, %25] [1, 1] : memref<?x?xf32, strided<[?, 1], offset: ?>, #hal.descriptor_type<storage_buffer>> to memref<?x?xf32, strided<[?, 1], offset: ?>, #hal.descriptor_type<storage_buffer>>
    linalg.fill {lowering_config = #iree_codegen.lowering_config<tile_sizes = [[32, 128, 1]]>} ins(%cst : f32) outs(%subview_2 : memref<?x?xf32, strided<[?, 1], offset: ?>, #hal.descriptor_type<storage_buffer>>)
    scf.for %arg0 = %c0 to %13 step %c1 {
      %subview_3 = memref.subview %subview_0[0, %arg0] [%18, 1] [1, 1] : memref<?x?xf32, strided<[?, 1], offset: ?>, #hal.descriptor_type<storage_buffer>> to memref<?x1xf32, strided<[?, 1], offset: ?>, #hal.descriptor_type<storage_buffer>>
      %subview_4 = memref.subview %subview_1[%arg0, 0] [1, %19] [1, 1] : memref<?x?xf32, strided<[?, 1], offset: ?>, #hal.descriptor_type<storage_buffer>> to memref<1x?xf32, strided<[?, 1], offset: ?>, #hal.descriptor_type<storage_buffer>>
      %28 = affine.min affine_map<()[s0, s1] -> (s0 - s1 * (s0 ceildiv 8), s0 ceildiv 8)>()[%18, %21]
      %29 = affine.max affine_map<(d0) -> (0, d0)>(%28)
      %30 = affine.min affine_map<()[s0, s1] -> (s0 - s1 * (s0 ceildiv 32), s0 ceildiv 32)>()[%19, %20]
      %31 = affine.max affine_map<(d0) -> (0, d0)>(%30)
      %32 = affine.apply affine_map<()[s0, s1] -> (s1 * (s0 ceildiv 8))>()[%18, %21]
      %33 = affine.apply affine_map<()[s0, s1] -> (s1 * (s0 ceildiv 32))>()[%19, %20]
      %subview_5 = memref.subview %subview_3[%32, 0] [%29, 1] [1, 1] : memref<?x1xf32, strided<[?, 1], offset: ?>, #hal.descriptor_type<storage_buffer>> to memref<?x1xf32, strided<[?, 1], offset: ?>, #hal.descriptor_type<storage_buffer>>
      %subview_6 = memref.subview %subview_4[0, %33] [1, %31] [1, 1] : memref<1x?xf32, strided<[?, 1], offset: ?>, #hal.descriptor_type<storage_buffer>> to memref<1x?xf32, strided<[?, 1], offset: ?>, #hal.descriptor_type<storage_buffer>>
      %subview_7 = memref.subview %subview[%32, %33] [%29, %31] [1, 1] : memref<?x?xf32, strided<[?, 1], offset: ?>, #hal.descriptor_type<storage_buffer>> to memref<?x?xf32, strided<[?, 1], offset: ?>, #hal.descriptor_type<storage_buffer>>
      linalg.matmul {__internal_linalg_transform__ = "workgroup_k_tiled", lowering_config = #iree_codegen.lowering_config<tile_sizes = [[32, 128, 1]]>} ins(%subview_5, %subview_6 : memref<?x1xf32, strided<[?, 1], offset: ?>, #hal.descriptor_type<storage_buffer>>, memref<1x?xf32, strided<[?, 1], offset: ?>, #hal.descriptor_type<storage_buffer>>) outs(%subview_7 : memref<?x?xf32, strided<[?, 1], offset: ?>, #hal.descriptor_type<storage_buffer>>)
    }
    return
  }
}

