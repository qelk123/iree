
func.func @main_dispatch_0_matmul_DxDxD_f32() {
  %c32_i64 = arith.constant 32 : i64
  %cst = arith.constant 0.000000e+00 : f32
  %c0 = arith.constant 0 : index
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
  %14 = hal.interface.binding.subspan set(0) binding(0) type(storage_buffer) alignment(64) offset(%c0) flags(ReadOnly) : !flow.dispatch.tensor<readonly:tensor<?x?xf32>>{%8, %13}
  %15 = hal.interface.binding.subspan set(0) binding(1) type(storage_buffer) alignment(64) offset(%c0) : !flow.dispatch.tensor<writeonly:tensor<?x?xf32>>{%8, %13}
  %16 = arith.extui %0 : i32 to i64
  %17 = arith.extui %1 : i32 to i64
  %18 = arith.shli %17, %c32_i64 : i64
  %19 = arith.ori %16, %18 : i64
  %20 = arith.index_castui %19 : i64 to index
  %21 = arith.extui %2 : i32 to i64
  %22 = arith.extui %3 : i32 to i64
  %23 = arith.shli %22, %c32_i64 : i64
  %24 = arith.ori %21, %23 : i64
  %25 = arith.index_castui %24 : i64 to index
  %workgroup_id_x = hal.interface.workgroup.id[0] : index
  %26 = arith.extui %2 : i32 to i64
  %27 = arith.extui %3 : i32 to i64
  %28 = arith.shli %27, %c32_i64 : i64
  %29 = arith.ori %26, %28 : i64
  %30 = arith.index_castui %29 : i64 to index
  %31 = affine.apply affine_map<()[s0, s1] -> ((s0 floordiv (s1 ceildiv 128)) * 32)>()[%workgroup_id_x, %30]
  %32 = affine.apply affine_map<()[s0, s1] -> ((s0 mod (s1 ceildiv 128)) * 128)>()[%workgroup_id_x, %30]
  %33 = arith.extui %0 : i32 to i64
  %34 = arith.extui %1 : i32 to i64
  %35 = arith.shli %34, %c32_i64 : i64
  %36 = arith.ori %33, %35 : i64
  %37 = arith.index_castui %36 : i64 to index
  %38 = affine.min affine_map<()[s0, s1, s2] -> (32, s0 - (s1 floordiv (s2 ceildiv 128)) * 32)>()[%37, %workgroup_id_x, %30]
  %39 = affine.min affine_map<()[s0, s1] -> (128, s0 - (s1 mod (s0 ceildiv 128)) * 128)>()[%30, %workgroup_id_x]
  %40 = flow.dispatch.tensor.load %15, offsets = [%31, %32], sizes = [%38, %39], strides = [1, 1] : !flow.dispatch.tensor<writeonly:tensor<?x?xf32>>{%20, %25} -> tensor<?x?xf32>
  %workgroup_id_x_0 = hal.interface.workgroup.id[0] : index
  %41 = affine.min affine_map<()[s0, s1, s2] -> (32, s0 - (s1 floordiv (s2 ceildiv 128)) * 32)>()[%8, %workgroup_id_x_0, %13]
  %42 = affine.min affine_map<()[s0, s1] -> (128, s0 - (s1 mod (s0 ceildiv 128)) * 128)>()[%13, %workgroup_id_x_0]
  %43 = affine.apply affine_map<()[s0, s1] -> ((s0 floordiv (s1 ceildiv 128)) * 32)>()[%workgroup_id_x_0, %13]
  %44 = flow.dispatch.tensor.load %14, offsets = [%43, 0], sizes = [%41, %13], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<?x?xf32>>{%8, %13} -> tensor<?x?xf32>
  %45 = affine.apply affine_map<()[s0, s1] -> ((s0 mod (s1 ceildiv 128)) * 128)>()[%workgroup_id_x_0, %13]
  %46 = flow.dispatch.tensor.load %14, offsets = [0, %45], sizes = [%13, %42], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<?x?xf32>>{%8, %13} -> tensor<?x?xf32>
  %47 = linalg.fill {lowering_config = #iree_codegen.lowering_config<tile_sizes = [[32, 128, 1]]>} ins(%cst : f32) outs(%40 : tensor<?x?xf32>) -> tensor<?x?xf32>
  %48 = linalg.matmul {lowering_config = #iree_codegen.lowering_config<tile_sizes = [[32, 128, 1]]>} ins(%44, %46 : tensor<?x?xf32>, tensor<?x?xf32>) outs(%47 : tensor<?x?xf32>) -> tensor<?x?xf32>
  %49 = arith.extui %0 : i32 to i64
  %50 = arith.extui %1 : i32 to i64
  %51 = arith.shli %50, %c32_i64 : i64
  %52 = arith.ori %49, %51 : i64
  %53 = arith.index_castui %52 : i64 to index
  %54 = arith.extui %2 : i32 to i64
  %55 = arith.extui %3 : i32 to i64
  %56 = arith.shli %55, %c32_i64 : i64
  %57 = arith.ori %54, %56 : i64
  %58 = arith.index_castui %57 : i64 to index
  %59 = affine.apply affine_map<()[s0, s1] -> ((s0 floordiv (s1 ceildiv 128)) * 32)>()[%workgroup_id_x_0, %13]
  %60 = affine.apply affine_map<()[s0, s1] -> ((s0 mod (s1 ceildiv 128)) * 128)>()[%workgroup_id_x_0, %13]
  flow.dispatch.tensor.store %48, %15, offsets = [%59, %60], sizes = [%41, %42], strides = [1, 1] : tensor<?x?xf32> -> !flow.dispatch.tensor<writeonly:tensor<?x?xf32>>{%53, %58}
  return
}

