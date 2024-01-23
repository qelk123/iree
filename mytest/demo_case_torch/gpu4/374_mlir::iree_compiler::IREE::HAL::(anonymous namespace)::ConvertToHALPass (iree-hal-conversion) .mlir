
#composite_of_128b = #util.composite<128xi8, [
    dense<[[1.54099607, -0.293428898, -2.17878938], [0.568431258, -1.08452237, -1.39859545], [0.403346837, 0.838026344, -0.719257593], [-0.403343529, -0.596635341, 0.182036489]]> : tensor<4x3xf32>,
    dense<0> : vector<16xi8>,
    dense<[-0.856674611, 1.10060418, -1.07118738]> : tensor<3xf32>,
    dense<0> : vector<52xi8>,
]>
#executable_target_cuda_nvptx_fb = #hal.executable.target<"cuda", "cuda-nvptx-fb", {target_arch = "sm_75"}>
#pipeline_layout = #hal.pipeline.layout<push_constants = 0, sets = [<0, bindings = [<0, storage_buffer, ReadOnly>, <1, storage_buffer, ReadOnly>, <2, storage_buffer>]>]>
#translation = #iree_codegen.translation_info<LLVMGPUMatmulSimt>
#device_target_cuda = #hal.device.target<"cuda", {executable_targets = [#executable_target_cuda_nvptx_fb], legacy_sync}>
module @LinearModule attributes {hal.device.targets = [#device_target_cuda]} {
  util.global private mutable @_params.weight__timepoint : !hal.fence
  util.global private @_params.weight : !hal.buffer
  util.initializer {
    %0 = util.null : !hal.fence
    %c0_i64 = arith.constant 0 : i64
    %c128 = arith.constant 128 : index
    %c0 = arith.constant 0 : index
    %buffer_cst = util.buffer.constant {alignment = 64 : index} : !util.buffer = #composite_of_128b
    %device = hal.ex.shared_device : !hal.device
    %allocator = hal.device.allocator<%device : !hal.device> : !hal.allocator
    %c-1_i64 = arith.constant -1 : i64
    %did_import, %mapped = hal.allocator.import<%allocator : !hal.allocator> source(%buffer_cst : !util.buffer)[%c0, %c128] affinity(%c-1_i64) type("DeviceVisible|DeviceLocal") usage("TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage|SharingImmutable") : i1, !hal.buffer
    cf.cond_br %did_import, ^bb2(%0, %mapped : !hal.fence, !hal.buffer), ^bb1
  ^bb1:  // pred: ^bb0
    %device_0 = hal.ex.shared_device : !hal.device
    %allocator_1 = hal.device.allocator<%device_0 : !hal.device> : !hal.allocator
    %c-1_i64_2 = arith.constant -1 : i64
    %buffer = hal.allocator.allocate<%allocator_1 : !hal.allocator> affinity(%c-1_i64_2) type("DeviceVisible|DeviceLocal") usage("TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage|SharingImmutable") : !hal.buffer{%c128}
    %device_3 = hal.ex.shared_device : !hal.device
    %c-1_i64_4 = arith.constant -1 : i64
    %c0_i32 = arith.constant 0 : i32
    %memory_file = hal.ex.file.from_memory device(%device_3 : !hal.device) affinity(%c-1_i64_4) access(Read) buffer(%buffer_cst : !util.buffer)[%c0 for %c128] flags(%c0_i32) : !hal.file
    %device_5 = hal.ex.shared_device : !hal.device
    %c-1_i64_6 = arith.constant -1 : i64
    %fence = hal.fence.create device(%device_5 : !hal.device) flags("None") : !hal.fence
    hal.device.queue.read<%device_5 : !hal.device> affinity(%c-1_i64_6) wait(%0) signal(%fence) source(%memory_file : !hal.file)[%c0_i64] target(%buffer : !hal.buffer)[%c0] length(%c128) flags(0)
    cf.br ^bb2(%fence, %buffer : !hal.fence, !hal.buffer)
  ^bb2(%1: !hal.fence, %2: !hal.buffer):  // 2 preds: ^bb0, ^bb1
    util.global.store %2, @_params.weight : !hal.buffer
    util.global.store %1, @_params.weight__timepoint : !hal.fence
    util.initializer.return
  }
  hal.executable private @main_dispatch_0 {
    hal.executable.variant public @cuda_nvptx_fb target(#executable_target_cuda_nvptx_fb) {
      hal.executable.export public @main_dispatch_0_matmul_1x3x4_f32 ordinal(0) layout(#pipeline_layout) attributes {translation_info = #translation, workgroup_size = [1 : index, 3 : index, 1 : index]} {
      ^bb0(%arg0: !hal.device):
        %c3 = arith.constant 3 : index
        %c1 = arith.constant 1 : index
        hal.return %c3, %c1, %c1 : index, index, index
      }
      builtin.module {
        llvm.func @__nv_fabsf(f32) -> f32
        llvm.func @main_dispatch_0_matmul_1x3x4_f32(%arg0: !llvm.ptr<1> {llvm.align = 16 : i32, llvm.noalias, llvm.readonly}, %arg1: !llvm.ptr<1> {llvm.align = 16 : i32, llvm.noalias, llvm.readonly}, %arg2: !llvm.ptr<1> {llvm.align = 16 : i32, llvm.noalias}) {
          %0 = llvm.mlir.constant(3 : i64) : i64
          %1 = llvm.mlir.constant(2 : i64) : i64
          %2 = llvm.mlir.constant(1 : i64) : i64
          %3 = llvm.mlir.constant(0 : i64) : i64
          %4 = llvm.mlir.constant(0 : i32) : i32
          %5 = llvm.mlir.constant(63 : index) : i64
          %6 = llvm.mlir.constant(4 : index) : i64
          %7 = llvm.mlir.constant(dense<0.000000e+00> : vector<1xf32>) : vector<1xf32>
          %8 = llvm.mlir.constant(0 : index) : i64
          %9 = llvm.mlir.constant(1 : index) : i64
          %10 = llvm.mlir.constant(2 : index) : i64
          %11 = llvm.mlir.constant(3 : index) : i64
          %12 = llvm.ptrtoint %arg0 : !llvm.ptr<1> to i64
          %13 = llvm.and %12, %5  : i64
          %14 = llvm.icmp "eq" %13, %8 : i64
          "llvm.intr.assume"(%14) : (i1) -> ()
          %15 = llvm.ptrtoint %arg1 : !llvm.ptr<1> to i64
          %16 = llvm.and %15, %5  : i64
          %17 = llvm.icmp "eq" %16, %8 : i64
          "llvm.intr.assume"(%17) : (i1) -> ()
          %18 = llvm.getelementptr %arg1[16] : (!llvm.ptr<1>) -> !llvm.ptr<1>, f32
          %19 = llvm.ptrtoint %18 : !llvm.ptr<1> to i64
          %20 = llvm.and %19, %5  : i64
          %21 = llvm.icmp "eq" %20, %8 : i64
          "llvm.intr.assume"(%21) : (i1) -> ()
          %22 = llvm.ptrtoint %arg2 : !llvm.ptr<1> to i64
          %23 = llvm.and %22, %5  : i64
          %24 = llvm.icmp "eq" %23, %8 : i64
          "llvm.intr.assume"(%24) : (i1) -> ()
          %25 = nvvm.read.ptx.sreg.ctaid.x : i32
          %26 = llvm.sext %25 : i32 to i64
          %27 = llvm.mul %8, %6  : i64
          %28 = llvm.add %27, %8  : i64
          %29 = llvm.getelementptr %arg0[%28] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
          %30 = llvm.load %29 {alignment = 4 : i64} : !llvm.ptr<1> -> vector<4xf32>
          %31 = llvm.mul %8, %11  : i64
          %32 = llvm.add %31, %26  : i64
          %33 = llvm.getelementptr %arg1[%32] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
          %34 = llvm.load %33 : !llvm.ptr<1> -> f32
          %35 = llvm.mlir.undef : vector<1xf32>
          %36 = llvm.insertelement %34, %35[%4 : i32] : vector<1xf32>
          %37 = llvm.shufflevector %36, %35 [0] : vector<1xf32> 
          %38 = llvm.mul %9, %11  : i64
          %39 = llvm.add %38, %26  : i64
          %40 = llvm.getelementptr %arg1[%39] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
          %41 = llvm.load %40 : !llvm.ptr<1> -> f32
          %42 = llvm.mlir.undef : vector<1xf32>
          %43 = llvm.insertelement %41, %42[%4 : i32] : vector<1xf32>
          %44 = llvm.shufflevector %43, %42 [0] : vector<1xf32> 
          %45 = llvm.mul %10, %11  : i64
          %46 = llvm.add %45, %26  : i64
          %47 = llvm.getelementptr %arg1[%46] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
          %48 = llvm.load %47 : !llvm.ptr<1> -> f32
          %49 = llvm.mlir.undef : vector<1xf32>
          %50 = llvm.insertelement %48, %49[%4 : i32] : vector<1xf32>
          %51 = llvm.shufflevector %50, %49 [0] : vector<1xf32> 
          %52 = llvm.mul %11, %11  : i64
          %53 = llvm.add %52, %26  : i64
          %54 = llvm.getelementptr %arg1[%53] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
          %55 = llvm.load %54 : !llvm.ptr<1> -> f32
          %56 = llvm.mlir.undef : vector<1xf32>
          %57 = llvm.insertelement %55, %56[%4 : i32] : vector<1xf32>
          %58 = llvm.shufflevector %57, %56 [0] : vector<1xf32> 
          %59 = llvm.extractelement %30[%3 : i64] : vector<4xf32>
          %60 = llvm.mlir.undef : vector<1xf32>
          %61 = llvm.insertelement %59, %60[%4 : i32] : vector<1xf32>
          %62 = llvm.shufflevector %61, %60 [0] : vector<1xf32> 
          %63 = llvm.intr.fmuladd(%62, %37, %7)  : (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>
          %64 = llvm.extractelement %30[%2 : i64] : vector<4xf32>
          %65 = llvm.mlir.undef : vector<1xf32>
          %66 = llvm.insertelement %64, %65[%4 : i32] : vector<1xf32>
          %67 = llvm.shufflevector %66, %65 [0] : vector<1xf32> 
          %68 = llvm.intr.fmuladd(%67, %44, %63)  : (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>
          %69 = llvm.extractelement %30[%1 : i64] : vector<4xf32>
          %70 = llvm.mlir.undef : vector<1xf32>
          %71 = llvm.insertelement %69, %70[%4 : i32] : vector<1xf32>
          %72 = llvm.shufflevector %71, %70 [0] : vector<1xf32> 
          %73 = llvm.intr.fmuladd(%72, %51, %68)  : (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>
          %74 = llvm.extractelement %30[%0 : i64] : vector<4xf32>
          %75 = llvm.mlir.undef : vector<1xf32>
          %76 = llvm.insertelement %74, %75[%4 : i32] : vector<1xf32>
          %77 = llvm.shufflevector %76, %75 [0] : vector<1xf32> 
          %78 = llvm.intr.fmuladd(%77, %58, %73)  : (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>
          %79 = llvm.getelementptr %arg1[16] : (!llvm.ptr<1>) -> !llvm.ptr<1>, f32
          %80 = llvm.mul %8, %11  : i64
          %81 = llvm.add %80, %26  : i64
          %82 = llvm.getelementptr %79[%81] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
          %83 = llvm.load %82 : !llvm.ptr<1> -> f32
          %84 = llvm.mlir.undef : vector<1xf32>
          %85 = llvm.insertelement %83, %84[%4 : i32] : vector<1xf32>
          %86 = llvm.shufflevector %85, %84 [0] : vector<1xf32> 
          %87 = llvm.extractelement %78[%3 : i64] : vector<1xf32>
          %88 = llvm.call @__nv_fabsf(%87) : (f32) -> f32
          %89 = llvm.insertelement %88, %7[%3 : i64] : vector<1xf32>
          %90 = llvm.intr.fmuladd(%62, %37, %86)  : (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>
          %91 = llvm.intr.fmuladd(%67, %44, %90)  : (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>
          %92 = llvm.intr.fmuladd(%72, %51, %91)  : (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>
          %93 = llvm.intr.fmuladd(%77, %58, %92)  : (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>
          %94 = llvm.fadd %93, %89  : vector<1xf32>
          %95 = llvm.extractelement %94[%3 : i64] : vector<1xf32>
          %96 = llvm.mul %8, %11  : i64
          %97 = llvm.add %96, %26  : i64
          %98 = llvm.getelementptr %arg2[%97] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
          llvm.store %95, %98 : f32, !llvm.ptr<1>
          llvm.return
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
    %_params.weight__timepoint = util.global.load @_params.weight__timepoint : !hal.fence
    %_params.weight = util.global.load @_params.weight : !hal.buffer
    hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input 0") shape([%c4]) type(%c553648160_i32) encoding(%c1_i32)
    %buffer = hal.buffer_view.buffer<%arg0 : !hal.buffer_view> : !hal.buffer
    %device = hal.ex.shared_device : !hal.device
    %allocator = hal.device.allocator<%device : !hal.device> : !hal.allocator
    hal.buffer.assert<%buffer : !hal.buffer> message("tensor") allocator(%allocator : !hal.allocator) minimum_length(%c16) type(DeviceVisible) usage("TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage")
    %device_0 = hal.ex.shared_device : !hal.device
    %c-1_i64 = arith.constant -1 : i64
    %fence = hal.fence.create device(%device_0 : !hal.device) flags("None") : !hal.fence
    %c0_i64 = arith.constant 0 : i64
    %transient_buffer = hal.device.queue.alloca<%device_0 : !hal.device> affinity(%c-1_i64) wait(%_params.weight__timepoint) signal(%fence) pool(%c0_i64) type("DeviceVisible|DeviceLocal") usage("TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage") : !hal.buffer{%c12}
    %device_1 = hal.ex.shared_device : !hal.device
    %c-1_i64_2 = arith.constant -1 : i64
    %cmd = hal.command_buffer.create device(%device_1 : !hal.device) mode(OneShot) categories("Transfer|Dispatch") : !hal.command_buffer
    %0 = hal.command_buffer.device<%cmd : !hal.command_buffer> : !hal.device
    %ok, %value = hal.device.query<%0 : !hal.device> key("hal.executable.format" :: "cuda-nvptx-fb") : i1, i1 = false
    %c-1 = arith.constant -1 : index
    %c0_3 = arith.constant 0 : index
    %1 = arith.select %value, %c0_3, %c-1 : index
    scf.index_switch %1 
    case 0 {
      %pipeline_layout = hal.pipeline_layout.lookup device(%0 : !hal.device) layout(#pipeline_layout) : !hal.pipeline_layout
      %c0_8 = arith.constant 0 : index
      %c1 = arith.constant 1 : index
      %c2 = arith.constant 2 : index
      %c0_9 = arith.constant 0 : index
      hal.command_buffer.push_descriptor_set<%cmd : !hal.command_buffer> layout(%pipeline_layout : !hal.pipeline_layout)[%c0_9] bindings([
        %c0_8 = (%buffer : !hal.buffer)[%c0, %c16], 
        %c1 = (%_params.weight : !hal.buffer)[%c0, %c128], 
        %c2 = (%transient_buffer : !hal.buffer)[%c0, %c12]
      ])
      %c3_10 = arith.constant 3 : index
      %c1_11 = arith.constant 1 : index
      hal.command_buffer.dispatch.symbol<%cmd : !hal.command_buffer> target(@main_dispatch_0::@cuda_nvptx_fb::@main_dispatch_0_matmul_1x3x4_f32) workgroups([%c3_10, %c1_11, %c1_11])
      scf.yield
    }
    default {
    }
    hal.command_buffer.execution_barrier<%cmd : !hal.command_buffer> source("Dispatch|Transfer|CommandRetire") target("CommandIssue|Dispatch|Transfer") flags("None")
    hal.command_buffer.finalize<%cmd : !hal.command_buffer>
    %fence_4 = hal.fence.create device(%device_1 : !hal.device) flags("None") : !hal.fence
    hal.device.queue.execute<%device_1 : !hal.device> affinity(%c-1_i64_2) wait(%fence) signal(%fence_4) commands([%cmd])
    %c-1_i32 = arith.constant -1 : i32
    %status = hal.fence.await until([%fence_4]) timeout_millis(%c-1_i32) : i32
    util.status.check_ok %status, "failed to wait on timepoint"
    %c3 = arith.constant 3 : index
    %c0_5 = arith.constant 0 : index
    %c553648160_i32_6 = arith.constant 553648160 : i32
    %c1_i32_7 = arith.constant 1 : i32
    %view = hal.buffer_view.create buffer(%transient_buffer : !hal.buffer)[%c0_5, %c12] shape([%c3]) type(%c553648160_i32_6) encoding(%c1_i32_7) : !hal.buffer_view
    return %view : !hal.buffer_view
  }
}


