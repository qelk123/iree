
util.initializer {
  %c0_i64 = arith.constant 0 : i64
  %c128 = arith.constant 128 : index
  %c-1_i64 = arith.constant -1 : i64
  %c0_i32 = arith.constant 0 : i32
  %c0 = arith.constant 0 : index
  %c-1 = arith.constant -1 : index
  %device = hal.ex.shared_device : !hal.device
  %ok, %value = hal.device.query<%device : !hal.device> key("hal.executable.format" :: "cuda-nvptx-fb") : i1, i1 = false
  %descriptor_set_layout = hal.descriptor_set_layout.create device(%device : !hal.device) flags("None") bindings([#hal.descriptor_set.binding<0, storage_buffer, ReadOnly>, #hal.descriptor_set.binding<1, storage_buffer, ReadOnly>, #hal.descriptor_set.binding<2, storage_buffer>]) : !hal.descriptor_set_layout
  %pipeline_layout = hal.pipeline_layout.create device(%device : !hal.device) push_constants(0) layouts([%descriptor_set_layout]) : !hal.pipeline_layout
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
  %4 = util.null : !hal.fence
  %buffer_cst = util.buffer.constant {alignment = 64 : index} : !util.buffer = #util.composite<128xi8, [
    dense<[[1.54099607, -0.293428898, -2.17878938], [0.568431258, -1.08452237, -1.39859545], [0.403346837, 0.838026344, -0.719257593], [-0.403343529, -0.596635341, 0.182036489]]> : tensor<4x3xf32>,
    dense<0> : vector<16xi8>,
    dense<[-0.856674611, 1.10060418, -1.07118738]> : tensor<3xf32>,
    dense<0> : vector<52xi8>,
]>
  %allocator = hal.device.allocator<%device : !hal.device> : !hal.allocator
  %did_import, %mapped = hal.allocator.import<%allocator : !hal.allocator> source(%buffer_cst : !util.buffer)[%c0, %c128] affinity(%c-1_i64) type("DeviceVisible|DeviceLocal") usage("TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage|SharingImmutable") : i1, !hal.buffer
  util.global.store %3, @_executable_main_dispatch_0 : !hal.executable
  cf.cond_br %did_import, ^bb5(%4, %mapped : !hal.fence, !hal.buffer), ^bb4
^bb4:  // pred: ^bb3
  %buffer = hal.allocator.allocate<%allocator : !hal.allocator> affinity(%c-1_i64) type("DeviceVisible|DeviceLocal") usage("TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage|SharingImmutable") : !hal.buffer{%c128}
  %memory_file = hal.ex.file.from_memory device(%device : !hal.device) affinity(%c-1_i64) access(Read) buffer(%buffer_cst : !util.buffer)[%c0 for %c128] flags(%c0_i32) : !hal.file
  %fence = hal.fence.create device(%device : !hal.device) flags("None") : !hal.fence
  hal.device.queue.read<%device : !hal.device> affinity(%c-1_i64) wait(%4) signal(%fence) source(%memory_file : !hal.file)[%c0_i64] target(%buffer : !hal.buffer)[%c0] length(%c128) flags(0)
  cf.br ^bb5(%fence, %buffer : !hal.fence, !hal.buffer)
^bb5(%5: !hal.fence, %6: !hal.buffer):  // 2 preds: ^bb3, ^bb4
  util.global.store %6, @_params.weight : !hal.buffer
  util.global.store %5, @_params.weight__timepoint : !hal.fence
  util.initializer.return
}

