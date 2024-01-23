
func.func @main_dispatch_0_matmul_1x3x4_f32() {
  %cst = arith.constant dense<0.000000e+00> : vector<1xf32>
  %c0 = arith.constant 0 : index
  %c1 = arith.constant 1 : index
  %c2 = arith.constant 2 : index
  %c3 = arith.constant 3 : index
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
  %15 = vector.fma %14, %6, %cst : vector<1xf32>
  %16 = vector.extract %4[1] : f32 from vector<4xf32>
  %17 = vector.splat %16 : vector<1xf32>
  %18 = vector.fma %17, %8, %15 : vector<1xf32>
  %19 = vector.extract %4[2] : f32 from vector<4xf32>
  %20 = vector.splat %19 : vector<1xf32>
  %21 = vector.fma %20, %10, %18 : vector<1xf32>
  %22 = vector.extract %4[3] : f32 from vector<4xf32>
  %23 = vector.splat %22 : vector<1xf32>
  %24 = vector.fma %23, %12, %21 : vector<1xf32>
  %25 = vector.broadcast %24 : vector<1xf32> to vector<1x1xf32>
  %26 = memref.load %2[%c0, %workgroup_id_x] : memref<1x3xf32, strided<[3, 1], offset: 16>, #gpu.address_space<global>>
  %27 = vector.broadcast %26 : f32 to vector<1xf32>
  %28 = math.absf %25 : vector<1x1xf32>
  %29 = vector.fma %14, %6, %27 : vector<1xf32>
  %30 = vector.fma %17, %8, %29 : vector<1xf32>
  %31 = vector.fma %20, %10, %30 : vector<1xf32>
  %32 = vector.fma %23, %12, %31 : vector<1xf32>
  %33 = vector.broadcast %32 : vector<1xf32> to vector<1x1xf32>
  %34 = arith.addf %33, %28 : vector<1x1xf32>
  %35 = vector.extract %34[0, 0] : f32 from vector<1x1xf32>
  memref.store %35, %3[%c0, %workgroup_id_x] : memref<1x3xf32, #gpu.address_space<global>>
  return
}

