
#executable_target_cuda_nvptx_fb = #hal.executable.target<"cuda", "cuda-nvptx-fb", {target_arch = "sm_75"}>
#map = affine_map<()[s0, s1] -> ((s0 ceildiv 128) * (s1 ceildiv 32))>
#pipeline_layout = #hal.pipeline.layout<push_constants = 4, sets = [<0, bindings = [<0, storage_buffer, ReadOnly>, <1, storage_buffer>]>]>
#translation = #iree_codegen.translation_info<LLVMGPUMatmulSimt>
#device_target_cuda = #hal.device.target<"cuda", {executable_targets = [#executable_target_cuda_nvptx_fb], legacy_sync}>
module @LinearModule attributes {hal.device.targets = [#device_target_cuda]} {
  hal.executable private @main_dispatch_0 {
    hal.executable.variant public @cuda_nvptx_fb target(#executable_target_cuda_nvptx_fb) {
      hal.executable.export public @main_dispatch_0_matmul_DxDxD_f32 ordinal(0) layout(#pipeline_layout) attributes {translation_info = #translation, workgroup_size = [32 : index, 8 : index, 1 : index]} {
      ^bb0(%arg0: !hal.device, %arg1: index, %arg2: index):
        %c1 = arith.constant 1 : index
        %0 = affine.apply #map()[%arg2, %arg1]
        hal.return %0, %c1, %c1 : index, index, index
      }
      builtin.module {
        llvm.func @main_dispatch_0_matmul_DxDxD_f32(%arg0: !llvm.ptr<1> {llvm.align = 16 : i32, llvm.noalias, llvm.readonly}, %arg1: !llvm.ptr<1> {llvm.align = 16 : i32, llvm.noalias}, %arg2: i32, %arg3: i32, %arg4: i32, %arg5: i32) {
          %0 = llvm.mlir.constant(63 : index) : i64
          %1 = llvm.mlir.constant(1 : i64) : i64
          %2 = llvm.mlir.constant(8 : index) : i64
          %3 = llvm.mlir.constant(-128 : index) : i64
          %4 = llvm.mlir.constant(-32 : index) : i64
          %5 = llvm.mlir.constant(-1 : index) : i64
          %6 = llvm.mlir.constant(128 : index) : i64
          %7 = llvm.mlir.constant(32 : index) : i64
          %8 = llvm.mlir.constant(0 : index) : i64
          %9 = llvm.mlir.constant(1 : index) : i64
          %10 = llvm.mlir.constant(32 : i64) : i64
          %11 = llvm.mlir.constant(0.000000e+00 : f32) : f32
          %12 = llvm.zext %arg2 : i32 to i64
          %13 = llvm.zext %arg3 : i32 to i64
          %14 = llvm.shl %13, %10  : i64
          %15 = llvm.or %12, %14  : i64
          %16 = llvm.zext %arg4 : i32 to i64
          %17 = llvm.zext %arg5 : i32 to i64
          %18 = llvm.shl %17, %10  : i64
          %19 = llvm.or %16, %18  : i64
          %20 = llvm.mul %19, %1  : i64
          %21 = llvm.ptrtoint %arg0 : !llvm.ptr<1> to i64
          %22 = llvm.and %21, %0  : i64
          %23 = llvm.icmp "eq" %22, %8 : i64
          "llvm.intr.assume"(%23) : (i1) -> ()
          %24 = llvm.ptrtoint %arg1 : !llvm.ptr<1> to i64
          %25 = llvm.and %24, %0  : i64
          %26 = llvm.icmp "eq" %25, %8 : i64
          "llvm.intr.assume"(%26) : (i1) -> ()
          %27 = nvvm.read.ptx.sreg.ctaid.x : i32
          %28 = llvm.sext %27 : i32 to i64
          %29 = llvm.icmp "sle" %19, %8 : i64
          %30 = llvm.sub %8, %19  : i64
          %31 = llvm.sub %19, %9  : i64
          %32 = llvm.select %29, %30, %31 : i1, i64
          %33 = llvm.sdiv %32, %6  : i64
          %34 = llvm.sub %8, %33  : i64
          %35 = llvm.add %33, %9  : i64
          %36 = llvm.select %29, %34, %35 : i1, i64
          %37 = llvm.icmp "slt" %28, %8 : i64
          %38 = llvm.sub %5, %28  : i64
          %39 = llvm.select %37, %38, %28 : i1, i64
          %40 = llvm.sdiv %39, %36  : i64
          %41 = llvm.sub %5, %40  : i64
          %42 = llvm.select %37, %41, %40 : i1, i64
          %43 = llvm.mul %42, %4  : i64
          %44 = llvm.add %15, %43  : i64
          %45 = llvm.icmp "sgt" %44, %7 : i64
          %46 = llvm.select %45, %7, %44 : i1, i64
          %47 = llvm.srem %28, %36  : i64
          %48 = llvm.icmp "slt" %47, %8 : i64
          %49 = llvm.add %47, %36  : i64
          %50 = llvm.select %48, %49, %47 : i1, i64
          %51 = llvm.mul %50, %3  : i64
          %52 = llvm.add %19, %51  : i64
          %53 = llvm.icmp "sgt" %52, %6 : i64
          %54 = llvm.select %53, %6, %52 : i1, i64
          %55 = nvvm.read.ptx.sreg.tid.x : i32
          %56 = llvm.sext %55 : i32 to i64
          %57 = nvvm.read.ptx.sreg.tid.y : i32
          %58 = llvm.sext %57 : i32 to i64
          %59 = llvm.icmp "sle" %46, %8 : i64
          %60 = llvm.sub %8, %46  : i64
          %61 = llvm.sub %46, %9  : i64
          %62 = llvm.select %59, %60, %61 : i1, i64
          %63 = llvm.sdiv %62, %2  : i64
          %64 = llvm.sub %8, %63  : i64
          %65 = llvm.add %63, %9  : i64
          %66 = llvm.select %59, %64, %65 : i1, i64
          %67 = llvm.mul %58, %66  : i64
          %68 = llvm.sub %46, %67  : i64
          %69 = llvm.icmp "slt" %68, %66 : i64
          %70 = llvm.select %69, %68, %66 : i1, i64
          %71 = llvm.icmp "slt" %70, %8 : i64
          %72 = llvm.select %71, %8, %70 : i1, i64
          %73 = llvm.icmp "sle" %54, %8 : i64
          %74 = llvm.sub %8, %54  : i64
          %75 = llvm.sub %54, %9  : i64
          %76 = llvm.select %73, %74, %75 : i1, i64
          %77 = llvm.sdiv %76, %7  : i64
          %78 = llvm.sub %8, %77  : i64
          %79 = llvm.add %77, %9  : i64
          %80 = llvm.select %73, %78, %79 : i1, i64
          %81 = llvm.mul %56, %80  : i64
          %82 = llvm.sub %54, %81  : i64
          %83 = llvm.icmp "slt" %82, %80 : i64
          %84 = llvm.select %83, %82, %80 : i1, i64
          %85 = llvm.icmp "slt" %84, %8 : i64
          %86 = llvm.select %85, %8, %84 : i1, i64
          %87 = llvm.mul %42, %7  : i64
          %88 = llvm.add %87, %67  : i64
          %89 = llvm.mul %50, %6  : i64
          %90 = llvm.add %89, %81  : i64
          llvm.br ^bb1(%8 : i64)
        ^bb1(%91: i64):  // 2 preds: ^bb0, ^bb5
          %92 = llvm.icmp "slt" %91, %72 : i64
          llvm.cond_br %92, ^bb2, ^bb6(%8 : i64)
        ^bb2:  // pred: ^bb1
          %93 = llvm.add %88, %91  : i64
          llvm.br ^bb3(%8 : i64)
        ^bb3(%94: i64):  // 2 preds: ^bb2, ^bb4
          %95 = llvm.icmp "slt" %94, %86 : i64
          llvm.cond_br %95, ^bb4, ^bb5
        ^bb4:  // pred: ^bb3
          %96 = llvm.add %90, %94  : i64
          %97 = llvm.mul %93, %20  : i64
          %98 = llvm.add %97, %96  : i64
          %99 = llvm.getelementptr %arg1[%98] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
          llvm.store %11, %99 : f32, !llvm.ptr<1>
          %100 = llvm.add %94, %9  : i64
          llvm.br ^bb3(%100 : i64)
        ^bb5:  // pred: ^bb3
          %101 = llvm.add %91, %9  : i64
          llvm.br ^bb1(%101 : i64)
        ^bb6(%102: i64):  // 2 preds: ^bb1, ^bb12
          %103 = llvm.icmp "slt" %102, %19 : i64
          llvm.cond_br %103, ^bb7(%8 : i64), ^bb13
        ^bb7(%104: i64):  // 2 preds: ^bb6, ^bb11
          %105 = llvm.icmp "slt" %104, %72 : i64
          llvm.cond_br %105, ^bb8, ^bb12
        ^bb8:  // pred: ^bb7
          %106 = llvm.add %88, %104  : i64
          llvm.br ^bb9(%8 : i64)
        ^bb9(%107: i64):  // 2 preds: ^bb8, ^bb10
          %108 = llvm.icmp "slt" %107, %86 : i64
          llvm.cond_br %108, ^bb10, ^bb11
        ^bb10:  // pred: ^bb9
          %109 = llvm.mul %106, %20  : i64
          %110 = llvm.add %109, %102  : i64
          %111 = llvm.getelementptr %arg0[%110] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
          %112 = llvm.load %111 : !llvm.ptr<1> -> f32
          %113 = llvm.add %90, %107  : i64
          %114 = llvm.mul %102, %20  : i64
          %115 = llvm.add %114, %113  : i64
          %116 = llvm.getelementptr %arg0[%115] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
          %117 = llvm.load %116 : !llvm.ptr<1> -> f32
          %118 = llvm.add %109, %113  : i64
          %119 = llvm.getelementptr %arg1[%118] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
          %120 = llvm.load %119 : !llvm.ptr<1> -> f32
          %121 = llvm.fmul %112, %117  : f32
          %122 = llvm.fadd %120, %121  : f32
          llvm.store %122, %119 : f32, !llvm.ptr<1>
          %123 = llvm.add %107, %9  : i64
          llvm.br ^bb9(%123 : i64)
        ^bb11:  // pred: ^bb9
          %124 = llvm.add %104, %9  : i64
          llvm.br ^bb7(%124 : i64)
        ^bb12:  // pred: ^bb7
          %125 = llvm.add %102, %9  : i64
          llvm.br ^bb6(%125 : i64)
        ^bb13:  // pred: ^bb6
          llvm.return
        }
      }
    }
  }
  func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
    %c32_i64 = arith.constant 32 : i64
    %c4 = arith.constant 4 : index
    %c0 = arith.constant 0 : index
    %c1_i32 = arith.constant 1 : i32
    %c553648160_i32 = arith.constant 553648160 : i32
    %0 = hal.buffer_view.dim<%arg0 : !hal.buffer_view>[0] : index
    %1 = hal.buffer_view.dim<%arg0 : !hal.buffer_view>[1] : index
    hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input 0") shape([%0, %1]) type(%c553648160_i32) encoding(%c1_i32)
    %2 = arith.muli %0, %c4 : index
    %3 = arith.muli %2, %1 : index
    %buffer = hal.buffer_view.buffer<%arg0 : !hal.buffer_view> : !hal.buffer
    %device = hal.ex.shared_device : !hal.device
    %allocator = hal.device.allocator<%device : !hal.device> : !hal.allocator
    hal.buffer.assert<%buffer : !hal.buffer> message("tensor") allocator(%allocator : !hal.allocator) minimum_length(%3) type(DeviceVisible) usage("TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage")
    %c-1_i64 = arith.constant -1 : i64
    %4 = util.null : !hal.fence
    %fence = hal.fence.create device(%device : !hal.device) flags("None") : !hal.fence
    %c0_i64 = arith.constant 0 : i64
    %c-1_i32 = arith.constant -1 : i32
    %status = hal.fence.await until([%4]) timeout_millis(%c-1_i32) : i32
    %transient_buffer = hal.device.queue.alloca<%device : !hal.device> affinity(%c-1_i64) wait(%4) signal(%fence) pool(%c0_i64) type("DeviceVisible|DeviceLocal") usage("TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage") : !hal.buffer{%3}
    %status_0 = hal.fence.await until([%fence]) timeout_millis(%c-1_i32) : i32
    %5 = arith.index_castui %0 : index to i64
    %6 = arith.trunci %5 : i64 to i32
    %7 = arith.shrui %5, %c32_i64 : i64
    %8 = arith.trunci %7 : i64 to i32
    %9 = arith.index_castui %1 : index to i64
    %10 = arith.trunci %9 : i64 to i32
    %11 = arith.shrui %9, %c32_i64 : i64
    %12 = arith.trunci %11 : i64 to i32
    %cmd = hal.command_buffer.create device(%device : !hal.device) mode("OneShot|AllowInlineExecution") categories("Transfer|Dispatch") : !hal.command_buffer
    %13 = hal.command_buffer.device<%cmd : !hal.command_buffer> : !hal.device
    %ok, %value = hal.device.query<%13 : !hal.device> key("hal.executable.format" :: "cuda-nvptx-fb") : i1, i1 = false
    %c-1 = arith.constant -1 : index
    %14 = arith.select %value, %c0, %c-1 : index
    scf.index_switch %14 
    case 0 {
      %pipeline_layout = hal.pipeline_layout.lookup device(%13 : !hal.device) layout(#pipeline_layout) : !hal.pipeline_layout
      hal.command_buffer.push_constants<%cmd : !hal.command_buffer> layout(%pipeline_layout : !hal.pipeline_layout) offset(0) values([%6, %8, %10, %12]) : i32, i32, i32, i32
      %c1 = arith.constant 1 : index
      hal.command_buffer.push_descriptor_set<%cmd : !hal.command_buffer> layout(%pipeline_layout : !hal.pipeline_layout)[%c0] bindings([
        %c0 = (%buffer : !hal.buffer)[%c0, %3], 
        %c1 = (%transient_buffer : !hal.buffer)[%c0, %3]
      ])
      %15 = affine.apply #map()[%1, %0]
      hal.command_buffer.dispatch.symbol<%cmd : !hal.command_buffer> target(@main_dispatch_0::@cuda_nvptx_fb::@main_dispatch_0_matmul_DxDxD_f32) workgroups([%15, %c1, %c1])
      scf.yield
    }
    default {
    }
    hal.command_buffer.execution_barrier<%cmd : !hal.command_buffer> source("Dispatch|Transfer|CommandRetire") target("CommandIssue|Dispatch|Transfer") flags("None")
    hal.command_buffer.finalize<%cmd : !hal.command_buffer>
    %fence_1 = hal.fence.create device(%device : !hal.device) flags("None") : !hal.fence
    %status_2 = hal.fence.await until([%fence]) timeout_millis(%c-1_i32) : i32
    hal.device.queue.execute<%device : !hal.device> affinity(%c-1_i64) wait(%4) signal(%fence_1) commands([%cmd])
    %status_3 = hal.fence.await until([%fence_1]) timeout_millis(%c-1_i32) : i32
    util.status.check_ok %status_3, "failed to wait on timepoint"
    %view = hal.buffer_view.create buffer(%transient_buffer : !hal.buffer)[%c0, %3] shape([%0, %1]) type(%c553648160_i32) encoding(%c1_i32) : !hal.buffer_view
    return %view : !hal.buffer_view
  }
}


