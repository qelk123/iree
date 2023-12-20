#!/bin/bash
echo "--------- RUN_GPU ---------"
../../iree-build/tools/iree-compile --iree-hal-target-backends=cuda input.mlir -o tmp.vmfb --iree-hal-cuda-dump-ptx --iree-hal-cuda-llvm-target-arch=sm_75 --iree-hal-cuda-llvm-target-feature="+ptx75"
../../iree-build/tools/iree-run-module --device=cuda --module=tmp.vmfb --input=10xi32=2 --input=10xi32=4

echo "--------- RUN_CPU ---------"
../../iree-build/tools/iree-compile --iree-hal-target-backends=llvm-cpu input.mlir -o tmp.vmfb
../../iree-build/tools/iree-run-module --module=tmp.vmfb --input=10xi32=2 --input=10xi32=4