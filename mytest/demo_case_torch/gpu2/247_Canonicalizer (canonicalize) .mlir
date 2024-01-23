
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
  %14 = hal.interface.binding.subspan set(0) binding(0) type(storage_buffer) alignment(64) offset(%c0) flags(ReadOnly) : !flow.dispatch.tensor<readonly:tensor<?x?xf32>>{%8, %13}
  %15 = hal.interface.binding.subspan set(0) binding(1) type(storage_buffer) alignment(64) offset(%c0) : !flow.dispatch.tensor<writeonly:tensor<?x?xf32>>{%8, %13}
  %workgroup_id_x = hal.interface.workgroup.id[0] : index
  %16 = affine.apply affine_map<()[s0, s1] -> ((s0 floordiv (s1 ceildiv 128)) * 32)>()[%workgroup_id_x, %13]
  %17 = affine.apply affine_map<()[s0, s1] -> ((s0 mod (s1 ceildiv 128)) * 128)>()[%workgroup_id_x, %13]
  %18 = affine.min affine_map<()[s0, s1, s2] -> (32, s0 - (s1 floordiv (s2 ceildiv 128)) * 32)>()[%8, %workgroup_id_x, %13]
  %19 = affine.min affine_map<()[s0, s1] -> (128, s0 - (s1 mod (s0 ceildiv 128)) * 128)>()[%13, %workgroup_id_x]
  %20 = flow.dispatch.tensor.load %15, offsets = [%16, %17], sizes = [%18, %19], strides = [1, 1] : !flow.dispatch.tensor<writeonly:tensor<?x?xf32>>{%8, %13} -> tensor<?x?xf32>
  %21 = flow.dispatch.tensor.load %14, offsets = [%16, 0], sizes = [%18, %13], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<?x?xf32>>{%8, %13} -> tensor<?x?xf32>
  %22 = flow.dispatch.tensor.load %14, offsets = [0, %17], sizes = [%13, %19], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<?x?xf32>>{%8, %13} -> tensor<?x?xf32>
  %23 = scf.forall (%arg0, %arg1) in (8, 32) shared_outs(%arg2 = %20) -> (tensor<?x?xf32>) {
    %25 = affine.min affine_map<(d0)[s0] -> (-(d0 * (s0 ceildiv 8)) + s0, s0 ceildiv 8)>(%arg0)[%18]
    %26 = affine.max affine_map<(d0) -> (0, d0)>(%25)
    %27 = affine.min affine_map<(d0)[s0] -> (-(d0 * (s0 ceildiv 32)) + s0, s0 ceildiv 32)>(%arg1)[%19]
    %28 = affine.max affine_map<(d0) -> (0, d0)>(%27)
    %29 = affine.apply affine_map<(d0)[s0] -> (d0 * (s0 ceildiv 8))>(%arg0)[%18]
    %30 = affine.apply affine_map<(d0)[s0] -> (d0 * (s0 ceildiv 32))>(%arg1)[%19]
    %extracted_slice_0 = tensor.extract_slice %arg2[%29, %30] [%26, %28] [1, 1] : tensor<?x?xf32> to tensor<?x?xf32>
    %31 = linalg.fill {lowering_config = #iree_codegen.lowering_config<tile_sizes = [[32, 128, 1]]>} ins(%cst : f32) outs(%extracted_slice_0 : tensor<?x?xf32>) -> tensor<?x?xf32>
    %32 = affine.apply affine_map<(d0)[s0] -> (d0 * (s0 ceildiv 8))>(%arg0)[%18]
    %33 = affine.apply affine_map<(d0)[s0] -> (d0 * (s0 ceildiv 32))>(%arg1)[%19]
    scf.forall.in_parallel {
      tensor.parallel_insert_slice %31 into %arg2[%32, %33] [%26, %28] [1, 1] : tensor<?x?xf32> into tensor<?x?xf32>
    }
  } {mapping = [#gpu.thread<y>, #gpu.thread<x>]}
  %extracted_slice = tensor.extract_slice %23[0, 0] [%18, %19] [1, 1] : tensor<?x?xf32> to tensor<?x?xf32>
  %24 = scf.for %arg0 = %c0 to %13 step %c1 iter_args(%arg1 = %extracted_slice) -> (tensor<?x?xf32>) {
    %extracted_slice_0 = tensor.extract_slice %21[0, %arg0] [%18, 1] [1, 1] : tensor<?x?xf32> to tensor<?x1xf32>
    %extracted_slice_1 = tensor.extract_slice %22[%arg0, 0] [1, %19] [1, 1] : tensor<?x?xf32> to tensor<1x?xf32>
    %25 = scf.forall (%arg2, %arg3) in (8, 32) shared_outs(%arg4 = %arg1) -> (tensor<?x?xf32>) {
      %26 = affine.min affine_map<(d0)[s0] -> (-(d0 * (s0 ceildiv 8)) + s0, s0 ceildiv 8)>(%arg2)[%18]
      %27 = affine.max affine_map<(d0) -> (0, d0)>(%26)
      %28 = affine.min affine_map<(d0)[s0] -> (-(d0 * (s0 ceildiv 32)) + s0, s0 ceildiv 32)>(%arg3)[%19]
      %29 = affine.max affine_map<(d0) -> (0, d0)>(%28)
      %30 = affine.apply affine_map<(d0)[s0] -> (d0 * (s0 ceildiv 8))>(%arg2)[%18]
      %31 = affine.apply affine_map<(d0)[s0] -> (d0 * (s0 ceildiv 32))>(%arg3)[%19]
      %32 = affine.apply affine_map<(d0)[s0] -> (d0 * (s0 ceildiv 8))>(%arg2)[%18]
      %33 = affine.apply affine_map<(d0)[s0] -> (d0 * (s0 ceildiv 32))>(%arg3)[%19]
      %extracted_slice_2 = tensor.extract_slice %extracted_slice_0[%30, 0] [%27, 1] [1, 1] : tensor<?x1xf32> to tensor<?x1xf32>
      %extracted_slice_3 = tensor.extract_slice %extracted_slice_1[0, %31] [1, %29] [1, 1] : tensor<1x?xf32> to tensor<1x?xf32>
      %extracted_slice_4 = tensor.extract_slice %arg4[%32, %33] [%27, %29] [1, 1] : tensor<?x?xf32> to tensor<?x?xf32>
      %34 = linalg.matmul {__internal_linalg_transform__ = "workgroup_k_tiled", lowering_config = #iree_codegen.lowering_config<tile_sizes = [[32, 128, 1]]>} ins(%extracted_slice_2, %extracted_slice_3 : tensor<?x1xf32>, tensor<1x?xf32>) outs(%extracted_slice_4 : tensor<?x?xf32>) -> tensor<?x?xf32>
      %35 = affine.apply affine_map<(d0)[s0] -> (d0 * (s0 ceildiv 8))>(%arg2)[%18]
      %36 = affine.apply affine_map<(d0)[s0] -> (d0 * (s0 ceildiv 32))>(%arg3)[%19]
      scf.forall.in_parallel {
        tensor.parallel_insert_slice %34 into %arg4[%35, %36] [%27, %29] [1, 1] : tensor<?x?xf32> into tensor<?x?xf32>
      }
    } {mapping = [#gpu.thread<y>, #gpu.thread<x>]}
    scf.yield %25 : tensor<?x?xf32>
  }
  %inserted_slice = tensor.insert_slice %24 into %23[0, 0] [%18, %19] [1, 1] : tensor<?x?xf32> into tensor<?x?xf32>
  flow.dispatch.tensor.store %inserted_slice, %15, offsets = [%16, %17], sizes = [%18, %19], strides = [1, 1] : tensor<?x?xf32> -> !flow.dispatch.tensor<writeonly:tensor<?x?xf32>>{%8, %13}
  return
}

