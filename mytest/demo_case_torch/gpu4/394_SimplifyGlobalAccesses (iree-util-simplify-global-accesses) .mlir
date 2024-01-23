
util.initializer {
  %_descriptor_set_layout_0 = util.global.load @_descriptor_set_layout_0 : !hal.descriptor_set_layout
  %device = hal.ex.shared_device : !hal.device
  %pipeline_layout = hal.pipeline_layout.create device(%device : !hal.device) push_constants(0) layouts([%_descriptor_set_layout_0]) : !hal.pipeline_layout
  util.global.store %pipeline_layout, @_pipeline_layout_0 : !hal.pipeline_layout
  util.initializer.return
}

