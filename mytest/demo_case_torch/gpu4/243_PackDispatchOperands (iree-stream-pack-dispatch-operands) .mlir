
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
  stream.executable private @main_dispatch_0 {
    stream.executable.export public @main_dispatch_0_matmul_1x3x4_f32 workgroups() -> (index, index, index) {
      %x, %y, %z = flow.dispatch.workgroup_count_from_slice 
      stream.return %x, %y, %z : index, index, index
    }
    builtin.module {
      func.func @main_dispatch_0_matmul_1x3x4_f32(%arg0: !stream.binding {stream.alignment = 64 : index}, %arg1: !stream.binding {stream.alignment = 64 : index}, %arg2: !stream.binding {stream.alignment = 64 : index}, %arg3: i32, %arg4: i32, %arg5: i32, %arg6: i32, %arg7: i32, %arg8: i32, %arg9: i32, %arg10: i32) {
        %0 = arith.extui %arg3 : i32 to i64
        %1 = arith.extui %arg4 : i32 to i64
        %c32_i64 = arith.constant 32 : i64
        %2 = arith.shli %1, %c32_i64 : i64
        %3 = arith.ori %0, %2 : i64
        %4 = arith.index_castui %3 {stream.values = [0 : index]} : i64 to index
        %5 = arith.extui %arg5 : i32 to i64
        %6 = arith.extui %arg6 : i32 to i64
        %c32_i64_0 = arith.constant 32 : i64
        %7 = arith.shli %6, %c32_i64_0 : i64
        %8 = arith.ori %5, %7 : i64
        %9 = arith.index_castui %8 {stream.values = [0 : index]} : i64 to index
        %10 = arith.extui %arg7 : i32 to i64
        %11 = arith.extui %arg8 : i32 to i64
        %c32_i64_1 = arith.constant 32 : i64
        %12 = arith.shli %11, %c32_i64_1 : i64
        %13 = arith.ori %10, %12 : i64
        %14 = arith.index_castui %13 {stream.alignment = 64 : index, stream.values = [64 : index]} : i64 to index
        %15 = arith.extui %arg9 : i32 to i64
        %16 = arith.extui %arg10 : i32 to i64
        %c32_i64_2 = arith.constant 32 : i64
        %17 = arith.shli %16, %c32_i64_2 : i64
        %18 = arith.ori %15, %17 : i64
        %19 = arith.index_castui %18 {stream.values = [0 : index]} : i64 to index
        %cst = arith.constant 0.000000e+00 : f32
        %c0 = arith.constant 0 : index
        %20 = stream.binding.subspan %arg0[%4] : !stream.binding -> !flow.dispatch.tensor<readonly:tensor<1x4xf32>>
        %21 = stream.binding.subspan %arg1[%9] : !stream.binding -> !flow.dispatch.tensor<readonly:tensor<4x3xf32>>
        %22 = stream.binding.subspan %arg1[%14] : !stream.binding -> !flow.dispatch.tensor<readonly:tensor<1x3xf32>>
        %23 = stream.binding.subspan %arg2[%19] : !stream.binding -> !flow.dispatch.tensor<writeonly:tensor<1x3xf32>>
        %24 = flow.dispatch.tensor.load %20, offsets = [0, 0], sizes = [1, 4], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<1x4xf32>> -> tensor<1x4xf32>
        %25 = flow.dispatch.tensor.load %21, offsets = [0, 0], sizes = [4, 3], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<4x3xf32>> -> tensor<4x3xf32>
        %26 = flow.dispatch.tensor.load %22, offsets = [0, 0], sizes = [1, 3], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<1x3xf32>> -> tensor<1x3xf32>
        %27 = tensor.empty() : tensor<1x3xf32>
        %28 = linalg.fill ins(%cst : f32) outs(%27 : tensor<1x3xf32>) -> tensor<1x3xf32>
        %29 = linalg.matmul ins(%24, %25 : tensor<1x4xf32>, tensor<4x3xf32>) outs(%28 : tensor<1x3xf32>) -> tensor<1x3xf32>
        %30 = linalg.generic {indexing_maps = [#map, #map, #map], iterator_types = ["parallel", "parallel"]} ins(%29, %26 : tensor<1x3xf32>, tensor<1x3xf32>) outs(%27 : tensor<1x3xf32>) {
        ^bb0(%in: f32, %in_3: f32, %out: f32):
          %31 = math.absf %in : f32
          %32 = arith.addf %in, %in_3 : f32
          %33 = arith.addf %32, %31 : f32
          linalg.yield %33 : f32
        } -> tensor<1x3xf32>
        flow.dispatch.tensor.store %30, %23, offsets = [0, 0], sizes = [1, 3], strides = [1, 1] : tensor<1x3xf32> -> !flow.dispatch.tensor<writeonly:tensor<1x3xf32>>
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
    %c128 = arith.constant 128 : index
    %c64 = arith.constant 64 : index
    %_params.weight__timepoint = util.global.load @_params.weight__timepoint : !stream.timepoint
    %_params.weight = util.global.load @_params.weight : !stream.resource<constant>
    hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input 0") shape([%c4]) type(%c553648160_i32) encoding(%c1_i32)
    %0 = stream.tensor.import %arg0 : !hal.buffer_view -> tensor<4xf32> in !stream.resource<external>{%c16}
    %result, %result_timepoint = stream.resource.alloca uninitialized await(%_params.weight__timepoint) => !stream.resource<external>{%c12} => !stream.timepoint
    %c0_0 = arith.constant 0 : index
    %c0_i64 = arith.constant 0 : i64
    %c0_i32 = arith.constant 0 : i32
    %c32_i64 = arith.constant 32 : i64
    %c0_i64_1 = arith.constant 0 : i64
    %c0_i32_2 = arith.constant 0 : i32
    %c0_i64_3 = arith.constant 0 : i64
    %c0_i32_4 = arith.constant 0 : i32
    %c32_i64_5 = arith.constant 32 : i64
    %c0_i64_6 = arith.constant 0 : i64
    %c0_i32_7 = arith.constant 0 : i32
    %c64_i64 = arith.constant 64 : i64
    %c64_i32 = arith.constant 64 : i32
    %c32_i64_8 = arith.constant 32 : i64
    %c0_i64_9 = arith.constant 0 : i64
    %c0_i32_10 = arith.constant 0 : i32
    %c0_i64_11 = arith.constant 0 : i64
    %c0_i32_12 = arith.constant 0 : i32
    %c32_i64_13 = arith.constant 32 : i64
    %c0_i64_14 = arith.constant 0 : i64
    %c0_i32_15 = arith.constant 0 : i32
    %1 = stream.cmd.execute await(%result_timepoint) => with(%0 as %arg1: !stream.resource<external>{%c16}, %_params.weight as %arg2: !stream.resource<constant>{%c128}, %result as %arg3: !stream.resource<external>{%c12}) {
      stream.cmd.dispatch @main_dispatch_0::@main_dispatch_0_matmul_1x3x4_f32(%c0_i32, %c0_i32_2, %c0_i32_4, %c0_i32_7, %c64_i32, %c0_i32_10, %c0_i32_12, %c0_i32_15 : i32, i32, i32, i32, i32, i32, i32, i32) {
        ro %arg1[%c0_0 for %c16] : !stream.resource<external>{%c16},
        ro %arg2[%c0_0 for %c128] : !stream.resource<constant>{%c128},
        wo %arg3[%c0_0 for %c12] : !stream.resource<external>{%c12}
      }
    } => !stream.timepoint
    %2 = stream.timepoint.await %1 => %result : !stream.resource<external>{%c12}
    %3 = stream.tensor.export %2 : tensor<3xf32> in !stream.resource<external>{%c12} -> !hal.buffer_view
    return %3 : !hal.buffer_view
  }
}


