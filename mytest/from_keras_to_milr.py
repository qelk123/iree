import os  
  
# set CUDA_HOME environment variable  
os.environ["CUDA_HOME"] = "/usr/local/cuda-11.3"  
  
# # add CUDA lib64 to LD_LIBRARY_PATH  
# os.environ["LD_LIBRARY_PATH"] = f'/usr/local/cuda-11.3/lib64:{os.environ["LD_LIBRARY_PATH"]}'  

import tensorflow as tf  
from tensorflow.python.framework import convert_to_constants  
os.environ['CUDA_VISIBLE_DEVICES'] = '-1'
from tensorflow.keras import layers  
  
# 定义一个Lambda层，该层将执行矩阵乘法操作  
matmul_layer = layers.Lambda(lambda x: tf.matmul(x[0], x[1]))  
  
# 创建一个输入层，它接受两个形状为(None, None)的张量（表示任意数量的矩阵）  
input_1 = tf.keras.Input(shape=(3, 4))  
input_2 = tf.keras.Input(shape=(4, 5))  
  
# 用输入层和Lambda层创建模型  
output = matmul_layer([input_1, input_2])  
model = tf.keras.Model(inputs=[input_1, input_2], outputs=output)  
  
# # 保存模型  
# model.save('/path/to/save/model')  

# # Load your Keras model  
# model = tf.keras.models.load_model('/home/v-yinuoliu/code/iree/mytest/tf_model.keras')  
  
# Convert Keras model to ConcreteFunction  
full_model = tf.function(lambda x: model(x))  
full_model = full_model.get_concrete_function(  
    [tf.TensorSpec(model.inputs[0].shape, model.inputs[0].dtype),
    tf.TensorSpec(model.inputs[1].shape, model.inputs[1].dtype)])  
  
# Get frozen ConcreteFunction  
frozen_func = convert_to_constants.convert_variables_to_constants_v2(full_model)  
# 创建一个TensorBoard日志文件  
writer = tf.summary.create_file_writer("/home/v-yinuoliu/code/iree/mytest/f_f")  
  
# 将计算图写入到日志文件中  
with writer.as_default():  
    tf.summary.graph(frozen_func.graph)  
  
# 关闭日志文件  
writer.close()  
graph_def = frozen_func.graph.as_graph_def()  
print(graph_def)
  
# Convert the GraphDef to MLIR  
mlir_module = tf.mlir.experimental.convert_graph_def(graph_def)  
  
# Print the MLIR module  
print(mlir_module)  