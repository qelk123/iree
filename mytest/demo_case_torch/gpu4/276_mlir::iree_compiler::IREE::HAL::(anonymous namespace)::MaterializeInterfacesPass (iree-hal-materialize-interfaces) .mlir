
#composite_of_128b = #util.composite<128xi8, [
    dense<[[1.54099607, -0.293428898, -2.17878938], [0.568431258, -1.08452237, -1.39859545], [0.403346837, 0.838026344, -0.719257593], [-0.403343529, -0.596635341, 0.182036489]]> : tensor<4x3xf32>,
    dense<0> : vector<16xi8>,
    dense<[-0.856674611, 1.10060418, -1.07118738]> : tensor<3xf32>,
    dense<0> : vector<52xi8>,
]>
#executable_target_cuda_nvptx_fb = #hal.executable.target<"cuda", "cuda-nvptx-fb", {target_arch = "sm_75"}>
#map = affine_map<(d0, d1) -> (d0, d1)>
#pipeline_layout = #hal.pipeline.layout<push_constants = 0, sets = [<0, bindings = [<0, storage_buffer, ReadOnly>, <1, storage_buffer, ReadOnly>, <2, storage_buffer>]>]>
#device_target_cuda = #hal.device.target<"cuda", {executable_targets = [#executable_target_cuda_nvptx_fb], legacy_sync}>
module @LinearModule attributes {hal.device.targets = [#device_target_cuda]} {
  util.global private mutable @_params.weight__timepoint = #stream.timepoint<immediate> : !stream.timepoint
  util.global private @_params.weight : !stream.resource<constant>
  util.initializer {
    %0 = stream.timepoint.immediate => !stream.timepoint
    %c0_i64 = arith.constant 0 : i64
    %c128 = arith.constant 128 : index
    %c0 = arith.constant 0 : index
    %buffer_cst = util.buffer.constant {alignment = 64 : index} : !util.buffer = #composite_of_128b
    %did_map, %result = stream.resource.try_map %buffer_cst[%c0] : !util.buffer -> i1, !stream.resource<constant>{%c128}
    cf.cond_br %did_map, ^bb2(%0, %result : !stream.timepoint, !stream.resource<constant>), ^bb1
  ^bb1:  // pred: ^bb0
    %1 = stream.resource.alloc uninitialized : !stream.resource<constant>{%c128}
    %file = stream.file.constant %buffer_cst[%c0 for %c128] : !util.buffer{%c128} -> !stream.file
    %2 = stream.file.read await(%0) => %file[%c0_i64], %1[%c0], %c128 : !stream.file -> !stream.resource<constant>{%c128} => !stream.timepoint
    cf.br ^bb2(%2, %1 : !stream.timepoint, !stream.resource<constant>)
  ^bb2(%3: !stream.timepoint, %4: !stream.resource<constant>):  // 2 preds: ^bb0, ^bb1
    util.global.store %4, @_params.weight : !stream.resource<constant>
    util.global.store %3, @_params.weight__timepoint : !stream.timepoint
    util.initializer.return
  }
  hal.executable private @main_dispatch_0 {
    hal.executable.variant public @cuda_nvptx_fb target(#executable_target_cuda_nvptx_fb) {
      hal.executable.export public @main_dispatch_0_matmul_1x3x4_f32 ordinal(0) layout(#pipeline_layout) {
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
          %8 = linalg.fill ins(%cst : f32) outs(%7 : tensor<1x3xf32>) -> tensor<1x3xf32>
          %9 = linalg.matmul ins(%4, %5 : tensor<1x4xf32>, tensor<4x3xf32>) outs(%8 : tensor<1x3xf32>) -> tensor<1x3xf32>
          %10 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%9, %6 : tensor<1x3xf32>, tensor<1x3xf32>) outs(%7 : tensor<1x3xf32>) {
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
  }
  func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
    %c128 = arith.constant 128 : index
    %c16 = arith.constant 16 : index
    %c12 = arith.constant 12 : index
    %c553648160_i32 = arith.constant 553648160 : i32
    %c1_i32 = arith.constant 1 : i32
    %c4 = arith.constant 4 : index
    %c0 = arith.constant 0 : index
    %_params.weight__timepoint = util.global.load @_params.weight__timepoint : !stream.timepoint
    %_params.weight = util.global.load @_params.weight : !stream.resource<constant>
    hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input 0") shape([%c4]) type(%c553648160_i32) encoding(%c1_i32)
    %0 = stream.tensor.import %arg0 : !hal.buffer_view -> tensor<4xf32> in !stream.resource<external>{%c16}
    %result, %result_timepoint = stream.resource.alloca uninitialized await(%_params.weight__timepoint) => !stream.resource<external>{%c12} => !stream.timepoint
    %1 = stream.cmd.execute await(%result_timepoint) => with(%0 as %arg1: !stream.resource<external>{%c16}, %_params.weight as %arg2: !stream.resource<constant>{%c128}, %result as %arg3: !stream.resource<external>{%c12}) {
      stream.cmd.dispatch @main_dispatch_0::@cuda_nvptx_fb::@main_dispatch_0_matmul_1x3x4_f32 {
        ro %arg1[%c0 for %c16] : !stream.resource<external>{%c16},
        ro %arg2[%c0 for %c128] : !stream.resource<constant>{%c128},
        wo %arg3[%c0 for %c12] : !stream.resource<external>{%c12}
      } attributes {hal.interface.bindings = [#hal.interface.binding<0, 0>, #hal.interface.binding<0, 1>, #hal.interface.binding<0, 2>]}
    } => !stream.timepoint
    %2 = stream.timepoint.await %1 => %result : !stream.resource<external>{%c12}
    %3 = stream.tensor.export %2 : tensor<3xf32> in !stream.resource<external>{%c12} -> !hal.buffer_view
    return %3 : !hal.buffer_view
  }
}


