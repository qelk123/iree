
func.func @main_dispatch_0_matmul_1x3x4_f32() {
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %c3 = arith.constant 3 : index
  %cst = arith.constant dense<0.000000e+00> : vector<1x1xf32>
  %c64 = arith.constant 64 : index
  %0 = hal.interface.binding.subspan set(0) binding(0) type(storage_buffer) alignment(64) offset(%c0) flags(ReadOnly) : memref<1x4xf32, #gpu.address_space<global>>
  memref.assume_alignment %0, 64 : memref<1x4xf32, #gpu.address_space<global>>
  %1 = hal.interface.binding.subspan set(0) binding(1) type(storage_buffer) alignment(64) offset(%c0) flags(ReadOnly) : memref<4x3xf32, #gpu.address_space<global>>
  memref.assume_alignment %1, 64 : memref<4x3xf32, #gpu.address_space<global>>
  %2 = hal.interface.binding.subspan set(0) binding(1) type(storage_buffer) alignment(64) offset(%c64) flags(ReadOnly) : memref<1x3xf32, strided<[3, 1], offset: 16>, #gpu.address_space<global>>
  memref.assume_alignment %2, 64 : memref<1x3xf32, strided<[3, 1], offset: 16>, #gpu.address_space<global>>
  %3 = hal.interface.binding.subspan set(0) binding(2) type(storage_buffer) alignment(64) offset(%c0) : memref<1x3xf32, #gpu.address_space<global>>
  memref.assume_alignment %3, 64 : memref<1x3xf32, #gpu.address_space<global>>
  %workgroup_id_x = hal.interface.workgroup.id[0] : index
  %4 = vector.load %0[%c0, %c0] : memref<1x4xf32, #gpu.address_space<global>>, vector<4xf32>
  %5 = memref.load %1[%c0, %workgroup_id_x] : memref<4x3xf32, #gpu.address_space<global>>
  %6 = vector.broadcast %5 : f32 to vector<1xf32>
  %7 = memref.load %1[%c1, %workgroup_id_x] : memref<4x3xf32, #gpu.address_space<global>>
  %8 = vector.broadcast %7 : f32 to vector<1xf32>
  %9 = memref.load %1[%c2, %workgroup_id_x] : memref<4x3xf32, #gpu.address_space<global>>
  %10 = vector.broadcast %9 : f32 to vector<1xf32>
  %11 = memref.load %1[%c3, %workgroup_id_x] : memref<4x3xf32, #gpu.address_space<global>>
  %12 = vector.broadcast %11 : f32 to vector<1xf32>
  %13 = vector.extract %4[0] : f32 from vector<4xf32>
  %14 = vector.splat %13 : vector<1xf32>
  %15 = vector.extract %cst[0] : vector<1xf32> from vector<1x1xf32>
  %16 = vector.fma %14, %6, %15 : vector<1xf32>
  %17 = vector.extract %4[1] : f32 from vector<4xf32>
  %18 = vector.splat %17 : vector<1xf32>
  %19 = vector.fma %18, %8, %16 : vector<1xf32>
  %20 = vector.extract %4[2] : f32 from vector<4xf32>
  %21 = vector.splat %20 : vector<1xf32>
  %22 = vector.fma %21, %10, %19 : vector<1xf32>
  %23 = vector.extract %4[3] : f32 from vector<4xf32>
  %24 = vector.splat %23 : vector<1xf32>
  %25 = vector.fma %24, %12, %22 : vector<1xf32>
  %26 = vector.insert %25, %cst [0] : vector<1xf32> into vector<1x1xf32>
  %27 = memref.load %2[%c0, %workgroup_id_x] : memref<1x3xf32, strided<[3, 1], offset: 16>, #gpu.address_space<global>>
  %28 = vector.broadcast %27 : f32 to vector<1xf32>
  %29 = math.absf %26 : vector<1x1xf32>
  %30 = vector.extract %4[0] : f32 from vector<4xf32>
  %31 = vector.splat %30 : vector<1xf32>
  %32 = vector.fma %31, %6, %28 : vector<1xf32>
  %33 = vector.extract %4[1] : f32 from vector<4xf32>
  %34 = vector.splat %33 : vector<1xf32>
  %35 = vector.fma %34, %8, %32 : vector<1xf32>
  %36 = vector.extract %4[2] : f32 from vector<4xf32>
  %37 = vector.splat %36 : vector<1xf32>
  %38 = vector.fma %37, %10, %35 : vector<1xf32>
  %39 = vector.extract %4[3] : f32 from vector<4xf32>
  %40 = vector.splat %39 : vector<1xf32>
  %41 = vector.fma %40, %12, %38 : vector<1xf32>
  %42 = vector.insert %41, %cst [0] : vector<1xf32> into vector<1x1xf32>
  %43 = arith.addf %42, %29 : vector<1x1xf32>
  %44 = vector.extract %43[0, 0] : f32 from vector<1x1xf32>
  memref.store %44, %3[%c0, %workgroup_id_x] : memref<1x3xf32, #gpu.address_space<global>>
  return
}

