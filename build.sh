export PATH=/usr/local/cuda-11.5/bin/:$PATH

/home/liuyn/env/cmake-3.28.1-linux-x86_64/bin/cmake \
-GNinja  \
-B ./iree-build-2 \
-S . \
-DCMAKE_BUILD_TYPE=Debug \
-DIREE_ENABLE_ASSERTIONS=ON \
-DCMAKE_C_COMPILER=/home/liuyn/env/clang+llvm-16.0.0-x86_64-linux-gnu-ubuntu-18.04/bin/clang \
-DCMAKE_CXX_COMPILER=/home/liuyn/env/clang+llvm-16.0.0-x86_64-linux-gnu-ubuntu-18.04/bin/clang++ \
-DCUDAToolkit_ROOT=/usr/local/cuda-11.5 \
-DCUDAToolkit_LIBRARY_ROOT=/usr/local/cuda-11.5 \
-DCUDAToolkit_BIN_DIR=/usr/local/cuda-11.5/bin
# -DIREE_BUILD_PYTHON_BINDINGS=ON \
# -DPython3_EXECUTABLE="$(which python)"