
#executable_target_cuda_nvptx_fb = #hal.executable.target<"cuda", "cuda-nvptx-fb", {target_arch = "sm_75"}>
#pipeline_layout = #hal.pipeline.layout<push_constants = 4, sets = [<0, bindings = [<0, storage_buffer, ReadOnly>, <1, storage_buffer>]>]>
#translation = #iree_codegen.translation_info<LLVMGPUMatmulSimt>
#device_target_cuda = #hal.device.target<"cuda", {executable_targets = [#executable_target_cuda_nvptx_fb], legacy_sync}>
module @LinearModule attributes {hal.device.targets = [#device_target_cuda]} {
  util.global private @_device_query_0 : i1
  util.global private @_descriptor_set_layout_0 : !hal.descriptor_set_layout
  util.global private @_pipeline_layout_0 : !hal.pipeline_layout
  util.global private @_executable_main_dispatch_0 : !hal.executable
  util.initializer {
    %device = hal.ex.shared_device : !hal.device
    %ok, %value = hal.device.query<%device : !hal.device> key("hal.executable.format" :: "cuda-nvptx-fb") : i1, i1 = false
    util.global.store %value, @_device_query_0 : i1
    %device_0 = hal.ex.shared_device : !hal.device
    %descriptor_set_layout = hal.descriptor_set_layout.create device(%device_0 : !hal.device) flags("None") bindings([#hal.descriptor_set.binding<0, storage_buffer, ReadOnly>, #hal.descriptor_set.binding<1, storage_buffer>]) : !hal.descriptor_set_layout
    util.global.store %descriptor_set_layout, @_descriptor_set_layout_0 : !hal.descriptor_set_layout
    %_descriptor_set_layout_0 = util.global.load @_descriptor_set_layout_0 : !hal.descriptor_set_layout
    %device_1 = hal.ex.shared_device : !hal.device
    %pipeline_layout = hal.pipeline_layout.create device(%device_1 : !hal.device) push_constants(4) layouts([%_descriptor_set_layout_0]) : !hal.pipeline_layout
    util.global.store %pipeline_layout, @_pipeline_layout_0 : !hal.pipeline_layout
    %c-1 = arith.constant -1 : index
    %c0 = arith.constant 0 : index
    %_device_query_0 = util.global.load @_device_query_0 : i1
    %device_2 = hal.ex.shared_device : !hal.device
    %0 = arith.select %_device_query_0, %c0, %c-1 : index
    %1 = arith.index_cast %0 : index to i32
    cf.switch %1 : i32, [
      default: ^bb2,
      0: ^bb1
    ]
  ^bb1:  // pred: ^bb0
    %_pipeline_layout_0 = util.global.load @_pipeline_layout_0 : !hal.pipeline_layout
    %exe = hal.executable.create device(%device_2 : !hal.device) target(@main_dispatch_0::@cuda_nvptx_fb) layouts([%_pipeline_layout_0]) : !hal.executable
    cf.br ^bb3(%exe : !hal.executable)
  ^bb2:  // pred: ^bb0
    %2 = util.null : !hal.executable
    cf.br ^bb3(%2 : !hal.executable)
  ^bb3(%3: !hal.executable):  // 2 preds: ^bb1, ^bb2
    util.global.store %3, @_executable_main_dispatch_0 : !hal.executable
    cf.br ^bb4
  ^bb4:  // pred: ^bb3
    util.initializer.return
  }
  hal.executable private @main_dispatch_0 {
    hal.executable.variant public @cuda_nvptx_fb target(#executable_target_cuda_nvptx_fb) {
      hal.executable.export public @main_dispatch_0_matmul_DxDxD_f32 ordinal(0) layout(#pipeline_layout) attributes {translation_info = #translation, workgroup_size = [32 : index, 8 : index, 1 : index]} {
      ^bb0(%arg0: !hal.device, %arg1: index, %arg2: index):
        %c1 = arith.constant 1 : index
        %c128 = arith.constant 128 : index
        %c0 = arith.constant 0 : index
        %c1_0 = arith.constant 1 : index
        %0 = arith.cmpi sle, %arg2, %c0 : index
        %1 = arith.subi %c0, %arg2 : index
        %2 = arith.subi %arg2, %c1_0 : index
        %3 = arith.select %0, %1, %2 : index
        %4 = arith.divsi %3, %c128 : index
        %5 = arith.subi %c0, %4 : index
        %6 = arith.addi %4, %c1_0 : index
        %7 = arith.select %0, %5, %6 : index
        %c32 = arith.constant 32 : index
        %c0_1 = arith.constant 0 : index
        %c1_2 = arith.constant 1 : index
        %8 = arith.cmpi sle, %arg1, %c0_1 : index
        %9 = arith.subi %c0_1, %arg1 : index
        %10 = arith.subi %arg1, %c1_2 : index
        %11 = arith.select %8, %9, %10 : index
        %12 = arith.divsi %11, %c32 : index
        %13 = arith.subi %c0_1, %12 : index
        %14 = arith.addi %12, %c1_2 : index
        %15 = arith.select %8, %13, %14 : index
        %16 = arith.muli %7, %15 : index
        hal.return %16, %c1, %c1 : index, index, index
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
    %c553648160_i32 = arith.constant 553648160 : i32
    %c1_i32 = arith.constant 1 : i32
    %c0 = arith.constant 0 : index
    %c4 = arith.constant 4 : index
    %c32_i64 = arith.constant 32 : i64
    %c-1_i64 = arith.constant -1 : i64
    %c0_i64 = arith.constant 0 : i64
    %c-1_i32 = arith.constant -1 : i32
    %c-1 = arith.constant -1 : index
    %c1 = arith.constant 1 : index
    %_device_query_0 = util.global.load @_device_query_0 : i1
    %0 = hal.buffer_view.dim<%arg0 : !hal.buffer_view>[0] : index
    %1 = hal.buffer_view.dim<%arg0 : !hal.buffer_view>[1] : index
    hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input 0") shape([%0, %1]) type(%c553648160_i32) encoding(%c1_i32)
    %2 = arith.muli %0, %c4 : index
    %3 = arith.muli %2, %1 : index
    %buffer = hal.buffer_view.buffer<%arg0 : !hal.buffer_view> : !hal.buffer
    %device = hal.ex.shared_device : !hal.device
    %allocator = hal.device.allocator<%device : !hal.device> : !hal.allocator
    hal.buffer.assert<%buffer : !hal.buffer> message("tensor") allocator(%allocator : !hal.allocator) minimum_length(%3) type(DeviceVisible) usage("TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage")
    %4 = util.null : !hal.fence
    %fence = hal.fence.create device(%device : !hal.device) flags("None") : !hal.fence
    %transient_buffer = hal.device.queue.alloca<%device : !hal.device> affinity(%c-1_i64) wait(%4) signal(%fence) pool(%c0_i64) type("DeviceVisible|DeviceLocal") usage("TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage") : !hal.buffer{%3}
    %status = hal.fence.await until([%fence]) timeout_millis(%c-1_i32) : i32
    %5 = arith.index_castui %0 : index to i64
    %6 = arith.trunci %5 : i64 to i32
    %7 = arith.shrui %5, %c32_i64 : i64
    %8 = arith.trunci %7 : i64 to i32
    %9 = arith.index_castui %1 : index to i64
    %10 = arith.trunci %9 : i64 to i32
    %11 = arith.shrui %9, %c32_i64 : i64
    %12 = arith.trunci %11 : i64 to i32
    %cmd = hal.command_buffer.create device(%device : !hal.device) mode("OneShot|AllowInlineExecution") categories("Transfer|Dispatch") : !hal.command_buffer
    %13 = arith.select %_device_query_0, %c0, %c-1 : index
    %14 = arith.index_cast %13 : index to i32
    cf.switch %14 : i32, [
      default: ^bb2,
      0: ^bb1
    ]
  ^bb1:  // pred: ^bb0
    %_pipeline_layout_0 = util.global.load @_pipeline_layout_0 : !hal.pipeline_layout
    hal.command_buffer.push_constants<%cmd : !hal.command_buffer> layout(%_pipeline_layout_0 : !hal.pipeline_layout) offset(0) values([%6, %8, %10, %12]) : i32, i32, i32, i32
    hal.command_buffer.push_descriptor_set<%cmd : !hal.command_buffer> layout(%_pipeline_layout_0 : !hal.pipeline_layout)[%c0] bindings([
      %c0 = (%buffer : !hal.buffer)[%c0, %3], 
      %c1 = (%transient_buffer : !hal.buffer)[%c0, %3]
    ])
    %c128 = arith.constant 128 : index
    %c0_0 = arith.constant 0 : index
    %c1_1 = arith.constant 1 : index
    %15 = arith.cmpi sle, %1, %c0_0 : index
    %16 = arith.subi %c0_0, %1 : index
    %17 = arith.subi %1, %c1_1 : index
    %18 = arith.select %15, %16, %17 : index
    %19 = arith.divsi %18, %c128 : index
    %20 = arith.subi %c0_0, %19 : index
    %21 = arith.addi %19, %c1_1 : index
    %22 = arith.select %15, %20, %21 : index
    %c32 = arith.constant 32 : index
    %c0_2 = arith.constant 0 : index
    %c1_3 = arith.constant 1 : index
    %23 = arith.cmpi sle, %0, %c0_2 : index
    %24 = arith.subi %c0_2, %0 : index
    %25 = arith.subi %0, %c1_3 : index
    %26 = arith.select %23, %24, %25 : index
    %27 = arith.divsi %26, %c32 : index
    %28 = arith.subi %c0_2, %27 : index
    %29 = arith.addi %27, %c1_3 : index
    %30 = arith.select %23, %28, %29 : index
    %31 = arith.muli %22, %30 : index
    %_executable_main_dispatch_0 = util.global.load @_executable_main_dispatch_0 : !hal.executable
    hal.command_buffer.dispatch<%cmd : !hal.command_buffer> target(%_executable_main_dispatch_0 : !hal.executable)[0] workgroups([%31, %c1, %c1])
    cf.br ^bb3
  ^bb2:  // pred: ^bb0
    cf.br ^bb3
  ^bb3:  // 2 preds: ^bb1, ^bb2
    hal.command_buffer.execution_barrier<%cmd : !hal.command_buffer> source("Dispatch|Transfer|CommandRetire") target("CommandIssue|Dispatch|Transfer") flags("None")
    hal.command_buffer.finalize<%cmd : !hal.command_buffer>
    %fence_4 = hal.fence.create device(%device : !hal.device) flags("None") : !hal.fence
    %status_5 = hal.fence.await until([%fence]) timeout_millis(%c-1_i32) : i32
    hal.device.queue.execute<%device : !hal.device> affinity(%c-1_i64) wait(%4) signal(%fence_4) commands([%cmd])
    %status_6 = hal.fence.await until([%fence_4]) timeout_millis(%c-1_i32) : i32
    util.status.check_ok %status_6, "failed to wait on timepoint"
    %view = hal.buffer_view.create buffer(%transient_buffer : !hal.buffer)[%c0, %3] shape([%0, %1]) type(%c553648160_i32) encoding(%c1_i32) : !hal.buffer_view
    return %view : !hal.buffer_view
  }
}


//
// Generated by LLVM NVPTX Back-End
//

.version 7.5
.target sm_75
.address_size 64

	// .globl	main_dispatch_0_matmul_DxDxD_f32

.visible .entry main_dispatch_0_matmul_DxDxD_f32(
	.param .u64 main_dispatch_0_matmul_DxDxD_f32_param_0,
	.param .u64 main_dispatch_0_matmul_DxDxD_f32_param_1,
	.param .u32 main_dispatch_0_matmul_DxDxD_f32_param_2,
	.param .u32 main_dispatch_0_matmul_DxDxD_f32_param_3,
	.param .u32 main_dispatch_0_matmul_DxDxD_f32_param_4,
	.param .u32 main_dispatch_0_matmul_DxDxD_f32_param_5
)
.maxntid 32, 8, 1
{
	.reg .pred 	%p<21>;
	.reg .b32 	%r<10>;
	.reg .f32 	%f<14>;
	.reg .b64 	%rd<165>;

	ld.param.u32 	%rd61, [main_dispatch_0_matmul_DxDxD_f32_param_2];
	ld.param.u32 	%rd62, [main_dispatch_0_matmul_DxDxD_f32_param_3];
	shl.b64 	%rd63, %rd62, 32;
	or.b64  	%rd1, %rd63, %rd61;
	ld.param.u32 	%rd2, [main_dispatch_0_matmul_DxDxD_f32_param_4];
	ld.param.u32 	%rd3, [main_dispatch_0_matmul_DxDxD_f32_param_5];
	shl.b64 	%rd64, %rd3, 32;
	or.b64  	%rd4, %rd64, %rd2;
	mov.u32 	%r1, %ctaid.x;
	cvt.u64.u32 	%rd5, %r1;
	setp.lt.s64 	%p1, %rd4, 1;
	neg.s64 	%rd65, %rd4;
	add.s64 	%rd66, %rd4, -1;
	selp.b64 	%rd67, %rd65, %rd66, %p1;
	shr.s64 	%rd68, %rd67, 63;
	shr.u64 	%rd69, %rd68, 57;
	add.s64 	%rd70, %rd67, %rd69;
	shr.s64 	%rd71, %rd70, 7;
	neg.s64 	%rd72, %rd71;
	add.s64 	%rd73, %rd71, 1;
	selp.b64 	%rd74, %rd72, %rd73, %p1;
	and.b64  	%rd75, %rd74, -4294967296;
	setp.ne.s64 	%p2, %rd75, 0;
	@%p2 bra 	$L__BB0_2;
	bra.uni 	$L__BB0_1;
$L__BB0_2:
	div.s64 	%rd148, %rd5, %rd74;
	bra.uni 	$L__BB0_3;
$L__BB0_1:
	cvt.u32.u64 	%r3, %rd74;
	cvt.u32.u64 	%r4, %rd5;
	div.u32 	%r5, %r4, %r3;
	cvt.u64.u32 	%rd148, %r5;
$L__BB0_3:
	ld.param.u64 	%rd60, [main_dispatch_0_matmul_DxDxD_f32_param_1];
	shl.b64 	%rd76, %rd148, 5;
	sub.s64 	%rd77, %rd1, %rd76;
	min.s64 	%rd78, %rd77, 32;
	mul.lo.s64 	%rd79, %rd148, %rd74;
	sub.s64 	%rd80, %rd5, %rd79;
	shl.b64 	%rd81, %rd80, 7;
	sub.s64 	%rd82, %rd4, %rd81;
	min.s64 	%rd83, %rd82, 128;
	mov.u32 	%r6, %tid.x;
	cvt.u64.u32 	%rd84, %r6;
	mov.u32 	%r7, %tid.y;
	cvt.u64.u32 	%rd85, %r7;
	setp.lt.s64 	%p3, %rd77, 1;
	neg.s64 	%rd86, %rd78;
	add.s64 	%rd87, %rd78, -1;
	selp.b64 	%rd88, %rd86, %rd87, %p3;
	shr.s64 	%rd89, %rd88, 63;
	shr.u64 	%rd90, %rd89, 61;
	add.s64 	%rd91, %rd88, %rd90;
	shr.s64 	%rd92, %rd91, 3;
	neg.s64 	%rd93, %rd92;
	add.s64 	%rd94, %rd92, 1;
	selp.b64 	%rd95, %rd93, %rd94, %p3;
	mul.lo.s64 	%rd96, %rd95, %rd85;
	sub.s64 	%rd97, %rd78, %rd96;
	min.s64 	%rd10, %rd97, %rd95;
	setp.lt.s64 	%p4, %rd82, 1;
	neg.s64 	%rd98, %rd83;
	add.s64 	%rd99, %rd83, -1;
	selp.b64 	%rd100, %rd98, %rd99, %p4;
	shr.s64 	%rd101, %rd100, 63;
	shr.u64 	%rd102, %rd101, 59;
	add.s64 	%rd103, %rd100, %rd102;
	shr.s64 	%rd104, %rd103, 5;
	neg.s64 	%rd105, %rd104;
	add.s64 	%rd106, %rd104, 1;
	selp.b64 	%rd107, %rd105, %rd106, %p4;
	mul.lo.s64 	%rd108, %rd107, %rd84;
	sub.s64 	%rd109, %rd83, %rd108;
	min.s64 	%rd11, %rd109, %rd107;
	add.s64 	%rd12, %rd96, %rd76;
	add.s64 	%rd13, %rd108, %rd81;
	setp.lt.s64 	%p5, %rd10, 1;
	mul.lo.s64 	%rd143, %rd12, %rd4;
	shl.b64 	%rd144, %rd13, 2;
	shl.b64 	%rd145, %rd3, 34;
	shl.b64 	%rd146, %rd2, 2;
	setp.lt.s64 	%p20, %rd11, 1;
	@%p5 bra 	$L__BB0_13;
	mov.u64 	%rd151, 0;
	and.b64  	%rd19, %rd11, 7;
	and.b64  	%rd15, %rd11, -8;
	shl.b64 	%rd112, %rd143, 2;
	add.s64 	%rd114, %rd112, %rd144;
	add.s64 	%rd149, %rd60, %rd114;
	add.s64 	%rd150, %rd149, 16;
	or.b64  	%rd17, %rd145, %rd146;
	setp.lt.u64 	%p7, %rd11, 8;
	mov.b32 	%r9, 0;
	bra.uni 	$L__BB0_5;
$L__BB0_12:
	add.s64 	%rd151, %rd151, 1;
	add.s64 	%rd150, %rd150, %rd17;
	add.s64 	%rd149, %rd149, %rd17;
	setp.eq.s64 	%p11, %rd10, %rd151;
	@%p11 bra 	$L__BB0_13;
$L__BB0_5:
	@%p20 bra 	$L__BB0_12;
	mov.u64 	%rd154, 0;
	@%p7 bra 	$L__BB0_9;
	mov.u64 	%rd154, 0;
	mov.u64 	%rd152, %rd150;
$L__BB0_8:
	st.global.u32 	[%rd152+-16], %r9;
	st.global.u32 	[%rd152+-12], %r9;
	st.global.u32 	[%rd152+-8], %r9;
	st.global.u32 	[%rd152+-4], %r9;
	st.global.u32 	[%rd152], %r9;
	st.global.u32 	[%rd152+4], %r9;
	st.global.u32 	[%rd152+8], %r9;
	st.global.u32 	[%rd152+12], %r9;
	add.s64 	%rd154, %rd154, 8;
	add.s64 	%rd152, %rd152, 32;
	setp.ne.s64 	%p8, %rd15, %rd154;
	@%p8 bra 	$L__BB0_8;
$L__BB0_9:
	setp.eq.s64 	%p9, %rd19, 0;
	@%p9 bra 	$L__BB0_12;
	shl.b64 	%rd119, %rd154, 2;
	add.s64 	%rd156, %rd149, %rd119;
	mov.u64 	%rd155, %rd19;
$L__BB0_11:
	.pragma "nounroll";
	st.global.u32 	[%rd156], %r9;
	add.s64 	%rd156, %rd156, 4;
	add.s64 	%rd155, %rd155, -1;
	setp.ne.s64 	%p10, %rd155, 0;
	@%p10 bra 	$L__BB0_11;
	bra.uni 	$L__BB0_12;
$L__BB0_13:
	@%p1 bra 	$L__BB0_25;
	ld.param.u64 	%rd59, [main_dispatch_0_matmul_DxDxD_f32_param_0];
	and.b64  	%rd20, %rd11, 1;
	and.b64  	%rd21, %rd11, -2;
	shl.b64 	%rd122, %rd143, 2;
	add.s64 	%rd124, %rd122, %rd144;
	add.s64 	%rd125, %rd124, %rd60;
	add.s64 	%rd22, %rd125, 4;
	or.b64  	%rd23, %rd145, %rd146;
	add.s64 	%rd128, %rd144, %rd59;
	add.s64 	%rd157, %rd128, 4;
	mov.u64 	%rd158, 0;
	setp.eq.s64 	%p15, %rd11, 1;
	setp.eq.s64 	%p17, %rd20, 0;
	bra.uni 	$L__BB0_15;
$L__BB0_24:
	add.s64 	%rd158, %rd158, 1;
	add.s64 	%rd157, %rd157, %rd23;
	setp.ne.s64 	%p19, %rd158, %rd4;
	@%p19 bra 	$L__BB0_15;
	bra.uni 	$L__BB0_25;
$L__BB0_15:
	@%p5 bra 	$L__BB0_24;
	shl.b64 	%rd130, %rd158, 2;
	add.s64 	%rd43, %rd59, %rd130;
	mul.lo.s64 	%rd131, %rd158, %rd4;
	shl.b64 	%rd132, %rd131, 2;
	add.s64 	%rd44, %rd59, %rd132;
	mov.u64 	%rd160, 0;
	mov.u64 	%rd159, %rd22;
	bra.uni 	$L__BB0_17;
$L__BB0_23:
	add.s64 	%rd160, %rd160, 1;
	add.s64 	%rd159, %rd159, %rd23;
	setp.ne.s64 	%p18, %rd10, %rd160;
	@%p18 bra 	$L__BB0_17;
	bra.uni 	$L__BB0_24;
$L__BB0_17:
	@%p20 bra 	$L__BB0_23;
	add.s64 	%rd134, %rd160, %rd12;
	mul.lo.s64 	%rd135, %rd134, %rd4;
	shl.b64 	%rd136, %rd135, 2;
	add.s64 	%rd137, %rd43, %rd136;
	ld.global.nc.f32 	%f1, [%rd137];
	mov.u64 	%rd164, 0;
	@%p15 bra 	$L__BB0_21;
	mov.u64 	%rd164, 0;
	mov.u64 	%rd161, %rd157;
	mov.u64 	%rd162, %rd159;
$L__BB0_20:
	ld.global.nc.f32 	%f2, [%rd161+-4];
	ld.global.f32 	%f3, [%rd162+-4];
	mul.rn.f32 	%f4, %f1, %f2;
	add.rn.f32 	%f5, %f3, %f4;
	st.global.f32 	[%rd162+-4], %f5;
	ld.global.nc.f32 	%f6, [%rd161];
	ld.global.f32 	%f7, [%rd162];
	mul.rn.f32 	%f8, %f1, %f6;
	add.rn.f32 	%f9, %f7, %f8;
	st.global.f32 	[%rd162], %f9;
	add.s64 	%rd164, %rd164, 2;
	add.s64 	%rd162, %rd162, 8;
	add.s64 	%rd161, %rd161, 8;
	setp.ne.s64 	%p16, %rd21, %rd164;
	@%p16 bra 	$L__BB0_20;
$L__BB0_21:
	@%p17 bra 	$L__BB0_23;
	add.s64 	%rd47, %rd60, %rd136;
	add.s64 	%rd139, %rd164, %rd13;
	shl.b64 	%rd140, %rd139, 2;
	add.s64 	%rd141, %rd44, %rd140;
	ld.global.nc.f32 	%f10, [%rd141];
	add.s64 	%rd142, %rd47, %rd140;
	ld.global.f32 	%f11, [%rd142];
	mul.rn.f32 	%f12, %f1, %f10;
	add.rn.f32 	%f13, %f11, %f12;
	st.global.f32 	[%rd142], %f13;
	bra.uni 	$L__BB0_23;
$L__BB0_25:
	ret;

}
