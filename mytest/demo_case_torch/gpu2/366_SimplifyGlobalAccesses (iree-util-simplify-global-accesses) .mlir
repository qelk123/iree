
util.initializer {
  %c0 = arith.constant 0 : index
  %c-1 = arith.constant -1 : index
  %device = hal.ex.shared_device : !hal.device
  %ok, %value = hal.device.query<%device : !hal.device> key("hal.executable.format" :: "cuda-nvptx-fb") : i1, i1 = false
  %descriptor_set_layout = hal.descriptor_set_layout.create device(%device : !hal.device) flags("None") bindings([#hal.descriptor_set.binding<0, storage_buffer, ReadOnly>, #hal.descriptor_set.binding<1, storage_buffer>]) : !hal.descriptor_set_layout
  %pipeline_layout = hal.pipeline_layout.create device(%device : !hal.device) push_constants(4) layouts([%descriptor_set_layout]) : !hal.pipeline_layout
  %0 = arith.select %value, %c0, %c-1 : index
  %1 = arith.index_cast %0 : index to i32
  util.global.store %descriptor_set_layout, @_descriptor_set_layout_0 : !hal.descriptor_set_layout
  util.global.store %value, @_device_query_0 : i1
  util.global.store %pipeline_layout, @_pipeline_layout_0 : !hal.pipeline_layout
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

