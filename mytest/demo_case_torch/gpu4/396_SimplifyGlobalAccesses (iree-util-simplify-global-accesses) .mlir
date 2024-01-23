
util.initializer {
  %_device_query_0 = util.global.load @_device_query_0 : i1
  %c0 = arith.constant 0 : index
  %c-1 = arith.constant -1 : index
  %device = hal.ex.shared_device : !hal.device
  %0 = arith.select %_device_query_0, %c0, %c-1 : index
  %1 = scf.index_switch %0 -> !hal.executable 
  case 0 {
    %_pipeline_layout_0 = util.global.load @_pipeline_layout_0 : !hal.pipeline_layout
    %exe = hal.executable.create device(%device : !hal.device) target(@main_dispatch_0::@cuda_nvptx_fb) layouts([%_pipeline_layout_0]) : !hal.executable
    scf.yield %exe : !hal.executable
  }
  default {
    %2 = util.null : !hal.executable
    scf.yield %2 : !hal.executable
  }
  util.global.store %1, @_executable_main_dispatch_0 : !hal.executable
  util.initializer.return
}

