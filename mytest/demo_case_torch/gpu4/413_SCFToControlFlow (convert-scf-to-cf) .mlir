
util.initializer {
  %c-1 = arith.constant -1 : index
  %c0 = arith.constant 0 : index
  %_device_query_0 = util.global.load @_device_query_0 : i1
  %device = hal.ex.shared_device : !hal.device
  %0 = arith.select %_device_query_0, %c0, %c-1 : index
  %1 = arith.index_cast %0 : index to i32
  cf.switch %1 : i32, [
    default: ^bb2,
    0: ^bb1
  ]
^bb1:  // pred: ^bb0
  %_pipeline_layout_0 = util.global.load @_pipeline_layout_0 : !hal.pipeline_layout
  %exe = hal.executable.create device(%device : !hal.device) target(@main_dispatch_0::@cuda_nvptx_fb) layouts([%_pipeline_layout_0]) : !hal.executable
  cf.br ^bb3(%exe : !hal.executable)
^bb2:  // pred: ^bb0
  %2 = util.null : !hal.executable
  cf.br ^bb3(%2 : !hal.executable)
^bb3(%3: !hal.executable):  // 2 preds: ^bb1, ^bb2
  util.global.store %3, @_executable_main_dispatch_0 : !hal.executable
  util.initializer.return
}

