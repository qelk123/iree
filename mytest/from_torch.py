import iree.runtime as ireert
import numpy as np
import shark_turbine.aot as aot
import torch

# Define the `nn.Module` to export.
class LinearModule(torch.nn.Module):
  def __init__(self, in_features, out_features):
    super().__init__()
    self.weight = torch.nn.Parameter(torch.randn(in_features, out_features))
    self.bias = torch.nn.Parameter(torch.randn(out_features))

  def forward(self, input):
    return (input @ self.weight) + self.bias

linear_module = LinearModule(4, 3)

# Export the program using the simple API.
example_arg = torch.randn(4)
export_output = aot.export(linear_module, example_arg)

# Compile to a deployable artifact.
binary = export_output.compile(save_to=None)

# Use the IREE runtime API to test the compiled program.
config = ireert.Config("local-task")
vm_module = ireert.load_vm_module(
    ireert.VmModule.wrap_buffer(config.vm_instance, binary.map_memory()),
    config,
)
input = np.array([1.0, 2.0, 3.0, 4.0], dtype=np.float32)
result = vm_module.main(input)
print(result.to_host())