
module {
  func.func @main_dispatch_0_matmul_DxDxD_f32() {
    %c8 = arith.constant 8 : index
    %c-128 = arith.constant -128 : index
    %c-32 = arith.constant -32 : index
    %c-1 = arith.constant -1 : index
    %c128 = arith.constant 128 : index
    %c32 = arith.constant 32 : index
    %c0 = arith.constant 0 : index
    %c1 = arith.constant 1 : index
    %c32_i64 = arith.constant 32 : i64
    %cst = arith.constant 0.000000e+00 : f32
    %0 = hal.interface.constant.load[0] : i32
    %1 = hal.interface.constant.load[1] : i32
    %2 = hal.interface.constant.load[2] : i32
    %3 = hal.interface.constant.load[3] : i32
    %4 = arith.extui %0 : i32 to i64
    %5 = arith.extui %1 : i32 to i64
    %6 = arith.shli %5, %c32_i64 : i64
    %7 = arith.ori %4, %6 : i64
    %8 = arith.index_castui %7 : i64 to index
    %9 = arith.extui %2 : i32 to i64
    %10 = arith.extui %3 : i32 to i64
    %11 = arith.shli %10, %c32_i64 : i64
    %12 = arith.ori %9, %11 : i64
    %13 = arith.index_castui %12 : i64 to index
    %14 = hal.interface.binding.subspan set(0) binding(0) type(storage_buffer) alignment(64) offset(%c0) flags(ReadOnly) : memref<?x?xf32, #gpu.address_space<global>>{%8, %13}
    memref.assume_alignment %14, 64 : memref<?x?xf32, #gpu.address_space<global>>
    %15 = hal.interface.binding.subspan set(0) binding(1) type(storage_buffer) alignment(64) offset(%c0) : memref<?x?xf32, #gpu.address_space<global>>{%8, %13}
    memref.assume_alignment %15, 64 : memref<?x?xf32, #gpu.address_space<global>>
    %workgroup_id_x = hal.interface.workgroup.id[0] : index
    %16 = arith.cmpi sle, %13, %c0 : index
    %17 = arith.subi %c0, %13 : index
    %18 = arith.subi %13, %c1 : index
    %19 = arith.select %16, %17, %18 : index
    %20 = arith.divsi %19, %c128 : index
    %21 = arith.subi %c0, %20 : index
    %22 = arith.addi %20, %c1 : index
    %23 = arith.select %16, %21, %22 : index
    %24 = arith.cmpi slt, %workgroup_id_x, %c0 : index
    %25 = arith.subi %c-1, %workgroup_id_x : index
    %26 = arith.select %24, %25, %workgroup_id_x : index
    %27 = arith.divsi %26, %23 : index
    %28 = arith.subi %c-1, %27 : index
    %29 = arith.select %24, %28, %27 : index
    %30 = arith.muli %29, %c-32 : index
    %31 = arith.addi %8, %30 : index
    %32 = arith.cmpi sgt, %31, %c32 : index
    %33 = arith.select %32, %c32, %31 : index
    %34 = arith.remsi %workgroup_id_x, %23 : index
    %35 = arith.cmpi slt, %34, %c0 : index
    %36 = arith.addi %34, %23 : index
    %37 = arith.select %35, %36, %34 : index
    %38 = arith.muli %37, %c-128 : index
    %39 = arith.addi %13, %38 : index
    %40 = arith.cmpi sgt, %39, %c128 : index
    %41 = arith.select %40, %c128, %39 : index
    %42 = gpu.thread_id  x
    %43 = gpu.thread_id  y
    %44 = arith.cmpi sle, %33, %c0 : index
    %45 = arith.subi %c0, %33 : index
    %46 = arith.subi %33, %c1 : index
    %47 = arith.select %44, %45, %46 : index
    %48 = arith.divsi %47, %c8 : index
    %49 = arith.subi %c0, %48 : index
    %50 = arith.addi %48, %c1 : index
    %51 = arith.select %44, %49, %50 : index
    %52 = arith.muli %43, %51 : index
    %53 = arith.subi %33, %52 : index
    %54 = arith.cmpi slt, %53, %51 : index
    %55 = arith.select %54, %53, %51 : index
    %56 = arith.cmpi slt, %55, %c0 : index
    %57 = arith.select %56, %c0, %55 : index
    %58 = arith.cmpi sle, %41, %c0 : index
    %59 = arith.subi %c0, %41 : index
    %60 = arith.subi %41, %c1 : index
    %61 = arith.select %58, %59, %60 : index
    %62 = arith.divsi %61, %c32 : index
    %63 = arith.subi %c0, %62 : index
    %64 = arith.addi %62, %c1 : index
    %65 = arith.select %58, %63, %64 : index
    %66 = arith.muli %42, %65 : index
    %67 = arith.subi %41, %66 : index
    %68 = arith.cmpi slt, %67, %65 : index
    %69 = arith.select %68, %67, %65 : index
    %70 = arith.cmpi slt, %69, %c0 : index
    %71 = arith.select %70, %c0, %69 : index
    %72 = arith.muli %29, %c32 : index
    %73 = arith.addi %72, %52 : index
    %74 = arith.muli %37, %c128 : index
    %75 = arith.addi %74, %66 : index
    scf.for %arg0 = %c0 to %57 step %c1 {
      %76 = affine.apply affine_map<()[s0, s1] -> (s0 + s1)>()[%73, %arg0]
      scf.for %arg1 = %c0 to %71 step %c1 {
        %77 = affine.apply affine_map<()[s0, s1] -> (s0 + s1)>()[%75, %arg1]
        memref.store %cst, %15[%76, %77] : memref<?x?xf32, #gpu.address_space<global>>
      }
    }
    scf.for %arg0 = %c0 to %13 step %c1 {
      scf.for %arg1 = %c0 to %57 step %c1 {
        %76 = affine.apply affine_map<()[s0, s1] -> (s0 + s1)>()[%73, %arg1]
        scf.for %arg2 = %c0 to %71 step %c1 {
          %77 = memref.load %14[%76, %arg0] : memref<?x?xf32, #gpu.address_space<global>>
          %78 = affine.apply affine_map<()[s0, s1] -> (s0 + s1)>()[%75, %arg2]
          %79 = memref.load %14[%arg0, %78] : memref<?x?xf32, #gpu.address_space<global>>
          %80 = memref.load %15[%76, %78] : memref<?x?xf32, #gpu.address_space<global>>
          %81 = arith.mulf %77, %79 : f32
          %82 = arith.addf %80, %81 : f32
          memref.store %82, %15[%76, %78] : memref<?x?xf32, #gpu.address_space<global>>
        }
      }
    }
    return
  }
}

