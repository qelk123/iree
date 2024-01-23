
vm.module public @LinearModule {
  vm.global.i32 private @_device_query_0 : i32
  vm.global.ref private @_pipeline_layout_0 : !vm.ref<!hal.pipeline_layout>
  vm.global.ref private @_executable_main_dispatch_0 : !vm.ref<!hal.executable>
  vm.global.ref private mutable @_params.weight__timepoint : !vm.ref<!hal.fence>
  vm.global.ref private @_params.weight : !vm.ref<!hal.buffer>
  vm.rodata private @main_dispatch_0_cuda_nvptx_fb {alignment = 16 : i64, mime_type = "application/x-flatbuffers"} dense<"0x080000004355444138FAFFFF1C0000005000000044000000580000000400000001000000880500000100000004000000200000006D61696E5F64697370617463685F305F6D61746D756C5F31783378345F66333200000000010000000000000001000000010000000300000001000000360500002F2F0A2F2F2047656E657261746564206279204C4C564D204E56505458204261636B2D456E640A2F2F0A0A2E76657273696F6E20372E350A2E74617267657420736D5F37350A2E616464726573735F73697A652036340A0A092F2F202E676C6F626C096D61696E5F64697370617463685F305F6D61746D756C5F31783378345F6633320A0A2E76697369626C65202E656E747279206D61696E5F64697370617463685F305F6D61746D756C5F31783378345F663332280A092E706172616D202E753634206D61696E5F64697370617463685F305F6D61746D756C5F31783378345F6633325F706172616D5F302C0A092E706172616D202E753634206D61696E5F64697370617463685F305F6D61746D756C5F31783378345F6633325F706172616D5F312C0A092E706172616D202E753634206D61696E5F64697370617463685F305F6D61746D756C5F31783378345F6633325F706172616D5F320A290A2E6D61786E74696420312C20332C20310A7B0A092E726567202E623332200925723C323E3B0A092E726567202E663332200925663C32303E3B0A092E726567202E62363420092572643C373E3B0A0A096C642E706172616D2E7536342009257264312C205B6D61696E5F64697370617463685F305F6D61746D756C5F31783378345F6633325F706172616D5F305D3B0A096C642E706172616D2E7536342009257264322C205B6D61696E5F64697370617463685F305F6D61746D756C5F31783378345F6633325F706172616D5F315D3B0A096C642E706172616D2E7536342009257264332C205B6D61696E5F64697370617463685F305F6D61746D756C5F31783378345F6633325F706172616D5F325D3B0A096D6F762E75333220092572312C202563746169642E783B0A096C642E676C6F62616C2E6E632E76342E66333220097B2566312C202566322C202566332C202566347D2C205B257264315D3B0A096D756C2E776964652E7533322009257264342C202572312C20343B0A096164642E7336342009257264352C20257264322C20257264343B0A096C642E676C6F62616C2E6E632E66333220092566352C205B257264355D3B0A096C642E676C6F62616C2E6E632E66333220092566362C205B257264352B31325D3B0A096C642E676C6F62616C2E6E632E66333220092566372C205B257264352B32345D3B0A096C642E676C6F62616C2E6E632E66333220092566382C205B257264352B33365D3B0A09666D612E726E2E66333220092566392C202566312C202566352C20306630303030303030303B0A09666D612E726E2E6633322009256631302C202566322C202566362C202566393B0A09666D612E726E2E6633322009256631312C202566332C202566372C20256631303B0A09666D612E726E2E6633322009256631322C202566342C202566382C20256631313B0A096C642E676C6F62616C2E6E632E6633322009256631332C205B257264352B36345D3B0A096162732E6633322009256631342C20256631323B0A09666D612E726E2E6633322009256631352C202566312C202566352C20256631333B0A09666D612E726E2E6633322009256631362C202566322C202566362C20256631353B0A09666D612E726E2E6633322009256631372C202566332C202566372C20256631363B0A09666D612E726E2E6633322009256631382C202566342C202566382C20256631373B0A096164642E726E2E6633322009256631392C20256631342C20256631383B0A096164642E7336342009257264362C20257264332C20257264343B0A0973742E676C6F62616C2E66333220095B257264365D2C20256631393B0A097265743B0A0A7D0A0000E4FFFFFF08000000040000000A000000696E7075742E6D6C6972000008000C00040008000E001800040008000C0010001400"> : vector<1502xi8>
  vm.rodata private @_utf8_hal_executable_format_EAB228F999C2D3A1 {alignment = 1 : i64} "hal.executable.format"
  vm.rodata private @_utf8_cuda_nvptx_fb_B15B42B96FDBACC {alignment = 1 : i64} "cuda-nvptx-fb"
  vm.rodata private @_utf8_cuda_nvptx_fb_B15B42B96FDBACC_0 {alignment = 1 : i64} "cuda-nvptx-fb"
  vm.rodata private @_const {alignment = 64 : i64} #util.composite<128xi8, [
    dense<[[1.54099607, -0.293428898, -2.17878938], [0.568431258, -1.08452237, -1.39859545], [0.403346837, 0.838026344, -0.719257593], [-0.403343529, -0.596635341, 0.182036489]]> : tensor<4x3xf32>,
    dense<0> : vector<16xi8>,
    dense<[-0.856674611, 1.10060418, -1.07118738]> : tensor<3xf32>,
    dense<0> : vector<52xi8>,
]>
  vm.initializer {
    %zero = vm.const.i64.zero
    %c128 = vm.const.i64 128
    %c-1 = vm.const.i64 -1
    %zero_0 = vm.const.i32.zero
    %zero_1 = vm.const.i64.zero
    %c-1_2 = vm.const.i64 -1
    %ref = vm.call @hal.ex.shared_device() {nosideeffects} : () -> !vm.ref<!hal.device>
    %_utf8_hal_executable_format_EAB228F999C2D3A1 = vm.const.ref.rodata @_utf8_hal_executable_format_EAB228F999C2D3A1 : !vm.buffer
    %_utf8_cuda_nvptx_fb_B15B42B96FDBACC = vm.const.ref.rodata @_utf8_cuda_nvptx_fb_B15B42B96FDBACC : !vm.buffer
    %0:2 = vm.call @hal.device.query.i64(%ref, %_utf8_hal_executable_format_EAB228F999C2D3A1, %_utf8_cuda_nvptx_fb_B15B42B96FDBACC) {nosideeffects} : (!vm.ref<!hal.device>, !vm.buffer, !vm.buffer) -> (i32, i64)
    %1 = vm.trunc.i64.i32 %0#1 : i64 -> i32
    %c1 = vm.const.i32 1
    %2 = vm.and.i32 %1, %c1 : i32
    %zero_3 = vm.const.i32.zero
    %3 = vm.select.i32 %0#0, %2, %zero_3 : i32
    %c1_4 = vm.const.i32 1
    %zero_5 = vm.const.i32.zero
    %zero_6 = vm.const.i32.zero
    %c7 = vm.const.i32 7
    %c1_7 = vm.const.i32 1
    %c1_8 = vm.const.i32 1
    %c7_9 = vm.const.i32 7
    %c1_10 = vm.const.i32 1
    %c2 = vm.const.i32 2
    %c7_11 = vm.const.i32 7
    %zero_12 = vm.const.i32.zero
    %ref_13 = vm.call.variadic @hal.descriptor_set_layout.create(%ref, %zero_5, [(%zero_6, %c7, %c1_7), (%c1_8, %c7_9, %c1_10), (%c2, %c7_11, %zero_12)]) {nosideeffects} : (!vm.ref<!hal.device>, i32, tuple<i32, i32, i32> ...) -> !vm.ref<!hal.descriptor_set_layout>
    %zero_14 = vm.const.i32.zero
    %ref_15 = vm.call.variadic @hal.pipeline_layout.create(%ref, %zero_14, [%ref_13]) {nosideeffects} : (!vm.ref<!hal.device>, i32, !vm.ref<!hal.descriptor_set_layout> ...) -> !vm.ref<!hal.pipeline_layout>
    %4 = vm.select.i64 %3, %zero_1, %c-1_2 : i64
    %5 = vm.trunc.i64.i32 %4 : i64 -> i32
    vm.global.store.i32 %3, @_device_query_0 : i32
    vm.global.store.ref %ref_15, @_pipeline_layout_0 : !vm.ref<!hal.pipeline_layout>
    vm.br_table %5 {
      default: ^bb2,
      0: ^bb1
    }
  ^bb1:  // pred: ^bb0
    %_pipeline_layout_0 = vm.global.load.ref @_pipeline_layout_0 : !vm.ref<!hal.pipeline_layout>
    %main_dispatch_0_cuda_nvptx_fb = vm.const.ref.rodata @main_dispatch_0_cuda_nvptx_fb : !vm.buffer
    %_utf8_cuda_nvptx_fb_B15B42B96FDBACC_0 = vm.const.ref.rodata @_utf8_cuda_nvptx_fb_B15B42B96FDBACC_0 : !vm.buffer
    %null = vm.const.ref.zero : !vm.buffer
    %ref_16 = vm.call.variadic @hal.executable.create(%ref, %_utf8_cuda_nvptx_fb_B15B42B96FDBACC_0, %main_dispatch_0_cuda_nvptx_fb, %null, [%_pipeline_layout_0]) {nosideeffects} : (!vm.ref<!hal.device>, !vm.buffer, !vm.buffer, !vm.buffer, !vm.ref<!hal.pipeline_layout> ...) -> !vm.ref<!hal.executable>
    vm.br ^bb3(%ref_16 : !vm.ref<!hal.executable>)
  ^bb2:  // pred: ^bb0
    %null_17 = vm.const.ref.zero : !vm.ref<!hal.executable>
    vm.br ^bb3(%null_17 : !vm.ref<!hal.executable>)
  ^bb3(%6: !vm.ref<!hal.executable>):  // 2 preds: ^bb1, ^bb2
    %null_18 = vm.const.ref.zero : !vm.ref<!hal.fence>
    %_const = vm.const.ref.rodata @_const : !vm.buffer
    %ref_19 = vm.call @hal.device.allocator(%ref) {nosideeffects} : (!vm.ref<!hal.device>) -> !vm.ref<!hal.allocator>
    %c1_20 = vm.const.i32 1
    %c48 = vm.const.i32 48
    %c527363 = vm.const.i32 527363
    %ref_21 = vm.call @hal.allocator.import(%ref_19, %c1_20, %c-1, %c48, %c527363, %_const, %zero_1, %c128) : (!vm.ref<!hal.allocator>, i32, i64, i32, i32, !vm.buffer, i64, i64) -> !vm.ref<!hal.buffer>
    %rnz = vm.cmp.nz.ref %ref_21 : !vm.ref<!hal.buffer>
    vm.global.store.ref %6, @_executable_main_dispatch_0 : !vm.ref<!hal.executable>
    vm.cond_br %rnz, ^bb5(%null_18, %ref_21 : !vm.ref<!hal.fence>, !vm.ref<!hal.buffer>), ^bb4
  ^bb4:  // pred: ^bb3
    %c48_22 = vm.const.i32 48
    %c527363_23 = vm.const.i32 527363
    %ref_24 = vm.call @hal.allocator.allocate(%ref_19, %c-1, %c48_22, %c527363_23, %c128) : (!vm.ref<!hal.allocator>, i64, i32, i32, i64) -> !vm.ref<!hal.buffer>
    %c1_25 = vm.const.i32 1
    %ref_26 = vm.call @hal.ex.file.from_memory(%ref, %c-1, %c1_25, %_const, %zero_1, %c128, %zero_0) : (!vm.ref<!hal.device>, i64, i32, !vm.buffer, i64, i64, i32) -> !vm.ref<!hal.file>
    %zero_27 = vm.const.i32.zero
    %ref_28 = vm.call @hal.fence.create(%ref, %zero_27) : (!vm.ref<!hal.device>, i32) -> !vm.ref<!hal.fence>
    %zero_29 = vm.const.i32.zero
    vm.call @hal.device.queue.read(%ref, %c-1, %null_18, %ref_28, %ref_26, %zero, %ref_24, %zero_1, %c128, %zero_29) : (!vm.ref<!hal.device>, i64, !vm.ref<!hal.fence>, !vm.ref<!hal.fence>, !vm.ref<!hal.file>, i64, !vm.ref<!hal.buffer>, i64, i64, i32) -> ()
    vm.br ^bb5(%ref_28, %ref_24 : !vm.ref<!hal.fence>, !vm.ref<!hal.buffer>)
  ^bb5(%7: !vm.ref<!hal.fence>, %8: !vm.ref<!hal.buffer>):  // 2 preds: ^bb3, ^bb4
    vm.global.store.ref %8, @_params.weight : !vm.ref<!hal.buffer>
    vm.global.store.ref %7, @_params.weight__timepoint : !vm.ref<!hal.fence>
    vm.return
  }
  vm.import private @hal.ex.shared_device() -> !vm.ref<!hal.device> attributes {nosideeffects}
  vm.import private @hal.ex.file.from_memory(%device : !vm.ref<!hal.device>, %queue_affinity : i64, %access : i32, %buffer : !vm.buffer, %offset : i64, %length : i64, %flags : i32) -> !vm.ref<!hal.file>
  vm.import private @hal.allocator.allocate(%allocator : !vm.ref<!hal.allocator>, %queue_affinity : i64, %memory_types : i32, %buffer_usage : i32, %allocation_size : i64) -> !vm.ref<!hal.buffer> attributes {minimum_version = 1 : i32}
  vm.import private @hal.allocator.import(%allocator : !vm.ref<!hal.allocator>, %try : i32, %queue_affinity : i64, %memory_types : i32, %buffer_usage : i32, %source : !vm.buffer, %offset : i64, %length : i64) -> !vm.ref<!hal.buffer> attributes {minimum_version = 1 : i32}
  vm.import private @hal.buffer.assert(%buffer : !vm.ref<!hal.buffer>, %message : !vm.buffer, %allocator : !vm.ref<!hal.allocator>, %minimum_length : i64, %memory_types : i32, %buffer_usage : i32)
  vm.import private @hal.buffer.subspan(%source_buffer : !vm.ref<!hal.buffer>, %source_offset : i64, %length : i64) -> !vm.ref<!hal.buffer> attributes {nosideeffects}
  vm.import private @hal.buffer.length(%buffer : !vm.ref<!hal.buffer>) -> i64 attributes {nosideeffects}
  vm.import private @hal.buffer.load(%source_buffer : !vm.ref<!hal.buffer>, %source_offset : i64, %length : i32) -> i32
  vm.import private @hal.buffer.store(%value : i32, %target_buffer : !vm.ref<!hal.buffer>, %target_offset : i64, %length : i32)
  vm.import private @hal.buffer_view.create(%buffer : !vm.ref<!hal.buffer>, %source_offset : i64, %source_length : i64, %element_type : i32, %encoding_type : i32, %shape : i64 ...) -> !vm.ref<!hal.buffer_view> attributes {nosideeffects}
  vm.import private @hal.buffer_view.assert(%buffer_view : !vm.ref<!hal.buffer_view>, %message : !vm.buffer, %element_type : i32, %encoding_type : i32, %shape : i64 ...)
  vm.import private @hal.buffer_view.buffer(%buffer_view : !vm.ref<!hal.buffer_view>) -> !vm.ref<!hal.buffer> attributes {nosideeffects}
  vm.import private @hal.buffer_view.element_type(%buffer_view : !vm.ref<!hal.buffer_view>) -> i32 attributes {nosideeffects}
  vm.import private @hal.buffer_view.encoding_type(%buffer_view : !vm.ref<!hal.buffer_view>) -> i32 attributes {nosideeffects}
  vm.import private @hal.buffer_view.rank(%buffer_view : !vm.ref<!hal.buffer_view>) -> i32 attributes {nosideeffects}
  vm.import private @hal.buffer_view.dim(%buffer_view : !vm.ref<!hal.buffer_view>, %index : i32) -> i64 attributes {nosideeffects}
  vm.import private @hal.buffer_view.trace(%key : !vm.buffer, %operands : !vm.ref<!hal.buffer_view> ...)
  vm.import private @hal.channel.create(%device : !vm.ref<!hal.device>, %queue_affinity : i64, %flags : i32, %id : !vm.buffer, %group : !vm.buffer, %rank : i32, %count : i32) -> !vm.ref<!hal.channel> attributes {nosideeffects}
  vm.import private @hal.channel.split(%channel : !vm.ref<!hal.channel>, %color : i32, %key : i32, %flags : i32) -> !vm.ref<!hal.channel> attributes {nosideeffects}
  vm.import private @hal.channel.rank_and_count(%channel : !vm.ref<!hal.channel>) -> (i32, i32) attributes {nosideeffects}
  vm.import private @hal.command_buffer.create(%device : !vm.ref<!hal.device>, %modes : i32, %command_categories : i32, %binding_capacity : i32) -> !vm.ref<!hal.command_buffer>
  vm.import private @hal.command_buffer.finalize(%command_buffer : !vm.ref<!hal.command_buffer>)
  vm.import private @hal.command_buffer.begin_debug_group(%command_buffer : !vm.ref<!hal.command_buffer>, %label : !vm.buffer)
  vm.import private @hal.command_buffer.end_debug_group(%command_buffer : !vm.ref<!hal.command_buffer>)
  vm.import private @hal.command_buffer.execution_barrier(%command_buffer : !vm.ref<!hal.command_buffer>, %source_stage_mask : i32, %target_stage_mask : i32, %flags : i32)
  vm.import private @hal.command_buffer.fill_buffer(%command_buffer : !vm.ref<!hal.command_buffer>, %target_buffer : !vm.ref<!hal.buffer>, %target_offset : i64, %length : i64, %pattern : i32, %pattern_length : i32)
  vm.import private @hal.command_buffer.copy_buffer(%command_buffer : !vm.ref<!hal.command_buffer>, %source_buffer : !vm.ref<!hal.buffer>, %source_offset : i64, %target_buffer : !vm.ref<!hal.buffer>, %target_offset : i64, %length : i64)
  vm.import private @hal.command_buffer.collective(%command_buffer : !vm.ref<!hal.command_buffer>, %channel : !vm.ref<!hal.channel>, %op : i32, %param : i32, %send_buffer : !vm.ref<!hal.buffer>, %send_offset : i64, %send_length : i64, %recv_buffer : !vm.ref<!hal.buffer>, %recv_offset : i64, %recv_length : i64, %element_count : i64)
  vm.import private @hal.command_buffer.push_constants(%command_buffer : !vm.ref<!hal.command_buffer>, %pipeline_layout : !vm.ref<!hal.pipeline_layout>, %offset : i32, %values : i32 ...)
  vm.import private @hal.command_buffer.push_descriptor_set(%command_buffer : !vm.ref<!hal.command_buffer>, %pipeline_layout : !vm.ref<!hal.pipeline_layout>, %set : i32, %bindings : tuple<i32, i32, !vm.ref<!hal.buffer>, i64, i64> ...)
  vm.import private @hal.command_buffer.dispatch(%command_buffer : !vm.ref<!hal.command_buffer>, %executable : !vm.ref<!hal.executable>, %entry_point : i32, %workgroup_x : i32, %workgroup_y : i32, %workgroup_z : i32)
  vm.import private @hal.command_buffer.dispatch.indirect(%command_buffer : !vm.ref<!hal.command_buffer>, %executable : !vm.ref<!hal.executable>, %entry_point : i32, %workgroups_buffer : !vm.ref<!hal.buffer>, %workgroups_offset : i64)
  vm.import private @hal.command_buffer.execute.commands(%command_buffer : !vm.ref<!hal.command_buffer>, %commands : !vm.ref<!hal.command_buffer>, %bindings : tuple<!vm.ref<!hal.buffer>, i64, i64> ...)
  vm.import private @hal.descriptor_set_layout.create(%device : !vm.ref<!hal.device>, %flags : i32, %bindings : tuple<i32, i32, i32> ...) -> !vm.ref<!hal.descriptor_set_layout> attributes {nosideeffects}
  vm.import private @hal.device.allocator(%device : !vm.ref<!hal.device>) -> !vm.ref<!hal.allocator> attributes {nosideeffects}
  vm.import private @hal.device.query.i64(%device : !vm.ref<!hal.device>, %category : !vm.buffer, %key : !vm.buffer) -> (i32, i64) attributes {nosideeffects}
  vm.import private @hal.device.queue.alloca(%device : !vm.ref<!hal.device>, %queue_affinity : i64, %wait_fence : !vm.ref<!hal.fence>, %signal_fence : !vm.ref<!hal.fence>, %pool : i32, %memory_types : i32, %buffer_usage : i32, %allocation_size : i64) -> !vm.ref<!hal.buffer>
  vm.import private @hal.device.queue.dealloca(%device : !vm.ref<!hal.device>, %queue_affinity : i64, %wait_fence : !vm.ref<!hal.fence>, %signal_fence : !vm.ref<!hal.fence>, %buffer : !vm.ref<!hal.buffer>)
  vm.import private @hal.device.queue.read(%device : !vm.ref<!hal.device>, %queue_affinity : i64, %wait_fence : !vm.ref<!hal.fence>, %signal_fence : !vm.ref<!hal.fence>, %source_file : !vm.ref<!hal.file>, %source_offset : i64, %target_buffer : !vm.ref<!hal.buffer>, %target_offset : i64, %length : i64, %flags : i32)
  vm.import private @hal.device.queue.write(%device : !vm.ref<!hal.device>, %queue_affinity : i64, %wait_fence : !vm.ref<!hal.fence>, %signal_fence : !vm.ref<!hal.fence>, %source_buffer : !vm.ref<!hal.buffer>, %source_offset : i64, %target_file : !vm.ref<!hal.file>, %target_offset : i64, %length : i64, %flags : i32)
  vm.import private @hal.device.queue.execute(%device : !vm.ref<!hal.device>, %queue_affinity : i64, %wait_fence : !vm.ref<!hal.fence>, %signal_fence : !vm.ref<!hal.fence>, %command_buffers : !vm.ref<!hal.command_buffer> ...)
  vm.import private @hal.device.queue.flush(%device : !vm.ref<!hal.device>, %queue_affinity : i64)
  vm.import private @hal.executable.create(%device : !vm.ref<!hal.device>, %executable_format : !vm.buffer, %executable_data : !vm.buffer, %constants : !vm.buffer, %pipeline_layouts : !vm.ref<!hal.pipeline_layout> ...) -> !vm.ref<!hal.executable> attributes {nosideeffects}
  vm.import private @hal.fence.create(%device : !vm.ref<!hal.device>, %flags : i32) -> !vm.ref<!hal.fence>
  vm.import private @hal.fence.join(%fences : !vm.ref<!hal.fence> ...) -> !vm.ref<!hal.fence> attributes {nosideeffects}
  vm.import private @hal.fence.query(%fence : !vm.ref<!hal.fence>) -> i32
  vm.import private @hal.fence.signal(%fence : !vm.ref<!hal.fence>)
  vm.import private @hal.fence.fail(%fence : !vm.ref<!hal.fence>, %status : i32)
  vm.import private @hal.fence.await(%timeout_millis : i32, %fences : !vm.ref<!hal.fence> ...) -> i32 attributes {vm.yield}
  vm.import private @hal.pipeline_layout.create(%device : !vm.ref<!hal.device>, %push_constants : i32, %set_layouts : !vm.ref<!hal.descriptor_set_layout> ...) -> !vm.ref<!hal.pipeline_layout> attributes {nosideeffects}
  vm.rodata private @_utf8_input_0_5FD512E67BEFDEEC {alignment = 1 : i64} "input 0"
  vm.rodata private @_utf8_tensor_3C6209B4FD120BDC {alignment = 1 : i64} "tensor"
  vm.func private @main(%arg0: !vm.ref<!hal.buffer_view>) -> !vm.ref<!hal.buffer_view> {
    %c3 = vm.const.i64 3
    %c2 = vm.const.i64 2
    %c1 = vm.const.i64 1
    %c-1 = vm.const.i64 -1
    %c-1_0 = vm.const.i32 -1
    %zero = vm.const.i64.zero
    %c-1_1 = vm.const.i64 -1
    %c128 = vm.const.i64 128
    %c16 = vm.const.i64 16
    %c12 = vm.const.i64 12
    %c553648160 = vm.const.i32 553648160
    %c1_2 = vm.const.i32 1
    %c4 = vm.const.i64 4
    %zero_3 = vm.const.i64.zero
    %_params.weight__timepoint = vm.global.load.ref @_params.weight__timepoint : !vm.ref<!hal.fence>
    %_params.weight = vm.global.load.ref @_params.weight : !vm.ref<!hal.buffer>
    %_device_query_0 = vm.global.load.i32 @_device_query_0 : i32
    %_pipeline_layout_0 = vm.global.load.ref @_pipeline_layout_0 : !vm.ref<!hal.pipeline_layout>
    %_executable_main_dispatch_0 = vm.global.load.ref @_executable_main_dispatch_0 : !vm.ref<!hal.executable>
    %_utf8_input_0_5FD512E67BEFDEEC = vm.const.ref.rodata @_utf8_input_0_5FD512E67BEFDEEC : !vm.buffer
    vm.call.variadic @hal.buffer_view.assert(%arg0, %_utf8_input_0_5FD512E67BEFDEEC, %c553648160, %c1_2, [%c4]) : (!vm.ref<!hal.buffer_view>, !vm.buffer, i32, i32, i64 ...)
    %ref = vm.call @hal.buffer_view.buffer(%arg0) {nosideeffects} : (!vm.ref<!hal.buffer_view>) -> !vm.ref<!hal.buffer>
    %ref_4 = vm.call @hal.ex.shared_device() {nosideeffects} : () -> !vm.ref<!hal.device>
    %ref_5 = vm.call @hal.device.allocator(%ref_4) {nosideeffects} : (!vm.ref<!hal.device>) -> !vm.ref<!hal.allocator>
    %_utf8_tensor_3C6209B4FD120BDC = vm.const.ref.rodata @_utf8_tensor_3C6209B4FD120BDC : !vm.buffer
    %c16_6 = vm.const.i32 16
    %c3075 = vm.const.i32 3075
    vm.call @hal.buffer.assert(%ref, %_utf8_tensor_3C6209B4FD120BDC, %ref_5, %c16, %c16_6, %c3075) : (!vm.ref<!hal.buffer>, !vm.buffer, !vm.ref<!hal.allocator>, i64, i32, i32) -> ()
    %zero_7 = vm.const.i32.zero
    %ref_8 = vm.call @hal.fence.create(%ref_4, %zero_7) : (!vm.ref<!hal.device>, i32) -> !vm.ref<!hal.fence>
    %0 = vm.call.variadic @hal.fence.await(%c-1_0, [%_params.weight__timepoint]) : (i32, !vm.ref<!hal.fence> ...) -> i32
    %null = vm.const.ref.zero : !vm.ref<!hal.fence>
    %zero_9 = vm.const.i32.zero
    %c48 = vm.const.i32 48
    %c3075_10 = vm.const.i32 3075
    %ref_11 = vm.call @hal.device.queue.alloca(%ref_4, %c-1_1, %null, %ref_8, %zero_9, %c48, %c3075_10, %c12) : (!vm.ref<!hal.device>, i64, !vm.ref<!hal.fence>, !vm.ref<!hal.fence>, i32, i32, i32, i64) -> !vm.ref<!hal.buffer>
    %1 = vm.call.variadic @hal.fence.await(%c-1_0, [%ref_8]) : (i32, !vm.ref<!hal.fence> ...) -> i32
    %c17 = vm.const.i32 17
    %c3_12 = vm.const.i32 3
    %zero_13 = vm.const.i32.zero
    %ref_14 = vm.call @hal.command_buffer.create(%ref_4, %c17, %c3_12, %zero_13) : (!vm.ref<!hal.device>, i32, i32, i32) -> !vm.ref<!hal.command_buffer>
    %2 = vm.select.i64 %_device_query_0, %zero_3, %c-1 : i64
    %3 = vm.trunc.i64.i32 %2 : i64 -> i32
    vm.br_table %3 {
      default: ^bb2,
      0: ^bb1
    }
  ^bb1:  // pred: ^bb0
    %zero_15 = vm.const.i32.zero
    %zero_16 = vm.const.i32.zero
    %zero_17 = vm.const.i32.zero
    %c1_18 = vm.const.i32 1
    %c2_19 = vm.const.i32 2
    vm.call.variadic @hal.command_buffer.push_descriptor_set(%ref_14, %_pipeline_layout_0, %zero_15, [(%zero_16, %zero_17, %ref, %zero_3, %c16), (%c1_18, %zero_17, %_params.weight, %zero_3, %c128), (%c2_19, %zero_17, %ref_11, %zero_3, %c12)]) : (!vm.ref<!hal.command_buffer>, !vm.ref<!hal.pipeline_layout>, i32, tuple<i32, i32, !vm.ref<!hal.buffer>, i64, i64> ...)
    %zero_20 = vm.const.i32.zero
    %c3_21 = vm.const.i32 3
    %c1_22 = vm.const.i32 1
    %c1_23 = vm.const.i32 1
    vm.call @hal.command_buffer.dispatch(%ref_14, %_executable_main_dispatch_0, %zero_20, %c3_21, %c1_22, %c1_23) : (!vm.ref<!hal.command_buffer>, !vm.ref<!hal.executable>, i32, i32, i32, i32) -> ()
    vm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %c28 = vm.const.i32 28
    %c13 = vm.const.i32 13
    %zero_24 = vm.const.i32.zero
    vm.call @hal.command_buffer.execution_barrier(%ref_14, %c28, %c13, %zero_24) : (!vm.ref<!hal.command_buffer>, i32, i32, i32) -> ()
    vm.call @hal.command_buffer.finalize(%ref_14) : (!vm.ref<!hal.command_buffer>) -> ()
    %zero_25 = vm.const.i32.zero
    %ref_26 = vm.call @hal.fence.create(%ref_4, %zero_25) : (!vm.ref<!hal.device>, i32) -> !vm.ref<!hal.fence>
    %4 = vm.call.variadic @hal.fence.await(%c-1_0, [%ref_8]) : (i32, !vm.ref<!hal.fence> ...) -> i32
    vm.call.variadic @hal.device.queue.execute(%ref_4, %c-1_1, %null, %ref_26, [%ref_14]) : (!vm.ref<!hal.device>, i64, !vm.ref<!hal.fence>, !vm.ref<!hal.fence>, !vm.ref<!hal.command_buffer> ...)
    %5 = vm.call.variadic @hal.fence.await(%c-1_0, [%ref_26]) : (i32, !vm.ref<!hal.fence> ...) -> i32
    vm.cond_fail %5, "failed to wait on timepoint"
    %ref_27 = vm.call.variadic @hal.buffer_view.create(%ref_11, %zero_3, %c12, %c553648160, %c1_2, [%c3]) {nosideeffects} : (!vm.ref<!hal.buffer>, i64, i64, i32, i32, i64 ...) -> !vm.ref<!hal.buffer_view>
    vm.return %ref_27 : !vm.ref<!hal.buffer_view>
  }
  vm.export @main attributes {iree.abi.stub}
}

