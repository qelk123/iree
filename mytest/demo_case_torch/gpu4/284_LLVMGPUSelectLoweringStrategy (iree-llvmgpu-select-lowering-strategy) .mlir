
hal.executable.variant public @cuda_nvptx_fb target(<"cuda", "cuda-nvptx-fb", {target_arch = "sm_75"}>) {
  hal.executable.export public @main_dispatch_0_matmul_1x3x4_f32 ordinal(0) layout(#hal.pipeline.layout<push_constants = 0, sets = [<0, bindings = [<0, storage_buffer, ReadOnly>, <1, storage_buffer, ReadOnly>, <2, storage_buffer>]>]>) attributes {translation_info = #iree_codegen.translation_info<LLVMGPUMatmulSimt>, workgroup_size = [1 : index, 3 : index, 1 : index]} {
  ^bb0(%arg0: !hal.device):
    %x, %y, %z = flow.dispatch.workgroup_count_from_slice 
    hal.return %x, %y, %z : index, index, index
  }
  builtin.module {
    func.func @main_dispatch_0_matmul_1x3x4_f32() {
      %c0 = arith.constant 0 : index
      %c64 = arith.constant 64 : index
      %cst = arith.constant 0.000000e+00 : f32
      %0 = hal.interface.binding.subspan set(0) binding(0) type(storage_buffer) alignment(64) offset(%c0) flags(ReadOnly) : !flow.dispatch.tensor<readonly:tensor<1x4xf32>>
      %1 = hal.interface.binding.subspan set(0) binding(1) type(storage_buffer) alignment(64) offset(%c0) flags(ReadOnly) : !flow.dispatch.tensor<readonly:tensor<4x3xf32>>
      %2 = hal.interface.binding.subspan set(0) binding(1) type(storage_buffer) alignment(64) offset(%c64) flags(ReadOnly) : !flow.dispatch.tensor<readonly:tensor<1x3xf32>>
      %3 = hal.interface.binding.subspan set(0) binding(2) type(storage_buffer) alignment(64) offset(%c0) : !flow.dispatch.tensor<writeonly:tensor<1x3xf32>>
      %4 = flow.dispatch.tensor.load %0, offsets = [0, 0], sizes = [1, 4], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<1x4xf32>> -> tensor<1x4xf32>
      %5 = flow.dispatch.tensor.load %1, offsets = [0, 0], sizes = [4, 3], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<4x3xf32>> -> tensor<4x3xf32>
      %6 = flow.dispatch.tensor.load %2, offsets = [0, 0], sizes = [1, 3], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<1x3xf32>> -> tensor<1x3xf32>
      %7 = tensor.empty() : tensor<1x3xf32>
      %8 = linalg.fill {lowering_config = #iree_codegen.lowering_config<tile_sizes = [[0, 1, 4]]>} ins(%cst : f32) outs(%7 : tensor<1x3xf32>) -> tensor<1x3xf32>
      %9 = linalg.matmul {lowering_config = #iree_codegen.lowering_config<tile_sizes = [[0, 1, 4]]>} ins(%4, %5 : tensor<1x4xf32>, tensor<4x3xf32>) outs(%8 : tensor<1x3xf32>) -> tensor<1x3xf32>
      %10 = linalg.generic {indexing_maps = [affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>, affine_map<(d0, d1) -> (d0, d1)>], iterator_types = ["parallel", "parallel"]} ins(%9, %6 : tensor<1x3xf32>, tensor<1x3xf32>) outs(%7 : tensor<1x3xf32>) attrs =  {lowering_config = #iree_codegen.lowering_config<tile_sizes = [[0, 1, 4]]>} {
      ^bb0(%in: f32, %in_0: f32, %out: f32):
        %11 = math.absf %in : f32
        %12 = arith.addf %in, %in_0 : f32
        %13 = arith.addf %12, %11 : f32
        linalg.yield %13 : f32
      } -> tensor<1x3xf32>
      flow.dispatch.tensor.store %10, %3, offsets = [0, 0], sizes = [1, 3], strides = [1, 1] : tensor<1x3xf32> -> !flow.dispatch.tensor<writeonly:tensor<1x3xf32>>
      return
    }
  }
}

