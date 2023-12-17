 module attributes {tf.versions = {bad_consumers = [], min_consumer = 0 : i32, producer = 27 : i32}} {
   func.func @main(%arg0: tensor<10xi32>, %arg1: tensor<10xi32>) -> tensor<10xi32> attributes {tf.entry_function = {control_outputs = "", inputs = "input0,input1", outputs = "Mul"}} {
     %3 = stablehlo.add %arg0, %arg1 : tensor<10xi32>
     %4 = stablehlo.add %arg0, %arg1 : tensor<10xi32>
     %0 = stablehlo.multiply %arg0, %3 : tensor<10xi32>
     %1 = stablehlo.multiply %arg0, %4 : tensor<10xi32>
     %2 = stablehlo.add %0, %1 : tensor<10xi32>
     return %2 : tensor<10xi32>
   }
 }