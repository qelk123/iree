
hal.executable.variant public @cuda_nvptx_fb target(<"cuda", "cuda-nvptx-fb", {target_arch = "sm_75"}>) {
  hal.executable.export public @main_dispatch_0_matmul_DxDxD_f32 ordinal(0) layout(#hal.pipeline.layout<push_constants = 4, sets = [<0, bindings = [<0, storage_buffer, ReadOnly>, <1, storage_buffer>]>]>) attributes {translation_info = #iree_codegen.translation_info<LLVMGPUMatmulSimt>, workgroup_size = [32 : index, 8 : index, 1 : index]} {
  ^bb0(%arg0: !hal.device, %arg1: index, %arg2: index):
    %c1 = arith.constant 1 : index
    %0 = affine.apply affine_map<()[s0, s1] -> ((s0 ceildiv 128) * (s1 ceildiv 32))>()[%arg2, %arg1]
    hal.return %0, %c1, %c1 : index, index, index
  }
  builtin.module {
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
      %workgroup_id_x = hal.interface.workgroup.id[0] : index
      %16 = affine.min affine_map<()[s0, s1, s2] -> (32, s0 - (s1 floordiv (s2 ceildiv 128)) * 32)>()[%8, %workgroup_id_x, %13]
      %17 = affine.min affine_map<()[s0, s1] -> (128, s0 - (s1 mod (s0 ceildiv 128)) * 128)>()[%13, %workgroup_id_x]
      %18 = affine.apply affine_map<()[s0, s1] -> ((s0 floordiv (s1 ceildiv 128)) * 32)>()[%workgroup_id_x, %13]
      %19 = flow.dispatch.tensor.load %14, offsets = [%18, 0], sizes = [%16, %13], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<?x?xf32>>{%8, %13} -> tensor<?x?xf32>
      %20 = affine.apply affine_map<()[s0, s1] -> ((s0 mod (s1 ceildiv 128)) * 128)>()[%workgroup_id_x, %13]
      %21 = flow.dispatch.tensor.load %14, offsets = [0, %20], sizes = [%13, %17], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<?x?xf32>>{%8, %13} -> tensor<?x?xf32>
      %22 = tensor.empty(%16, %17) : tensor<?x?xf32>
      %23 = linalg.fill {lowering_config = #iree_codegen.lowering_config<tile_sizes = [[32, 128, 1]]>} ins(%cst : f32) outs(%22 : tensor<?x?xf32>) -> tensor<?x?xf32>
      %24 = linalg.matmul {lowering_config = #iree_codegen.lowering_config<tile_sizes = [[32, 128, 1]]>} ins(%19, %21 : tensor<?x?xf32>, tensor<?x?xf32>) outs(%23 : tensor<?x?xf32>) -> tensor<?x?xf32>
      %25 = arith.extui %0 : i32 to i64
      %26 = arith.extui %1 : i32 to i64
      %27 = arith.shli %26, %c32_i64 : i64
      %28 = arith.ori %25, %27 : i64
      %29 = arith.index_castui %28 : i64 to index
      %30 = arith.extui %2 : i32 to i64
      %31 = arith.extui %3 : i32 to i64
      %32 = arith.shli %31, %c32_i64 : i64
      %33 = arith.ori %30, %32 : i64
      %34 = arith.index_castui %33 : i64 to index
      %35 = affine.apply affine_map<()[s0, s1] -> ((s0 floordiv (s1 ceildiv 128)) * 32)>()[%workgroup_id_x, %13]
      %36 = affine.apply affine_map<()[s0, s1] -> ((s0 mod (s1 ceildiv 128)) * 128)>()[%workgroup_id_x, %13]
      flow.dispatch.tensor.store %24, %15, offsets = [%35, %36], sizes = [%16, %17], strides = [1, 1] : tensor<?x?xf32> -> !flow.dispatch.tensor<writeonly:tensor<?x?xf32>>{%29, %34}
      return
    }
  }
}

