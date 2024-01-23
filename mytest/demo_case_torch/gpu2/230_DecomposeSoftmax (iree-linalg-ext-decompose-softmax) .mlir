
func.func @main_dispatch_0_matmul_DxDxD_f32() {
  %c32_i64 = arith.constant 32 : i64
  %cst = arith.constant 0.000000e+00 : f32
  %c0 = arith.constant 0 : index
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
  %14 = flow.dispatch.workload.ordinal %8, 0 : index
  %15 = flow.dispatch.workload.ordinal %13, 1 : index
  %16 = hal.interface.binding.subspan set(0) binding(0) type(storage_buffer) alignment(64) offset(%c0) flags(ReadOnly) : !flow.dispatch.tensor<readonly:tensor<?x?xf32>>{%14, %15}
  %17 = hal.interface.binding.subspan set(0) binding(1) type(storage_buffer) alignment(64) offset(%c0) : !flow.dispatch.tensor<writeonly:tensor<?x?xf32>>{%14, %15}
  %18 = flow.dispatch.tensor.load %16, offsets = [0, 0], sizes = [%14, %15], strides = [1, 1] : !flow.dispatch.tensor<readonly:tensor<?x?xf32>>{%14, %15} -> tensor<?x?xf32>
  %19 = tensor.empty(%14, %15) : tensor<?x?xf32>
  %20 = linalg.fill ins(%cst : f32) outs(%19 : tensor<?x?xf32>) -> tensor<?x?xf32>
  %21 = linalg.matmul ins(%18, %18 : tensor<?x?xf32>, tensor<?x?xf32>) outs(%20 : tensor<?x?xf32>) -> tensor<?x?xf32>
  flow.dispatch.tensor.store %21, %17, offsets = [0, 0], sizes = [%14, %15], strides = [1, 1] : tensor<?x?xf32> -> !flow.dispatch.tensor<writeonly:tensor<?x?xf32>>{%14, %15}
  return
}

