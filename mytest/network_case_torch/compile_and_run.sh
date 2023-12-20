#!/bin/bash

echo -e "\n\n\n\n\n------------- RUN AlexNet -------------\n\n\n\n\n"
echo -e "\n\n------ run cuda ------\n\n"
../../iree-build/tools/iree-compile --iree-input-type=torch --iree-hal-target-backends=cuda alexnet.mlir -o tmp.vmfb --iree-hal-cuda-llvm-target-arch=sm_75 --iree-hal-cuda-llvm-target-feature="+ptx75" # --iree-hal-cuda-dump-ptx
../../iree-build/tools/iree-run-module --module=tmp.vmfb --device=cuda --input="1x3x224x224xf32=1.0" --output_max_element_count=10

echo -e "\n\n------ run cpu ------\n\n"
../../iree-build/tools/iree-compile --iree-input-type=torch --iree-hal-target-backends=llvm-cpu alexnet.mlir -o tmp.vmfb
../../iree-build/tools/iree-run-module --module=tmp.vmfb --device=local-task --input="1x3x224x224xf32=1.0" --output_max_element_count=10


echo -e "\n\n\n\n\n------------- RUN AlexNet -------------\n\n\n\n\n"
echo -e "\n\n------ run cuda ------\n\n"
../../iree-build/tools/iree-compile --iree-input-type=torch --iree-hal-target-backends=cuda lenet.mlir -o tmp.vmfb --iree-hal-cuda-llvm-target-arch=sm_75 --iree-hal-cuda-llvm-target-feature="+ptx75" # --iree-hal-cuda-dump-ptx
../../iree-build/tools/iree-run-module --module=tmp.vmfb --device=cuda --input="1x1x32x32xf32=1.0" --output_max_element_count=10

echo -e "\n\n------ run cpu ------\n\n"
../../iree-build/tools/iree-compile --iree-input-type=torch --iree-hal-target-backends=llvm-cpu lenet.mlir -o tmp.vmfb
../../iree-build/tools/iree-run-module --module=tmp.vmfb --device=local-task --input="1x1x32x32xf32=1.0" --output_max_element_count=10


# sudo /usr/local/cuda-11.5/bin/ncu --target-processes all ./compile_and_run.sh