add_mlir_library(IREELinalgExtPasses
  ConvertConv2DToWinograd.cpp
  ConvertToLoops.cpp
  PadContractionToBlockSize.cpp
  Passes.cpp
  SplitReduction.cpp
  TileAndDecomposeAttention.cpp
  TileAndDecomposeWinogradPass.cpp
  Tiling.cpp

  DEPENDS
  IREELinalgExtPassesIncGen

  LINK_LIBS PUBLIC
  IREEInputDialect
  IREELinalgExtDialect
  IREELinalgExtUtils
  MLIRAffineDialect
  MLIRIR
  MLIRLinalgDialect
  MLIRLinalgTransforms
  MLIRMathDialect
  MLIRMemRefDialect
  MLIRMemRefTransforms
  MLIRPass
  MLIRSCFDialect
  MLIRFuncDialect
  MLIRSupport
  MLIRTensorDialect
  MLIRTransforms
)
