import torch
print("\nInstalled PyTorch, version:", torch.__version__)

# ## Sample AOT workflow
# 
# 1. Define a program using `torch.nn.Module`
# 2. Export the program using `aot.export()`
# 3. Compile to a deployable artifact
#   * a: By staying within a Python session
#   * b: By outputting MLIR and continuing using native tools
# 
# Useful documentation:
# 
# * [PyTorch Modules](https://pytorch.org/docs/stable/notes/modules.html) (`nn.Module`) as building blocks for stateful computation
# * IREE compiler and runtime [Python bindings](https://www.iree.dev/reference/bindings/python/)

torch.manual_seed(0)

class LinearModule(torch.nn.Module):
  def __init__(self, in_features, out_features):
    super().__init__()
    self.weight = torch.nn.Parameter(torch.randn(in_features, out_features))
    self.bias = torch.nn.Parameter(torch.randn(out_features))

  def forward(self, input):
    return (input @ self.weight) + self.bias

linear_module = LinearModule(4, 3)

#@title 2. Export the program using `aot.export()`
import shark_turbine.aot as aot

example_arg = torch.randn(4)
export_output = aot.export(linear_module, example_arg)
print(type(export_output))

#@title 3a. Compile fully to a deployable artifact, in our existing Python session

# Staying in Python gives the API a chance to reuse memory, improving
# performance when compiling large programs.

compiled_binary = export_output.compile(save_to=None)

# Use the IREE runtime API to test the compiled program.
import numpy as np
import iree.runtime as ireert
print(ireert.__file__)

config = ireert.Config("local-task")
vm_module = ireert.load_vm_module(
    ireert.VmModule.wrap_buffer(config.vm_instance, compiled_binary.map_memory()),
    config,
)

input = np.array([1.0, 2.0, 3.0, 4.0], dtype=np.float32)
result = vm_module.main(input)
print("result:", result.to_host())



#@title 3b. Output MLIR then continue from Python or native tools later

# Leaving Python allows for file system checkpointing and grants access to
# native development workflows.

mlir_file_path = "./mytest/linear_module_pytorch.mlir"
# vmfb_file_path = "/tmp/linear_module_pytorch_llvmcpu.vmfb"

export_output.print_readable()
export_output.save_mlir(mlir_file_path)

# !iree-compile --iree-input-type=torch --iree-hal-target-backends=llvm-cpu {mlir_file_path} -o {vmfb_file_path}
# !iree-run-module --module={vmfb_file_path} --device=local-task --input="4xf32=[1.0, 2.0, 3.0, 4.0]"


