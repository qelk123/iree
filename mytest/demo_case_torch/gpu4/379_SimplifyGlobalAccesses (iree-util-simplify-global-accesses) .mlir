
util.initializer {
  %c0_i32 = arith.constant 0 : i32
  %c-1_i64 = arith.constant -1 : i64
  %c0 = arith.constant 0 : index
  %c128 = arith.constant 128 : index
  %c0_i64 = arith.constant 0 : i64
  %0 = util.null : !hal.fence
  %buffer_cst = util.buffer.constant {alignment = 64 : index} : !util.buffer = #util.composite<128xi8, [
    dense<[[1.54099607, -0.293428898, -2.17878938], [0.568431258, -1.08452237, -1.39859545], [0.403346837, 0.838026344, -0.719257593], [-0.403343529, -0.596635341, 0.182036489]]> : tensor<4x3xf32>,
    dense<0> : vector<16xi8>,
    dense<[-0.856674611, 1.10060418, -1.07118738]> : tensor<3xf32>,
    dense<0> : vector<52xi8>,
]>
  %device = hal.ex.shared_device : !hal.device
  %allocator = hal.device.allocator<%device : !hal.device> : !hal.allocator
  %did_import, %mapped = hal.allocator.import<%allocator : !hal.allocator> source(%buffer_cst : !util.buffer)[%c0, %c128] affinity(%c-1_i64) type("DeviceVisible|DeviceLocal") usage("TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage|SharingImmutable") : i1, !hal.buffer
  cf.cond_br %did_import, ^bb2(%0, %mapped : !hal.fence, !hal.buffer), ^bb1
^bb1:  // pred: ^bb0
  %buffer = hal.allocator.allocate<%allocator : !hal.allocator> affinity(%c-1_i64) type("DeviceVisible|DeviceLocal") usage("TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage|SharingImmutable") : !hal.buffer{%c128}
  %memory_file = hal.ex.file.from_memory device(%device : !hal.device) affinity(%c-1_i64) access(Read) buffer(%buffer_cst : !util.buffer)[%c0 for %c128] flags(%c0_i32) : !hal.file
  %fence = hal.fence.create device(%device : !hal.device) flags("None") : !hal.fence
  hal.device.queue.read<%device : !hal.device> affinity(%c-1_i64) wait(%0) signal(%fence) source(%memory_file : !hal.file)[%c0_i64] target(%buffer : !hal.buffer)[%c0] length(%c128) flags(0)
  cf.br ^bb2(%fence, %buffer : !hal.fence, !hal.buffer)
^bb2(%1: !hal.fence, %2: !hal.buffer):  // 2 preds: ^bb0, ^bb1
  util.global.store %2, @_params.weight : !hal.buffer
  util.global.store %1, @_params.weight__timepoint : !hal.fence
  util.initializer.return
}

