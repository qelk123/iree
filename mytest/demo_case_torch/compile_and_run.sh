#!/bin/bash
../../iree-build/tools/iree-compile --iree-input-type=torch --iree-hal-target-backends=cuda input.mlir -o tmp.vmfb --mlir-print-ir-after-all --iree-hal-cuda-dump-ptx --iree-hal-cuda-llvm-target-arch=sm_75 --iree-hal-cuda-llvm-target-feature="+ptx75" -debug-only iree-flow-form-dispatch-regions
../../iree-build/tools/iree-run-module --module=tmp.vmfb --device=cuda --input="4xf32=[1.0, 2.0, 3.0, 4.0]"


../../iree-build/tools/iree-compile --iree-input-type=torch --iree-hal-target-backends=llvm-cpu input.mlir -o tmp.vmfb
../../iree-build/tools/iree-run-module --module=tmp.vmfb --device=local-task --input="4xf32=[1.0, 2.0, 3.0, 4.0]"

# ../../iree-build-2/tools/iree-compile --iree-input-type=torch --iree-hal-target-backends=cuda input.mlir -o tmp.vmfb --mlir-print-ir-after-all --iree-hal-cuda-dump-ptx --iree-hal-cuda-llvm-target-arch=sm_75 --iree-hal-cuda-llvm-target-feature="+ptx75" -debug

# gdb --args ../../iree-build-2/tools/iree-compile --iree-input-type=torch --iree-hal-target-backends=cuda input.mlir -o tmp.vmfb --iree
# -hal-cuda-dump-ptx --iree-hal-cuda-llvm-target-arch=sm_75 --iree-hal-cuda-llvm-target-feature="+ptx75" -debug-only iree-flow-form-dispatch-regions

# gdb --args ../../iree-build/tools/iree-run-module --module=tmp.vmfb --device=cuda --input="4xf32=[1.0, 2.0, 3.0, 4.0]"


# sudo /usr/local/cuda-11.5/bin/ncu --target-processes all ./compile_and_run.sh