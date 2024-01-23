
#composite_of_128b = #util.composite<128xi8, [
    dense<[[1.54099607, -0.293428898, -2.17878938], [0.568431258, -1.08452237, -1.39859545], [0.403346837, 0.838026344, -0.719257593], [-0.403343529, -0.596635341, 0.182036489]]> : tensor<4x3xf32>,
    dense<0> : vector<16xi8>,
    dense<[-0.856674611, 1.10060418, -1.07118738]> : tensor<3xf32>,
    dense<0> : vector<52xi8>,
]>
#executable_target_cuda_nvptx_fb = #hal.executable.target<"cuda", "cuda-nvptx-fb", {target_arch = "sm_75"}>
#device_target_cuda = #hal.device.target<"cuda", {executable_targets = [#executable_target_cuda_nvptx_fb], legacy_sync}>
module @LinearModule attributes {hal.device.targets = [#device_target_cuda], iree.fixedpoint.iteration = 0 : index} {
  util.global private @_device_query_0 : i1
  util.global private @_descriptor_set_layout_0 : !hal.descriptor_set_layout
  util.global private @_pipeline_layout_0 : !hal.pipeline_layout
  util.global private @_executable_main_dispatch_0 : !hal.executable
  util.global private mutable @_params.weight__timepoint : !hal.fence
  util.global private @_params.weight : !hal.buffer
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
    %buffer_cst = util.buffer.constant {alignment = 64 : index} : !util.buffer = #composite_of_128b
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
  hal.executable private @main_dispatch_0 {
    hal.executable.binary public @cuda_nvptx_fb attributes {data = dense<"0x080000004355444138FAFFFF1C0000005000000044000000580000000400000001000000880500000100000004000000200000006D61696E5F64697370617463685F305F6D61746D756C5F31783378345F66333200000000010000000000000001000000010000000300000001000000360500002F2F0A2F2F2047656E657261746564206279204C4C564D204E56505458204261636B2D456E640A2F2F0A0A2E76657273696F6E20372E350A2E74617267657420736D5F37350A2E616464726573735F73697A652036340A0A092F2F202E676C6F626C096D61696E5F64697370617463685F305F6D61746D756C5F31783378345F6633320A0A2E76697369626C65202E656E747279206D61696E5F64697370617463685F305F6D61746D756C5F31783378345F663332280A092E706172616D202E753634206D61696E5F64697370617463685F305F6D61746D756C5F31783378345F6633325F706172616D5F302C0A092E706172616D202E753634206D61696E5F64697370617463685F305F6D61746D756C5F31783378345F6633325F706172616D5F312C0A092E706172616D202E753634206D61696E5F64697370617463685F305F6D61746D756C5F31783378345F6633325F706172616D5F320A290A2E6D61786E74696420312C20332C20310A7B0A092E726567202E623332200925723C323E3B0A092E726567202E663332200925663C32303E3B0A092E726567202E62363420092572643C373E3B0A0A096C642E706172616D2E7536342009257264312C205B6D61696E5F64697370617463685F305F6D61746D756C5F31783378345F6633325F706172616D5F305D3B0A096C642E706172616D2E7536342009257264322C205B6D61696E5F64697370617463685F305F6D61746D756C5F31783378345F6633325F706172616D5F315D3B0A096C642E706172616D2E7536342009257264332C205B6D61696E5F64697370617463685F305F6D61746D756C5F31783378345F6633325F706172616D5F325D3B0A096D6F762E75333220092572312C202563746169642E783B0A096C642E676C6F62616C2E6E632E76342E66333220097B2566312C202566322C202566332C202566347D2C205B257264315D3B0A096D756C2E776964652E7533322009257264342C202572312C20343B0A096164642E7336342009257264352C20257264322C20257264343B0A096C642E676C6F62616C2E6E632E66333220092566352C205B257264355D3B0A096C642E676C6F62616C2E6E632E66333220092566362C205B257264352B31325D3B0A096C642E676C6F62616C2E6E632E66333220092566372C205B257264352B32345D3B0A096C642E676C6F62616C2E6E632E66333220092566382C205B257264352B33365D3B0A09666D612E726E2E66333220092566392C202566312C202566352C20306630303030303030303B0A09666D612E726E2E6633322009256631302C202566322C202566362C202566393B0A09666D612E726E2E6633322009256631312C202566332C202566372C20256631303B0A09666D612E726E2E6633322009256631322C202566342C202566382C20256631313B0A096C642E676C6F62616C2E6E632E6633322009256631332C205B257264352B36345D3B0A096162732E6633322009256631342C20256631323B0A09666D612E726E2E6633322009256631352C202566312C202566352C20256631333B0A09666D612E726E2E6633322009256631362C202566322C202566362C20256631353B0A09666D612E726E2E6633322009256631372C202566332C202566372C20256631363B0A09666D612E726E2E6633322009256631382C202566342C202566382C20256631373B0A096164642E726E2E6633322009256631392C20256631342C20256631383B0A096164642E7336342009257264362C20257264332C20257264343B0A0973742E676C6F62616C2E66333220095B257264365D2C20256631393B0A097265743B0A0A7D0A0000E4FFFFFF08000000040000000A000000696E7075742E6D6C6972000008000C00040008000E001800040008000C0010001400"> : vector<1502xi8>, format = "cuda-nvptx-fb", mime_type = "application/x-flatbuffers"}
  }
  func.func @main(%arg0: !hal.buffer_view) -> !hal.buffer_view attributes {iree.abi.stub} {
    %c0 = arith.constant 0 : index
    %c4 = arith.constant 4 : index
    %c1_i32 = arith.constant 1 : i32
    %c553648160_i32 = arith.constant 553648160 : i32
    %c12 = arith.constant 12 : index
    %c16 = arith.constant 16 : index
    %c128 = arith.constant 128 : index
    %c-1_i64 = arith.constant -1 : i64
    %c0_i64 = arith.constant 0 : i64
    %c-1_i32 = arith.constant -1 : i32
    %c-1 = arith.constant -1 : index
    %c1 = arith.constant 1 : index
    %c2 = arith.constant 2 : index
    %c3 = arith.constant 3 : index
    %_params.weight__timepoint = util.global.load @_params.weight__timepoint : !hal.fence
    %_params.weight = util.global.load @_params.weight : !hal.buffer
    %_device_query_0 = util.global.load @_device_query_0 : i1
    %_pipeline_layout_0 = util.global.load @_pipeline_layout_0 : !hal.pipeline_layout
    %_executable_main_dispatch_0 = util.global.load @_executable_main_dispatch_0 : !hal.executable
    hal.buffer_view.assert<%arg0 : !hal.buffer_view> message("input 0") shape([%c4]) type(%c553648160_i32) encoding(%c1_i32)
    %buffer = hal.buffer_view.buffer<%arg0 : !hal.buffer_view> : !hal.buffer
    %device = hal.ex.shared_device : !hal.device
    %allocator = hal.device.allocator<%device : !hal.device> : !hal.allocator
    hal.buffer.assert<%buffer : !hal.buffer> message("tensor") allocator(%allocator : !hal.allocator) minimum_length(%c16) type(DeviceVisible) usage("TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage")
    %fence = hal.fence.create device(%device : !hal.device) flags("None") : !hal.fence
    %status = hal.fence.await until([%_params.weight__timepoint]) timeout_millis(%c-1_i32) : i32
    %0 = util.null : !hal.fence
    %transient_buffer = hal.device.queue.alloca<%device : !hal.device> affinity(%c-1_i64) wait(%0) signal(%fence) pool(%c0_i64) type("DeviceVisible|DeviceLocal") usage("TransferSource|TransferTarget|Transfer|DispatchStorageRead|DispatchStorageWrite|DispatchStorage") : !hal.buffer{%c12}
    %status_0 = hal.fence.await until([%fence]) timeout_millis(%c-1_i32) : i32
    %cmd = hal.command_buffer.create device(%device : !hal.device) mode("OneShot|AllowInlineExecution") categories("Transfer|Dispatch") : !hal.command_buffer
    %1 = arith.select %_device_query_0, %c0, %c-1 : index
    %2 = arith.index_cast %1 : index to i32
    cf.switch %2 : i32, [
      default: ^bb2,
      0: ^bb1
    ]
  ^bb1:  // pred: ^bb0
    hal.command_buffer.push_descriptor_set<%cmd : !hal.command_buffer> layout(%_pipeline_layout_0 : !hal.pipeline_layout)[%c0] bindings([
      %c0 = (%buffer : !hal.buffer)[%c0, %c16], 
      %c1 = (%_params.weight : !hal.buffer)[%c0, %c128], 
      %c2 = (%transient_buffer : !hal.buffer)[%c0, %c12]
    ])
    hal.command_buffer.dispatch<%cmd : !hal.command_buffer> target(%_executable_main_dispatch_0 : !hal.executable)[0] workgroups([%c3, %c1, %c1])
    cf.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    hal.command_buffer.execution_barrier<%cmd : !hal.command_buffer> source("Dispatch|Transfer|CommandRetire") target("CommandIssue|Dispatch|Transfer") flags("None")
    hal.command_buffer.finalize<%cmd : !hal.command_buffer>
    %fence_1 = hal.fence.create device(%device : !hal.device) flags("None") : !hal.fence
    %status_2 = hal.fence.await until([%fence]) timeout_millis(%c-1_i32) : i32
    hal.device.queue.execute<%device : !hal.device> affinity(%c-1_i64) wait(%0) signal(%fence_1) commands([%cmd])
    %status_3 = hal.fence.await until([%fence_1]) timeout_millis(%c-1_i32) : i32
    util.status.check_ok %status_3, "failed to wait on timepoint"
    %view = hal.buffer_view.create buffer(%transient_buffer : !hal.buffer)[%c0, %c12] shape([%c3]) type(%c553648160_i32) encoding(%c1_i32) : !hal.buffer_view
    return %view : !hal.buffer_view
  }
}


