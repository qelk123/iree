
hal.executable.variant public @cuda_nvptx_fb target(<"cuda", "cuda-nvptx-fb", {target_arch = "sm_75"}>) {
  hal.executable.export public @main_dispatch_0_matmul_1x3x4_f32 ordinal(0) layout(#hal.pipeline.layout<push_constants = 0, sets = [<0, bindings = [<0, storage_buffer, ReadOnly>, <1, storage_buffer, ReadOnly>, <2, storage_buffer>]>]>) attributes {translation_info = #iree_codegen.translation_info<LLVMGPUMatmulSimt>, workgroup_size = [1 : index, 3 : index, 1 : index]} {
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

