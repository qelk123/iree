import os
import subprocess
def split_and_save_string(string: str, output_directory):
  segments = string.split("// -----// IR Dump After ")
  last_segment_name = None
  for i, segment in enumerate(segments):
    seg = segment.split("//----- //")
    if len(seg) != 2:
      continue
    name, body = seg
    filename = f"{output_directory}/{i}_{name}.mlir"
    with open(filename, "w") as file:
      file.write(body)
    # if last_segment_name:
    #   diff_filename = f"{output_directory}/diff/{last_segment_name.split('/')[-1].split('_')[0]}_{i}.mlir"
    #   command = f"diff \"{filename}\" \"{last_segment_name}\""
    #   print(command)
    #   result = subprocess.check_output(command, shell=True)

    #   # Decode the bytes to string (if needed)
    #   output_str = result.decode("utf-8")
    #   with open(diff_filename, "w") as file:
    #     file.write(output_str)
    # last_segment_name = filename

def read_file(file_path):
  with open(file_path, "r") as file:
    content = file.read()
  return content

file_path = "/home/data/liuyn/code/iree/mytest/demo_case_torch/gpu2.log"  # Replace with the actual file path
file_content = read_file(file_path)

split_and_save_string(file_content, "/home/data/liuyn/code/iree/mytest/demo_case_torch/gpu2")