
hal.executable private @main_dispatch_0 {
  hal.executable.variant public @cuda_nvptx_fb target(<"cuda", "cuda-nvptx-fb", {target_arch = "sm_75"}>) {
    hal.executable.export public @main_dispatch_0_matmul_DxDxD_f32 ordinal(0) layout(#hal.pipeline.layout<push_constants = 4, sets = [<0, bindings = [<0, storage_buffer, ReadOnly>, <1, storage_buffer>]>]>) attributes {translation_info = #iree_codegen.translation_info<LLVMGPUMatmulSimt>, workgroup_size = [32 : index, 8 : index, 1 : index]} {
    ^bb0(%arg0: !hal.device, %arg1: index, %arg2: index):
      %c1 = arith.constant 1 : index
      %0 = affine.apply affine_map<()[s0, s1] -> ((s0 ceildiv 128) * (s1 ceildiv 32))>()[%arg2, %arg1]
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
        %24 = llvm.mul %19, %1  : i64
        %25 = llvm.ptrtoint %arg1 : !llvm.ptr<1> to i64
        %26 = llvm.and %25, %0  : i64
        %27 = llvm.icmp "eq" %26, %8 : i64
        "llvm.intr.assume"(%27) : (i1) -> ()
        %28 = nvvm.read.ptx.sreg.ctaid.x : i32
        %29 = llvm.sext %28 : i32 to i64
        %30 = llvm.icmp "sle" %19, %8 : i64
        %31 = llvm.sub %8, %19  : i64
        %32 = llvm.sub %19, %9  : i64
        %33 = llvm.select %30, %31, %32 : i1, i64
        %34 = llvm.sdiv %33, %6  : i64
        %35 = llvm.sub %8, %34  : i64
        %36 = llvm.add %34, %9  : i64
        %37 = llvm.select %30, %35, %36 : i1, i64
        %38 = llvm.icmp "slt" %29, %8 : i64
        %39 = llvm.sub %5, %29  : i64
        %40 = llvm.select %38, %39, %29 : i1, i64
        %41 = llvm.sdiv %40, %37  : i64
        %42 = llvm.sub %5, %41  : i64
        %43 = llvm.select %38, %42, %41 : i1, i64
        %44 = llvm.mul %43, %4  : i64
        %45 = llvm.add %15, %44  : i64
        %46 = llvm.icmp "sgt" %45, %7 : i64
        %47 = llvm.select %46, %7, %45 : i1, i64
        %48 = llvm.srem %29, %37  : i64
        %49 = llvm.icmp "slt" %48, %8 : i64
        %50 = llvm.add %48, %37  : i64
        %51 = llvm.select %49, %50, %48 : i1, i64
        %52 = llvm.mul %51, %3  : i64
        %53 = llvm.add %19, %52  : i64
        %54 = llvm.icmp "sgt" %53, %6 : i64
        %55 = llvm.select %54, %6, %53 : i1, i64
        %56 = nvvm.read.ptx.sreg.tid.x : i32
        %57 = llvm.sext %56 : i32 to i64
        %58 = nvvm.read.ptx.sreg.tid.y : i32
        %59 = llvm.sext %58 : i32 to i64
        %60 = llvm.icmp "sle" %47, %8 : i64
        %61 = llvm.sub %8, %47  : i64
        %62 = llvm.sub %47, %9  : i64
        %63 = llvm.select %60, %61, %62 : i1, i64
        %64 = llvm.sdiv %63, %2  : i64
        %65 = llvm.sub %8, %64  : i64
        %66 = llvm.add %64, %9  : i64
        %67 = llvm.select %60, %65, %66 : i1, i64
        %68 = llvm.mul %59, %67  : i64
        %69 = llvm.sub %47, %68  : i64
        %70 = llvm.icmp "slt" %69, %67 : i64
        %71 = llvm.select %70, %69, %67 : i1, i64
        %72 = llvm.icmp "slt" %71, %8 : i64
        %73 = llvm.select %72, %8, %71 : i1, i64
        %74 = llvm.icmp "sle" %55, %8 : i64
        %75 = llvm.sub %8, %55  : i64
        %76 = llvm.sub %55, %9  : i64
        %77 = llvm.select %74, %75, %76 : i1, i64
        %78 = llvm.sdiv %77, %7  : i64
        %79 = llvm.sub %8, %78  : i64
        %80 = llvm.add %78, %9  : i64
        %81 = llvm.select %74, %79, %80 : i1, i64
        %82 = llvm.mul %57, %81  : i64
        %83 = llvm.sub %55, %82  : i64
        %84 = llvm.icmp "slt" %83, %81 : i64
        %85 = llvm.select %84, %83, %81 : i1, i64
        %86 = llvm.icmp "slt" %85, %8 : i64
        %87 = llvm.select %86, %8, %85 : i1, i64
        %88 = llvm.mul %43, %7  : i64
        %89 = llvm.add %88, %68  : i64
        %90 = llvm.mul %51, %6  : i64
        %91 = llvm.add %90, %82  : i64
        llvm.br ^bb1(%8 : i64)
      ^bb1(%92: i64):  // 2 preds: ^bb0, ^bb5
        %93 = llvm.icmp "slt" %92, %73 : i64
        llvm.cond_br %93, ^bb2, ^bb6(%8 : i64)
      ^bb2:  // pred: ^bb1
        %94 = llvm.add %89, %92  : i64
        llvm.br ^bb3(%8 : i64)
      ^bb3(%95: i64):  // 2 preds: ^bb2, ^bb4
        %96 = llvm.icmp "slt" %95, %87 : i64
        llvm.cond_br %96, ^bb4, ^bb5
      ^bb4:  // pred: ^bb3
        %97 = llvm.add %91, %95  : i64
        %98 = llvm.mul %94, %24  : i64
        %99 = llvm.add %98, %97  : i64
        %100 = llvm.getelementptr %arg1[%99] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
        llvm.store %11, %100 : f32, !llvm.ptr<1>
        %101 = llvm.add %95, %9  : i64
        llvm.br ^bb3(%101 : i64)
      ^bb5:  // pred: ^bb3
        %102 = llvm.add %92, %9  : i64
        llvm.br ^bb1(%102 : i64)
      ^bb6(%103: i64):  // 2 preds: ^bb1, ^bb12
        %104 = llvm.icmp "slt" %103, %19 : i64
        llvm.cond_br %104, ^bb7(%8 : i64), ^bb13
      ^bb7(%105: i64):  // 2 preds: ^bb6, ^bb11
        %106 = llvm.icmp "slt" %105, %73 : i64
        llvm.cond_br %106, ^bb8, ^bb12
      ^bb8:  // pred: ^bb7
        %107 = llvm.add %89, %105  : i64
        llvm.br ^bb9(%8 : i64)
      ^bb9(%108: i64):  // 2 preds: ^bb8, ^bb10
        %109 = llvm.icmp "slt" %108, %87 : i64
        llvm.cond_br %109, ^bb10, ^bb11
      ^bb10:  // pred: ^bb9
        %110 = llvm.mul %107, %20  : i64
        %111 = llvm.add %110, %103  : i64
        %112 = llvm.getelementptr %arg0[%111] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
        %113 = llvm.load %112 : !llvm.ptr<1> -> f32
        %114 = llvm.add %91, %108  : i64
        %115 = llvm.mul %103, %20  : i64
        %116 = llvm.add %115, %114  : i64
        %117 = llvm.getelementptr %arg0[%116] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
        %118 = llvm.load %117 : !llvm.ptr<1> -> f32
        %119 = llvm.mul %107, %24  : i64
        %120 = llvm.add %119, %114  : i64
        %121 = llvm.getelementptr %arg1[%120] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
        %122 = llvm.load %121 : !llvm.ptr<1> -> f32
        %123 = llvm.fmul %113, %118  : f32
        %124 = llvm.fadd %122, %123  : f32
        %125 = llvm.mul %107, %24  : i64
        %126 = llvm.add %125, %114  : i64
        %127 = llvm.getelementptr %arg1[%126] : (!llvm.ptr<1>, i64) -> !llvm.ptr<1>, f32
        llvm.store %124, %127 : f32, !llvm.ptr<1>
        %128 = llvm.add %108, %9  : i64
        llvm.br ^bb9(%128 : i64)
      ^bb11:  // pred: ^bb9
        %129 = llvm.add %105, %9  : i64
        llvm.br ^bb7(%129 : i64)
      ^bb12:  // pred: ^bb7
        %130 = llvm.add %103, %9  : i64
        llvm.br ^bb6(%130 : i64)
      ^bb13:  // pred: ^bb6
        llvm.return
      }
    }
  }
}

