
vm.module public @LinearModule {
  vm.global.i32 private @_device_query_0 : i32
  vm.global.ref private @_pipeline_layout_0 : !vm.ref<!hal.pipeline_layout>
  vm.global.ref private @_executable_main_dispatch_0 : !vm.ref<!hal.executable>
  vm.rodata private @main_dispatch_0_cuda_nvptx_fb {alignment = 16 : i64, mime_type = "application/x-flatbuffers"} dense<"0x080000004355444108E5FFFF1C0000005000000044000000580000000400000001000000B81A00000100000004000000200000006D61696E5F64697370617463685F305F6D61746D756C5F44784478445F66333200000000010000000000000001000000200000000800000001000000641A00002F2F0A2F2F2047656E657261746564206279204C4C564D204E56505458204261636B2D456E640A2F2F0A0A2E76657273696F6E20372E350A2E74617267657420736D5F37350A2E616464726573735F73697A652036340A0A092F2F202E676C6F626C096D61696E5F64697370617463685F305F6D61746D756C5F44784478445F6633320A0A2E76697369626C65202E656E747279206D61696E5F64697370617463685F305F6D61746D756C5F44784478445F663332280A092E706172616D202E753634206D61696E5F64697370617463685F305F6D61746D756C5F44784478445F6633325F706172616D5F302C0A092E706172616D202E753634206D61696E5F64697370617463685F305F6D61746D756C5F44784478445F6633325F706172616D5F312C0A092E706172616D202E753332206D61696E5F64697370617463685F305F6D61746D756C5F44784478445F6633325F706172616D5F322C0A092E706172616D202E753332206D61696E5F64697370617463685F305F6D61746D756C5F44784478445F6633325F706172616D5F332C0A092E706172616D202E753332206D61696E5F64697370617463685F305F6D61746D756C5F44784478445F6633325F706172616D5F342C0A092E706172616D202E753332206D61696E5F64697370617463685F305F6D61746D756C5F44784478445F6633325F706172616D5F350A290A2E6D61786E7469642033322C20382C20310A7B0A092E726567202E70726564200925703C32313E3B0A092E726567202E623332200925723C31303E3B0A092E726567202E663332200925663C31343E3B0A092E726567202E62363420092572643C3136353E3B0A0A096C642E706172616D2E753332200925726436312C205B6D61696E5F64697370617463685F305F6D61746D756C5F44784478445F6633325F706172616D5F325D3B0A096C642E706172616D2E753332200925726436322C205B6D61696E5F64697370617463685F305F6D61746D756C5F44784478445F6633325F706172616D5F335D3B0A0973686C2E623634200925726436332C2025726436322C2033323B0A096F722E623634202009257264312C2025726436332C2025726436313B0A096C642E706172616D2E7533322009257264322C205B6D61696E5F64697370617463685F305F6D61746D756C5F44784478445F6633325F706172616D5F345D3B0A096C642E706172616D2E7533322009257264332C205B6D61696E5F64697370617463685F305F6D61746D756C5F44784478445F6633325F706172616D5F355D3B0A0973686C2E623634200925726436342C20257264332C2033323B0A096F722E623634202009257264342C2025726436342C20257264323B0A096D6F762E75333220092572312C202563746169642E783B0A096376742E7536342E7533322009257264352C202572313B0A09736574702E6C742E73363420092570312C20257264342C20313B0A096E65672E733634200925726436352C20257264343B0A096164642E733634200925726436362C20257264342C202D313B0A0973656C702E623634200925726436372C2025726436352C2025726436362C202570313B0A097368722E733634200925726436382C2025726436372C2036333B0A097368722E753634200925726436392C2025726436382C2035373B0A096164642E733634200925726437302C2025726436372C2025726436393B0A097368722E733634200925726437312C2025726437302C20373B0A096E65672E733634200925726437322C2025726437313B0A096164642E733634200925726437332C2025726437312C20313B0A0973656C702E623634200925726437342C2025726437322C2025726437332C202570313B0A09616E642E62363420200925726437352C2025726437342C202D343239343936373239363B0A09736574702E6E652E73363420092570322C2025726437352C20303B0A0940257032206272612009244C5F5F4242305F323B0A096272612E756E692009244C5F5F4242305F313B0A244C5F5F4242305F323A0A096469762E73363420092572643134382C20257264352C2025726437343B0A096272612E756E692009244C5F5F4242305F333B0A244C5F5F4242305F313A0A096376742E7533322E75363420092572332C2025726437343B0A096376742E7533322E75363420092572342C20257264353B0A096469762E75333220092572352C202572342C202572333B0A096376742E7536342E75333220092572643134382C202572353B0A244C5F5F4242305F333A0A096C642E706172616D2E753634200925726436302C205B6D61696E5F64697370617463685F305F6D61746D756C5F44784478445F6633325F706172616D5F315D3B0A0973686C2E623634200925726437362C202572643134382C20353B0A097375622E733634200925726437372C20257264312C2025726437363B0A096D696E2E733634200925726437382C2025726437372C2033323B0A096D756C2E6C6F2E733634200925726437392C202572643134382C2025726437343B0A097375622E733634200925726438302C20257264352C2025726437393B0A0973686C2E623634200925726438312C2025726438302C20373B0A097375622E733634200925726438322C20257264342C2025726438313B0A096D696E2E733634200925726438332C2025726438322C203132383B0A096D6F762E75333220092572362C20257469642E783B0A096376742E7536342E753332200925726438342C202572363B0A096D6F762E75333220092572372C20257469642E793B0A096376742E7536342E753332200925726438352C202572373B0A09736574702E6C742E73363420092570332C2025726437372C20313B0A096E65672E733634200925726438362C2025726437383B0A096164642E733634200925726438372C2025726437382C202D313B0A0973656C702E623634200925726438382C2025726438362C2025726438372C202570333B0A097368722E733634200925726438392C2025726438382C2036333B0A097368722E753634200925726439302C2025726438392C2036313B0A096164642E733634200925726439312C2025726438382C2025726439303B0A097368722E733634200925726439322C2025726439312C20333B0A096E65672E733634200925726439332C2025726439323B0A096164642E733634200925726439342C2025726439322C20313B0A0973656C702E623634200925726439352C2025726439332C2025726439342C202570333B0A096D756C2E6C6F2E733634200925726439362C2025726439352C2025726438353B0A097375622E733634200925726439372C2025726437382C2025726439363B0A096D696E2E733634200925726431302C2025726439372C2025726439353B0A09736574702E6C742E73363420092570342C2025726438322C20313B0A096E65672E733634200925726439382C2025726438333B0A096164642E733634200925726439392C2025726438332C202D313B0A0973656C702E62363420092572643130302C2025726439382C2025726439392C202570343B0A097368722E73363420092572643130312C202572643130302C2036333B0A097368722E75363420092572643130322C202572643130312C2035393B0A096164642E73363420092572643130332C202572643130302C202572643130323B0A097368722E73363420092572643130342C202572643130332C20353B0A096E65672E73363420092572643130352C202572643130343B0A096164642E73363420092572643130362C202572643130342C20313B0A0973656C702E62363420092572643130372C202572643130352C202572643130362C202570343B0A096D756C2E6C6F2E73363420092572643130382C202572643130372C2025726438343B0A097375622E73363420092572643130392C2025726438332C202572643130383B0A096D696E2E733634200925726431312C202572643130392C202572643130373B0A096164642E733634200925726431322C2025726439362C2025726437363B0A096164642E733634200925726431332C202572643130382C2025726438313B0A09736574702E6C742E73363420092570352C2025726431302C20313B0A096D756C2E6C6F2E73363420092572643134332C2025726431322C20257264343B0A0973686C2E62363420092572643134342C2025726431332C20323B0A0973686C2E62363420092572643134352C20257264332C2033343B0A0973686C2E62363420092572643134362C20257264322C20323B0A09736574702E6C742E7336342009257032302C2025726431312C20313B0A0940257035206272612009244C5F5F4242305F31333B0A096D6F762E75363420092572643135312C20303B0A09616E642E62363420200925726431392C2025726431312C20373B0A09616E642E62363420200925726431352C2025726431312C202D383B0A0973686C2E62363420092572643131322C202572643134332C20323B0A096164642E73363420092572643131342C202572643131322C202572643134343B0A096164642E73363420092572643134392C2025726436302C202572643131343B0A096164642E73363420092572643135302C202572643134392C2031363B0A096F722E62363420200925726431372C202572643134352C202572643134363B0A09736574702E6C742E75363420092570372C2025726431312C20383B0A096D6F762E62333220092572392C20303B0A096272612E756E692009244C5F5F4242305F353B0A244C5F5F4242305F31323A0A096164642E73363420092572643135312C202572643135312C20313B0A096164642E73363420092572643135302C202572643135302C2025726431373B0A096164642E73363420092572643134392C202572643134392C2025726431373B0A09736574702E65712E7336342009257031312C2025726431302C202572643135313B0A094025703131206272612009244C5F5F4242305F31333B0A244C5F5F4242305F353A0A094025703230206272612009244C5F5F4242305F31323B0A096D6F762E75363420092572643135342C20303B0A0940257037206272612009244C5F5F4242305F393B0A096D6F762E75363420092572643135342C20303B0A096D6F762E75363420092572643135322C202572643135303B0A244C5F5F4242305F383A0A0973742E676C6F62616C2E75333220095B2572643135322B2D31365D2C202572393B0A0973742E676C6F62616C2E75333220095B2572643135322B2D31325D2C202572393B0A0973742E676C6F62616C2E75333220095B2572643135322B2D385D2C202572393B0A0973742E676C6F62616C2E75333220095B2572643135322B2D345D2C202572393B0A0973742E676C6F62616C2E75333220095B2572643135325D2C202572393B0A0973742E676C6F62616C2E75333220095B2572643135322B345D2C202572393B0A0973742E676C6F62616C2E75333220095B2572643135322B385D2C202572393B0A0973742E676C6F62616C2E75333220095B2572643135322B31325D2C202572393B0A096164642E73363420092572643135342C202572643135342C20383B0A096164642E73363420092572643135322C202572643135322C2033323B0A09736574702E6E652E73363420092570382C2025726431352C202572643135343B0A0940257038206272612009244C5F5F4242305F383B0A244C5F5F4242305F393A0A09736574702E65712E73363420092570392C2025726431392C20303B0A0940257039206272612009244C5F5F4242305F31323B0A0973686C2E62363420092572643131392C202572643135342C20323B0A096164642E73363420092572643135362C202572643134392C202572643131393B0A096D6F762E75363420092572643135352C2025726431393B0A244C5F5F4242305F31313A0A092E707261676D6120226E6F756E726F6C6C223B0A0973742E676C6F62616C2E75333220095B2572643135365D2C202572393B0A096164642E73363420092572643135362C202572643135362C20343B0A096164642E73363420092572643135352C202572643135352C202D313B0A09736574702E6E652E7336342009257031302C202572643135352C20303B0A094025703130206272612009244C5F5F4242305F31313B0A096272612E756E692009244C5F5F4242305F31323B0A244C5F5F4242305F31333A0A0940257031206272612009244C5F5F4242305F32353B0A096C642E706172616D2E753634200925726435392C205B6D61696E5F64697370617463685F305F6D61746D756C5F44784478445F6633325F706172616D5F305D3B0A09616E642E62363420200925726432302C2025726431312C20313B0A09616E642E62363420200925726432312C2025726431312C202D323B0A0973686C2E62363420092572643132322C202572643134332C20323B0A096164642E73363420092572643132342C202572643132322C202572643134343B0A096164642E73363420092572643132352C202572643132342C2025726436303B0A096164642E733634200925726432322C202572643132352C20343B0A096F722E62363420200925726432332C202572643134352C202572643134363B0A096164642E73363420092572643132382C202572643134342C2025726435393B0A096164642E73363420092572643135372C202572643132382C20343B0A096D6F762E75363420092572643135382C20303B0A09736574702E65712E7336342009257031352C2025726431312C20313B0A09736574702E65712E7336342009257031372C2025726432302C20303B0A096272612E756E692009244C5F5F4242305F31353B0A244C5F5F4242305F32343A0A096164642E73363420092572643135382C202572643135382C20313B0A096164642E73363420092572643135372C202572643135372C2025726432333B0A09736574702E6E652E7336342009257031392C202572643135382C20257264343B0A094025703139206272612009244C5F5F4242305F31353B0A096272612E756E692009244C5F5F4242305F32353B0A244C5F5F4242305F31353A0A0940257035206272612009244C5F5F4242305F32343B0A0973686C2E62363420092572643133302C202572643135382C20323B0A096164642E733634200925726434332C2025726435392C202572643133303B0A096D756C2E6C6F2E73363420092572643133312C202572643135382C20257264343B0A0973686C2E62363420092572643133322C202572643133312C20323B0A096164642E733634200925726434342C2025726435392C202572643133323B0A096D6F762E75363420092572643136302C20303B0A096D6F762E75363420092572643135392C2025726432323B0A096272612E756E692009244C5F5F4242305F31373B0A244C5F5F4242305F32333A0A096164642E73363420092572643136302C202572643136302C20313B0A096164642E73363420092572643135392C202572643135392C2025726432333B0A09736574702E6E652E7336342009257031382C2025726431302C202572643136303B0A094025703138206272612009244C5F5F4242305F31373B0A096272612E756E692009244C5F5F4242305F32343B0A244C5F5F4242305F31373A0A094025703230206272612009244C5F5F4242305F32333B0A096164642E73363420092572643133342C202572643136302C2025726431323B0A096D756C2E6C6F2E73363420092572643133352C202572643133342C20257264343B0A0973686C2E62363420092572643133362C202572643133352C20323B0A096164642E73363420092572643133372C2025726434332C202572643133363B0A096C642E676C6F62616C2E6E632E66333220092566312C205B2572643133375D3B0A096D6F762E75363420092572643136342C20303B0A094025703135206272612009244C5F5F4242305F32313B0A096D6F762E75363420092572643136342C20303B0A096D6F762E75363420092572643136312C202572643135373B0A096D6F762E75363420092572643136322C202572643135393B0A244C5F5F4242305F32303A0A096C642E676C6F62616C2E6E632E66333220092566322C205B2572643136312B2D345D3B0A096C642E676C6F62616C2E66333220092566332C205B2572643136322B2D345D3B0A096D756C2E726E2E66333220092566342C202566312C202566323B0A096164642E726E2E66333220092566352C202566332C202566343B0A0973742E676C6F62616C2E66333220095B2572643136322B2D345D2C202566353B0A096C642E676C6F62616C2E6E632E66333220092566362C205B2572643136315D3B0A096C642E676C6F62616C2E66333220092566372C205B2572643136325D3B0A096D756C2E726E2E66333220092566382C202566312C202566363B0A096164642E726E2E66333220092566392C202566372C202566383B0A0973742E676C6F62616C2E66333220095B2572643136325D2C202566393B0A096164642E73363420092572643136342C202572643136342C20323B0A096164642E73363420092572643136322C202572643136322C20383B0A096164642E73363420092572643136312C202572643136312C20383B0A09736574702E6E652E7336342009257031362C2025726432312C202572643136343B0A094025703136206272612009244C5F5F4242305F32303B0A244C5F5F4242305F32313A0A094025703137206272612009244C5F5F4242305F32333B0A096164642E733634200925726434372C2025726436302C202572643133363B0A096164642E73363420092572643133392C202572643136342C2025726431333B0A0973686C2E62363420092572643134302C202572643133392C20323B0A096164642E73363420092572643134312C2025726434342C202572643134303B0A096C642E676C6F62616C2E6E632E6633322009256631302C205B2572643134315D3B0A096164642E73363420092572643134322C2025726434372C202572643134303B0A096C642E676C6F62616C2E6633322009256631312C205B2572643134325D3B0A096D756C2E726E2E6633322009256631322C202566312C20256631303B0A096164642E726E2E6633322009256631332C20256631312C20256631323B0A0973742E676C6F62616C2E66333220095B2572643134325D2C20256631333B0A096272612E756E692009244C5F5F4242305F32333B0A244C5F5F4242305F32353A0A097265743B0A0A7D0A00000000E4FFFFFF08000000020000000B000000696E707574322E6D6C69720008000C00040008000E001800040008000C0010001400"> : vector<6926xi8>
  vm.rodata private @_utf8_hal_executable_format_EAB228F999C2D3A1 {alignment = 1 : i64} "hal.executable.format"
  vm.rodata private @_utf8_cuda_nvptx_fb_B15B42B96FDBACC {alignment = 1 : i64} "cuda-nvptx-fb"
  vm.rodata private @_utf8_cuda_nvptx_fb_B15B42B96FDBACC_0 {alignment = 1 : i64} "cuda-nvptx-fb"
  vm.initializer {
    %zero = vm.const.i64.zero
    %c-1 = vm.const.i64 -1
    %ref = vm.call @hal.ex.shared_device() {nosideeffects} : () -> !vm.ref<!hal.device>
    %_utf8_hal_executable_format_EAB228F999C2D3A1 = vm.const.ref.rodata @_utf8_hal_executable_format_EAB228F999C2D3A1 : !vm.buffer
    %_utf8_cuda_nvptx_fb_B15B42B96FDBACC = vm.const.ref.rodata @_utf8_cuda_nvptx_fb_B15B42B96FDBACC : !vm.buffer
    %0:2 = vm.call @hal.device.query.i64(%ref, %_utf8_hal_executable_format_EAB228F999C2D3A1, %_utf8_cuda_nvptx_fb_B15B42B96FDBACC) {nosideeffects} : (!vm.ref<!hal.device>, !vm.buffer, !vm.buffer) -> (i32, i64)
    %1 = vm.trunc.i64.i32 %0#1 : i64 -> i32
    %c1 = vm.const.i32 1
    %2 = vm.and.i32 %1, %c1 : i32
    %zero_0 = vm.const.i32.zero
    %3 = vm.select.i32 %0#0, %2, %zero_0 : i32
    %c1_1 = vm.const.i32 1
    %zero_2 = vm.const.i32.zero
    %zero_3 = vm.const.i32.zero
    %c7 = vm.const.i32 7
    %c1_4 = vm.const.i32 1
    %c1_5 = vm.const.i32 1
    %c7_6 = vm.const.i32 7
    %zero_7 = vm.const.i32.zero
    %ref_8 = vm.call.variadic @hal.descriptor_set_layout.create(%ref, %zero_2, [(%zero_3, %c7, %c1_4), (%c1_5, %c7_6, %zero_7)]) {nosideeffects} : (!vm.ref<!hal.device>, i32, tuple<i32, i32, i32> ...) -> !vm.ref<!hal.descriptor_set_layout>
    %c4 = vm.const.i32 4
    %ref_9 = vm.call.variadic @hal.pipeline_layout.create(%ref, %c4, [%ref_8]) {nosideeffects} : (!vm.ref<!hal.device>, i32, !vm.ref<!hal.descriptor_set_layout> ...) -> !vm.ref<!hal.pipeline_layout>
    %4 = vm.select.i64 %3, %zero, %c-1 : i64
    %5 = vm.trunc.i64.i32 %4 : i64 -> i32
    vm.global.store.i32 %3, @_device_query_0 : i32
    vm.global.store.ref %ref_9, @_pipeline_layout_0 : !vm.ref<!hal.pipeline_layout>
    vm.br_table %5 {
      default: ^bb2,
      0: ^bb1
    }
  ^bb1:  // pred: ^bb0
    %_pipeline_layout_0 = vm.global.load.ref @_pipeline_layout_0 : !vm.ref<!hal.pipeline_layout>
    %main_dispatch_0_cuda_nvptx_fb = vm.const.ref.rodata @main_dispatch_0_cuda_nvptx_fb : !vm.buffer
    %_utf8_cuda_nvptx_fb_B15B42B96FDBACC_0 = vm.const.ref.rodata @_utf8_cuda_nvptx_fb_B15B42B96FDBACC_0 : !vm.buffer
    %null = vm.const.ref.zero : !vm.buffer
    %ref_10 = vm.call.variadic @hal.executable.create(%ref, %_utf8_cuda_nvptx_fb_B15B42B96FDBACC_0, %main_dispatch_0_cuda_nvptx_fb, %null, [%_pipeline_layout_0]) {nosideeffects} : (!vm.ref<!hal.device>, !vm.buffer, !vm.buffer, !vm.buffer, !vm.ref<!hal.pipeline_layout> ...) -> !vm.ref<!hal.executable>
    vm.br ^bb3(%ref_10 : !vm.ref<!hal.executable>)
  ^bb2:  // pred: ^bb0
    %null_11 = vm.const.ref.zero : !vm.ref<!hal.executable>
    vm.br ^bb3(%null_11 : !vm.ref<!hal.executable>)
  ^bb3(%6: !vm.ref<!hal.executable>):  // 2 preds: ^bb1, ^bb2
    vm.global.store.ref %6, @_executable_main_dispatch_0 : !vm.ref<!hal.executable>
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
    %c32 = vm.const.i64 32
    %c128 = vm.const.i64 128
    %c553648160 = vm.const.i32 553648160
    %c1 = vm.const.i32 1
    %zero = vm.const.i64.zero
    %c4 = vm.const.i64 4
    %c32_0 = vm.const.i64 32
    %c-1 = vm.const.i64 -1
    %zero_1 = vm.const.i64.zero
    %c-1_2 = vm.const.i32 -1
    %c-1_3 = vm.const.i64 -1
    %c1_4 = vm.const.i64 1
    %_device_query_0 = vm.global.load.i32 @_device_query_0 : i32
    %_pipeline_layout_0 = vm.global.load.ref @_pipeline_layout_0 : !vm.ref<!hal.pipeline_layout>
    %_executable_main_dispatch_0 = vm.global.load.ref @_executable_main_dispatch_0 : !vm.ref<!hal.executable>
    %zero_5 = vm.const.i32.zero
    %0 = vm.call @hal.buffer_view.dim(%arg0, %zero_5) {nosideeffects} : (!vm.ref<!hal.buffer_view>, i32) -> i64
    %c1_6 = vm.const.i32 1
    %1 = vm.call @hal.buffer_view.dim(%arg0, %c1_6) {nosideeffects} : (!vm.ref<!hal.buffer_view>, i32) -> i64
    %_utf8_input_0_5FD512E67BEFDEEC = vm.const.ref.rodata @_utf8_input_0_5FD512E67BEFDEEC : !vm.buffer
    vm.call.variadic @hal.buffer_view.assert(%arg0, %_utf8_input_0_5FD512E67BEFDEEC, %c553648160, %c1, [%0, %1]) : (!vm.ref<!hal.buffer_view>, !vm.buffer, i32, i32, i64 ...)
    %2 = vm.mul.i64 %0, %c4 : i64
    %3 = vm.mul.i64 %2, %1 : i64
    %ref = vm.call @hal.buffer_view.buffer(%arg0) {nosideeffects} : (!vm.ref<!hal.buffer_view>) -> !vm.ref<!hal.buffer>
    %ref_7 = vm.call @hal.ex.shared_device() {nosideeffects} : () -> !vm.ref<!hal.device>
    %ref_8 = vm.call @hal.device.allocator(%ref_7) {nosideeffects} : (!vm.ref<!hal.device>) -> !vm.ref<!hal.allocator>
    %_utf8_tensor_3C6209B4FD120BDC = vm.const.ref.rodata @_utf8_tensor_3C6209B4FD120BDC : !vm.buffer
    %c16 = vm.const.i32 16
    %c3075 = vm.const.i32 3075
    vm.call @hal.buffer.assert(%ref, %_utf8_tensor_3C6209B4FD120BDC, %ref_8, %3, %c16, %c3075) : (!vm.ref<!hal.buffer>, !vm.buffer, !vm.ref<!hal.allocator>, i64, i32, i32) -> ()
    %null = vm.const.ref.zero : !vm.ref<!hal.fence>
    %zero_9 = vm.const.i32.zero
    %ref_10 = vm.call @hal.fence.create(%ref_7, %zero_9) : (!vm.ref<!hal.device>, i32) -> !vm.ref<!hal.fence>
    %zero_11 = vm.const.i32.zero
    %c48 = vm.const.i32 48
    %c3075_12 = vm.const.i32 3075
    %ref_13 = vm.call @hal.device.queue.alloca(%ref_7, %c-1, %null, %ref_10, %zero_11, %c48, %c3075_12, %3) : (!vm.ref<!hal.device>, i64, !vm.ref<!hal.fence>, !vm.ref<!hal.fence>, i32, i32, i32, i64) -> !vm.ref<!hal.buffer>
    %4 = vm.call.variadic @hal.fence.await(%c-1_2, [%ref_10]) : (i32, !vm.ref<!hal.fence> ...) -> i32
    %5 = vm.trunc.i64.i32 %0 : i64 -> i32
    %c32_14 = vm.const.i32 32
    %6 = vm.shr.i64.u %0, %c32_14 : i64
    %7 = vm.trunc.i64.i32 %6 : i64 -> i32
    %8 = vm.trunc.i64.i32 %1 : i64 -> i32
    %c32_15 = vm.const.i32 32
    %9 = vm.shr.i64.u %1, %c32_15 : i64
    %10 = vm.trunc.i64.i32 %9 : i64 -> i32
    %c17 = vm.const.i32 17
    %c3 = vm.const.i32 3
    %zero_16 = vm.const.i32.zero
    %ref_17 = vm.call @hal.command_buffer.create(%ref_7, %c17, %c3, %zero_16) : (!vm.ref<!hal.device>, i32, i32, i32) -> !vm.ref<!hal.command_buffer>
    %11 = vm.select.i64 %_device_query_0, %zero, %c-1_3 : i64
    %12 = vm.trunc.i64.i32 %11 : i64 -> i32
    vm.br_table %12 {
      default: ^bb2,
      0: ^bb1
    }
  ^bb1:  // pred: ^bb0
    %zero_18 = vm.const.i32.zero
    vm.call.variadic @hal.command_buffer.push_constants(%ref_17, %_pipeline_layout_0, %zero_18, [%5, %7, %8, %10]) : (!vm.ref<!hal.command_buffer>, !vm.ref<!hal.pipeline_layout>, i32, i32 ...)
    %zero_19 = vm.const.i32.zero
    %zero_20 = vm.const.i32.zero
    %zero_21 = vm.const.i32.zero
    %c1_22 = vm.const.i32 1
    vm.call.variadic @hal.command_buffer.push_descriptor_set(%ref_17, %_pipeline_layout_0, %zero_19, [(%zero_20, %zero_21, %ref, %zero, %3), (%c1_22, %zero_21, %ref_13, %zero, %3)]) : (!vm.ref<!hal.command_buffer>, !vm.ref<!hal.pipeline_layout>, i32, tuple<i32, i32, !vm.ref<!hal.buffer>, i64, i64> ...)
    %slte = vm.cmp.lte.i64.s %1, %zero : i64
    %13 = vm.sub.i64 %zero, %1 : i64
    %14 = vm.sub.i64 %1, %c1_4 : i64
    %15 = vm.select.i64 %slte, %13, %14 : i64
    %16 = vm.div.i64.s %15, %c128 : i64
    %17 = vm.sub.i64 %zero, %16 : i64
    %18 = vm.add.i64 %16, %c1_4 : i64
    %19 = vm.select.i64 %slte, %17, %18 : i64
    %slte_23 = vm.cmp.lte.i64.s %0, %zero : i64
    %20 = vm.sub.i64 %zero, %0 : i64
    %21 = vm.sub.i64 %0, %c1_4 : i64
    %22 = vm.select.i64 %slte_23, %20, %21 : i64
    %23 = vm.div.i64.s %22, %c32 : i64
    %24 = vm.sub.i64 %zero, %23 : i64
    %25 = vm.add.i64 %23, %c1_4 : i64
    %26 = vm.select.i64 %slte_23, %24, %25 : i64
    %27 = vm.mul.i64 %19, %26 : i64
    %zero_24 = vm.const.i32.zero
    %28 = vm.trunc.i64.i32 %27 : i64 -> i32
    %c1_25 = vm.const.i32 1
    %c1_26 = vm.const.i32 1
    vm.call @hal.command_buffer.dispatch(%ref_17, %_executable_main_dispatch_0, %zero_24, %28, %c1_25, %c1_26) : (!vm.ref<!hal.command_buffer>, !vm.ref<!hal.executable>, i32, i32, i32, i32) -> ()
    vm.br ^bb2
  ^bb2:  // 2 preds: ^bb0, ^bb1
    %c28 = vm.const.i32 28
    %c13 = vm.const.i32 13
    %zero_27 = vm.const.i32.zero
    vm.call @hal.command_buffer.execution_barrier(%ref_17, %c28, %c13, %zero_27) : (!vm.ref<!hal.command_buffer>, i32, i32, i32) -> ()
    vm.call @hal.command_buffer.finalize(%ref_17) : (!vm.ref<!hal.command_buffer>) -> ()
    %zero_28 = vm.const.i32.zero
    %ref_29 = vm.call @hal.fence.create(%ref_7, %zero_28) : (!vm.ref<!hal.device>, i32) -> !vm.ref<!hal.fence>
    %29 = vm.call.variadic @hal.fence.await(%c-1_2, [%ref_10]) : (i32, !vm.ref<!hal.fence> ...) -> i32
    vm.call.variadic @hal.device.queue.execute(%ref_7, %c-1, %null, %ref_29, [%ref_17]) : (!vm.ref<!hal.device>, i64, !vm.ref<!hal.fence>, !vm.ref<!hal.fence>, !vm.ref<!hal.command_buffer> ...)
    %30 = vm.call.variadic @hal.fence.await(%c-1_2, [%ref_29]) : (i32, !vm.ref<!hal.fence> ...) -> i32
    vm.cond_fail %30, "failed to wait on timepoint"
    %ref_30 = vm.call.variadic @hal.buffer_view.create(%ref_13, %zero, %3, %c553648160, %c1, [%0, %1]) {nosideeffects} : (!vm.ref<!hal.buffer>, i64, i64, i32, i32, i64 ...) -> !vm.ref<!hal.buffer_view>
    vm.return %ref_30 : !vm.ref<!hal.buffer_view>
  }
  vm.export @main attributes {iree.abi.stub}
}

