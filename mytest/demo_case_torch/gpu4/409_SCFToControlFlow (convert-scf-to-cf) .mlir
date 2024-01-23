
util.initializer {
  %device = hal.ex.shared_device : !hal.device
  %ok, %value = hal.device.query<%device : !hal.device> key("hal.executable.format" :: "cuda-nvptx-fb") : i1, i1 = false
  util.global.store %value, @_device_query_0 : i1
  util.initializer.return
}

