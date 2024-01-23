
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
    %c0_i32 = arith.constant 0 : i32
    %c-1_i64 = arith.constant -1 : i64
    %c0 = arith.constant 0 : index
    %c128 = arith.constant 128 : index
    %c0_i64 = arith.constant 0 : i64
    %0 = util.null : !hal.fence
    %buffer_cst = util.buffer.constant {alignment = 64 : index} : !util.buffer = #composite_of_128b
    %device = hal.ex.shared_device : !hal.device
    %allocator = hal.device.allocator<%device : !hal.device> : !hal.allocator
    %did_import, %mapped = hal.allocator.import<%allocator : !hal.allocator> source(%buffer_cst : !util.buffer)[%c0, %c128] affinity(%c-1_i64) type("DeviceVisible|DeviceLocal") usage("TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage|SharingImmutable") : i1, !hal.buffer
    cf.cond_br %did_import, ^bb2(%0, %mapped : !hal.fence, !hal.buffer), ^bb1
  ^bb1:  // pred: ^bb0
    %buffer = hal.allocator.allocate<%allocator : !hal.allocator> affinity(%c-1_i64) type("DeviceVisible|DeviceLocal") usage("TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage|SharingImmutable") : !hal.buffer{%c128}
    %memory_file = hal.ex.file.from_memory device(%device : !hal.device) affinity(%c-1_i64) access(Read) buffer(%buffer_cst : !util.buffer)[%c0 for %c128] flags(%c0_i32) : !hal.file
    %fence = hal.fence.create device(%device : !hal.device) flags("None") : !hal.fence
    hal.device.queue.read<%device : !hal.device> affinity(%c-1_i64) wait(%0) signal(%fence) source(%memory_file : !hal.file)[%c0_i64] target(%buffer : !hal.buffer)[%c0] length(%c128) flags(0)
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
          %42 = llvm.insertelement %41, %35[%4 : i32] : vector<1xf32>
          %43 = llvm.shufflevector %42, %35 [0] : vector<1xf32> 
          %44 = llvm.mul %10, %11  : i64
          %45 = llvm.add %44, %26  : i64
          %46 = llvm.getelementptr %arg1[%45] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
          %47 = llvm.load %46 : !llvm.ptr<1> -> f32
          %48 = llvm.insertelement %47, %35[%4 : i32] : vector<1xf32>
          %49 = llvm.shufflevector %48, %35 [0] : vector<1xf32> 
          %50 = llvm.mul %11, %11  : i64
          %51 = llvm.add %50, %26  : i64
          %52 = llvm.getelementptr %arg1[%51] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
          %53 = llvm.load %52 : !llvm.ptr<1> -> f32
          %54 = llvm.insertelement %53, %35[%4 : i32] : vector<1xf32>
          %55 = llvm.shufflevector %54, %35 [0] : vector<1xf32> 
          %56 = llvm.extractelement %30[%3 : i64] : vector<4xf32>
          %57 = llvm.insertelement %56, %35[%4 : i32] : vector<1xf32>
          %58 = llvm.shufflevector %57, %35 [0] : vector<1xf32> 
          %59 = llvm.intr.fmuladd(%58, %37, %7)  : (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>
          %60 = llvm.extractelement %30[%2 : i64] : vector<4xf32>
          %61 = llvm.insertelement %60, %35[%4 : i32] : vector<1xf32>
          %62 = llvm.shufflevector %61, %35 [0] : vector<1xf32> 
          %63 = llvm.intr.fmuladd(%62, %43, %59)  : (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>
          %64 = llvm.extractelement %30[%1 : i64] : vector<4xf32>
          %65 = llvm.insertelement %64, %35[%4 : i32] : vector<1xf32>
          %66 = llvm.shufflevector %65, %35 [0] : vector<1xf32> 
          %67 = llvm.intr.fmuladd(%66, %49, %63)  : (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>
          %68 = llvm.extractelement %30[%0 : i64] : vector<4xf32>
          %69 = llvm.insertelement %68, %35[%4 : i32] : vector<1xf32>
          %70 = llvm.shufflevector %69, %35 [0] : vector<1xf32> 
          %71 = llvm.intr.fmuladd(%70, %55, %67)  : (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>
          %72 = llvm.getelementptr %18[%32] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
          %73 = llvm.load %72 : !llvm.ptr<1> -> f32
          %74 = llvm.insertelement %73, %35[%4 : i32] : vector<1xf32>
          %75 = llvm.shufflevector %74, %35 [0] : vector<1xf32> 
          %76 = llvm.extractelement %71[%3 : i64] : vector<1xf32>
          %77 = llvm.call @__nv_fabsf(%76) : (f32) -> f32
          %78 = llvm.insertelement %77, %7[%3 : i64] : vector<1xf32>
          %79 = llvm.intr.fmuladd(%58, %37, %75)  : (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>
          %80 = llvm.intr.fmuladd(%62, %43, %79)  : (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>
          %81 = llvm.intr.fmuladd(%66, %49, %80)  : (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>
          %82 = llvm.intr.fmuladd(%70, %55, %81)  : (vector<1xf32>, vector<1xf32>, vector<1xf32>) -> vector<1xf32>
          %83 = llvm.fadd %82, %78  : vector<1xf32>
          %84 = llvm.extractelement %83[%3 : i64] : vector<1xf32>
          %85 = llvm.getelementptr %arg2[%32] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
          llvm.store %84, %85 : f32, !llvm.ptr<1>
          llvm.return
        }
      }
    }
  }
  func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
    %c0 = arith.constant 0 : index
    %c4 = arith.constant 4 : index
    %c1_i32 = arith.constant 1 : i32
    %c553648160_i32 = arith.constant 553648160 : i32
    %c12 = arith.constant 12 : index
    %c16 = arith.constant 16 : index
    %c128 = arith.constant 128 : index
    %c-1_i64 = arith.constant -1 : i64
    %c0_i64 = arith.constant 0 : i64
    %c-1_i32 = arith.constant -1 : i32
    %c-1 = arith.constant -1 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c3 = arith.constant 3 : index
    %_params.weight__timepoint = util.global.load @_params.weight__timepoint : !hal.fence
    %_params.weight = util.global.load @_params.weight : !hal.buffer
    hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input 0") shape([%c4]) type(%c553648160_i32) encoding(%c1_i32)
    %buffer = hal.buffer_view.buffer<%arg0 : !hal.buffer_view> : !hal.buffer
    %device = hal.ex.shared_device : !hal.device
    %allocator = hal.device.allocator<%device : !hal.device> : !hal.allocator
    hal.buffer.assert<%buffer : !hal.buffer> message("tensor") allocator(%allocator : !hal.allocator) minimum_length(%c16) type(DeviceVisible) usage("TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage")
    %fence = hal.fence.create device(%device : !hal.device) flags("None") : !hal.fence
    %status = hal.fence.await until([%_params.weight__timepoint]) timeout_millis(%c-1_i32) : i32
    %0 = util.null : !hal.fence
    %transient_buffer = hal.device.queue.alloca<%device : !hal.device> affinity(%c-1_i64) wait(%0) signal(%fence) pool(%c0_i64) type("DeviceVisible|DeviceLocal") usage("TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage") : !hal.buffer{%c12}
    %status_0 = hal.fence.await until([%fence]) timeout_millis(%c-1_i32) : i32
    %cmd = hal.command_buffer.create device(%device : !hal.device) mode("OneShot|AllowInlineExecution") categories("Transfer|Dispatch") : !hal.command_buffer
    %ok, %value = hal.device.query<%device : !hal.device> key("hal.executable.format" :: "cuda-nvptx-fb") : i1, i1 = false
    %1 = arith.select %value, %c0, %c-1 : index
    scf.index_switch %1 
    case 0 {
      %pipeline_layout = hal.pipeline_layout.lookup device(%device : !hal.device) layout(#pipeline_layout) : !hal.pipeline_layout
      hal.command_buffer.push_descriptor_set<%cmd : !hal.command_buffer> layout(%pipeline_layout : !hal.pipeline_layout)[%c0] bindings([
        %c0 = (%buffer : !hal.buffer)[%c0, %c16], 
        %c1 = (%_params.weight : !hal.buffer)[%c0, %c128], 
        %c2 = (%transient_buffer : !hal.buffer)[%c0, %c12]
      ])
      %2 = hal.command_buffer.device<%cmd : !hal.command_buffer> : !hal.device
      %exe = hal.executable.lookup device(%2 : !hal.device) executable(@main_dispatch_0) : !hal.executable
      hal.command_buffer.dispatch<%cmd : !hal.command_buffer> target(%exe : !hal.executable)[0] workgroups([%c3, %c1, %c1])
      scf.yield
    }
    default {
    }
    hal.command_buffer.execution_barrier<%cmd : !hal.command_buffer> source("Dispatch|Transfer|CommandRetire") target("CommandIssue|Dispatch|Transfer") flags("None")
    hal.command_buffer.finalize<%cmd : !hal.command_buffer>
    %fence_1 = hal.fence.create device(%device : !hal.device) flags("None") : !hal.fence
    %status_2 = hal.fence.await until([%fence]) timeout_millis(%c-1_i32) : i32
    hal.device.queue.execute<%device : !hal.device> affinity(%c-1_i64) wait(%0) signal(%fence_1) commands([%cmd])
    %status_3 = hal.fence.await until([%fence_1]) timeout_millis(%c-1_i32) : i32
    util.status.check_ok %status_3, "failed to wait on timepoint"
    %view = hal.buffer_view.create buffer(%transient_buffer : !hal.buffer)[%c0, %c12] shape([%c3]) type(%c553648160_i32) encoding(%c1_i32) : !hal.buffer_view
    return %view : !hal.buffer_view
  }
}


