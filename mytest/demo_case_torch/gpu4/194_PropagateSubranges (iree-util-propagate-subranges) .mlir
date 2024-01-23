
#composite_of_128b = #util.composite<128xi8, [
    dense<[[1.54099607, -0.293428898, -2.17878938], [0.568431258, -1.08452237, -1.39859545], [0.403346837, 0.838026344, -0.719257593], [-0.403343529, -0.596635341, 0.182036489]]> : tensor<4x3xf32>,
    dense<0> : vector<16xi8>,
    dense<[-0.856674611, 1.10060418, -1.07118738]> : tensor<3xf32>,
    dense<0> : vector<52xi8>,
]>
#executable_target_cuda_nvptx_fb = #hal.executable.target<"cuda", "cuda-nvptx-fb", {target_arch = "sm_75"}>
#map = affine_map<(d0, d1) -> (d0, d1)>
#device_target_cuda = #hal.device.target<"cuda", {executable_targets = [#executable_target_cuda_nvptx_fb], legacy_sync}>
module @LinearModule attributes {hal.device.targets = [#device_target_cuda]} {
  util.global private mutable @_params.weight__timepoint = #stream.timepoint<immediate> : !stream.timepoint
  util.global private @_params.weight : !stream.resource<constant>
  util.global private mutable @_params.weight__storage_size : index
  util.global private mutable @_params.weight__offset : index
  util.global private mutable @_params.weight__length : index
  util.global private @_params.bias : !stream.resource<constant>
  util.global private mutable @_params.bias__storage_size : index
  util.global private mutable @_params.bias__offset : index
  util.global private mutable @_params.bias__length : index
  util.initializer {
    %c0 = arith.constant 0 : index
    %c48 = arith.constant 48 : index
    %c12 = arith.constant 12 : index
    %0 = stream.timepoint.immediate => !stream.timepoint
    %buffer_cst = util.buffer.constant {alignment = 64 : index} : !util.buffer = #composite_of_128b
    %c128 = arith.constant 128 : index
    %c0_0 = arith.constant 0 : index
    %did_map, %result = stream.resource.try_map %buffer_cst[%c0_0] : !util.buffer -> i1, !stream.resource<constant>{%c128}
    %1:2 = scf.if %did_map -> (!stream.timepoint, !stream.resource<constant>) {
      scf.yield %0, %result : !stream.timepoint, !stream.resource<constant>
    } else {
      %6 = stream.resource.alloc uninitialized : !stream.resource<constant>{%c128}
      %file = stream.file.constant %buffer_cst[%c0_0 for %c128] : !util.buffer{%c128} -> !stream.file
      %c0_i64 = arith.constant 0 : i64
      %7 = stream.file.read await(%0) => %file[%c0_i64], %6[%c0_0], %c128 : !stream.file -> !stream.resource<constant>{%c128} => !stream.timepoint
      scf.yield %7, %6 : !stream.timepoint, !stream.resource<constant>
    }
    %2 = stream.resource.subview %1#1[%c0_0] : !stream.resource<constant>{%c128} -> !stream.resource<constant>{%c48}
    %c64 = arith.constant 64 : index
    %3 = stream.resource.subview %1#1[%c64] : !stream.resource<constant>{%c128} -> !stream.resource<constant>{%c12}
    %4 = stream.cmd.execute with() {
    } => !stream.timepoint
    %5 = stream.timepoint.join max(%1#0, %4) => !stream.timepoint
    util.global.store %1#1, @_params.bias : !stream.resource<constant>
    util.global.store %c128, @_params.bias__storage_size : index
    util.global.store %c64, @_params.bias__offset : index
    util.global.store %c12, @_params.bias__length : index
    util.global.store %1#1, @_params.weight : !stream.resource<constant>
    util.global.store %c128, @_params.weight__storage_size : index
    util.global.store %c0_0, @_params.weight__offset : index
    util.global.store %c48, @_params.weight__length : index
    util.global.store %5, @_params.weight__timepoint : !stream.timepoint
    util.initializer.return
  }
  stream.executable private @main_dispatch_0 {
    stream.executable.export public @main_dispatch_0_matmul_1x3x4_f32 workgroups() -> (index, index, index) {
      %x, %y, %z = flow.dispatch.workgroup_count_from_slice 
      stream.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_0_matmul_1x3x4_f32(%arg0: !stream.binding, %arg1: !stream.binding, %arg2: !stream.binding, %arg3: !stream.binding) {
        %cst = arith.constant 0.000000e+00 : f32
        %c0 = arith.constant 0 : index
        %0 = stream.binding.subspan %arg0[%c0] : !stream.binding -> !flow.dispatch.tensor<readonly:tensor<1x4xf32>>
        %1 = stream.binding.subspan %arg1[%c0] : !stream.binding -> !flow.dispatch.tensor<readonly:tensor<4x3xf32>>
        %2 = stream.binding.subspan %arg2[%c0] : !stream.binding -> !flow.dispatch.tensor<readonly:tensor<1x3xf32>>
        %3 = stream.binding.subspan %arg3[%c0] : !stream.binding -> !flow.dispatch.tensor<writeonly:tensor<1x3xf32>>
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
  func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
    %c48 = arith.constant 48 : index
    %c0 = arith.constant 0 : index
    %c4 = arith.constant 4 : index
    %c1_i32 = arith.constant 1 : i32
    %c553648160_i32 = arith.constant 553648160 : i32
    %c12 = arith.constant 12 : index
    %c16 = arith.constant 16 : index
    %_params.weight__timepoint = util.global.load @_params.weight__timepoint : !stream.timepoint
    %_params.weight__timepoint_0 = util.global.load @_params.weight__timepoint : !stream.timepoint
    %_params.weight = util.global.load @_params.weight : !stream.resource<constant>
    %_params.weight__storage_size = util.global.load @_params.weight__storage_size : index
    %_params.weight__offset = util.global.load @_params.weight__offset : index
    %_params.weight__length = util.global.load @_params.weight__length : index
    %0 = stream.resource.subview %_params.weight[%_params.weight__offset] : !stream.resource<constant>{%_params.weight__storage_size} -> !stream.resource<constant>{%_params.weight__length}
    %_params.bias = util.global.load @_params.bias : !stream.resource<constant>
    %_params.bias__storage_size = util.global.load @_params.bias__storage_size : index
    %_params.bias__offset = util.global.load @_params.bias__offset : index
    %_params.bias__length = util.global.load @_params.bias__length : index
    %1 = stream.resource.subview %_params.bias[%_params.bias__offset] : !stream.resource<constant>{%_params.bias__storage_size} -> !stream.resource<constant>{%_params.bias__length}
    hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input 0") shape([%c4]) type(%c553648160_i32) encoding(%c1_i32)
    %2 = stream.tensor.import %arg0 : !hal.buffer_view -> tensor<4xf32> in !stream.resource<external>{%c16}
    %3 = stream.timepoint.join max(%_params.weight__timepoint, %_params.weight__timepoint_0) => !stream.timepoint
    %c0_1 = arith.constant 0 : index
    %result, %result_timepoint = stream.resource.alloca uninitialized await(%3) => !stream.resource<external>{%c12} => !stream.timepoint
    %4 = stream.timepoint.join max(%3, %result_timepoint) => !stream.timepoint
    %5 = stream.cmd.execute await(%4) => with(%2 as %arg1: !stream.resource<external>{%c16}, %0 as %arg2: !stream.resource<constant>{%c48}, %1 as %arg3: !stream.resource<constant>{%c12}, %result as %arg4: !stream.resource<external>{%c12}) {
      stream.cmd.dispatch @main_dispatch_0::@main_dispatch_0_matmul_1x3x4_f32 {
        ro %arg1[%c0 for %c16] : !stream.resource<external>{%c16},
        ro %arg2[%c0 for %c48] : !stream.resource<constant>{%c48},
        ro %arg3[%c0 for %c12] : !stream.resource<constant>{%c12},
        wo %arg4[%c0_1 for %c12] : !stream.resource<external>{%c12}
      }
    } => !stream.timepoint
    %6 = stream.timepoint.await %5 => %result : !stream.resource<external>{%c12}
    %7 = stream.tensor.export %6 : tensor<3xf32> in !stream.resource<external>{%c12} -> !hal.buffer_view
    return %7 : !hal.buffer_view
  }
}


