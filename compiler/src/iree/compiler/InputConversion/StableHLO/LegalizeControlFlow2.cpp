// Copyright 2019 The IREE Authors
//
// Licensed under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

// Implements logic for lowering StableHLO dialect ops to the SCF dialect.

#include "iree/compiler/InputConversion/StableHLO/Passes.h"
#include "iree/compiler/InputConversion/StableHLO/Rewriters.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/SCF/IR/SCF.h"
#include "mlir/Dialect/Tensor/IR/Tensor.h"
#include "mlir/IR/BuiltinTypes.h"
#include "mlir/IR/Value.h"
#include "stablehlo/dialect/StablehloOps.h"
#include "mlir/Transforms/GreedyPatternRewriteDriver.h"

namespace mlir::iree_compiler::stablehlo {

#define GEN_PASS_DEF_LEGALIZECONTROLFLOW2
#include "iree/compiler/InputConversion/StableHLO/Passes.h.inc"

namespace {

// Rewrites `stablehlo.add` to `stablehlo.sub`.
struct AddOpPattern final : public RewritePattern {
  AddOpPattern(MLIRContext *context,
                PatternBenefit benefit = 1)
      : RewritePattern(MatchAnyOpTypeTag(), benefit, context) {}
  LogicalResult
  matchAndRewrite(Operation *op,
                  PatternRewriter &rewriter) const override {
    mlir::stablehlo::AddOp or_op = dyn_cast<mlir::stablehlo::AddOp>(op);
    if (!or_op) {
      return failure();
    }
    auto lhs_v = or_op->getOperand(0);
    auto mul_op = dyn_cast_or_null<mlir::stablehlo::MulOp>(lhs_v.getDefiningOp());
    if (!mul_op) {
      return failure();
    }

    auto new_add_op = rewriter.create<mlir::stablehlo::AddOp>(
        or_op->getLoc(),
        mul_op.getLhs(), mul_op.getRhs());
    
    auto new_mul_op = rewriter.create<mlir::stablehlo::MulOp>(
        or_op->getLoc(),
        new_add_op.getResult(), or_op->getOperand(1));

    rewriter.replaceOp(or_op, new_mul_op.getResult());
    return success();
  }
};

struct LegalizeControlFlow2 final
    : impl::LegalizeControlFlow2Base<LegalizeControlFlow2> {
  void getDependentDialects(DialectRegistry &registry) const override {
    registry.insert<scf::SCFDialect, tensor::TensorDialect>();
  }

  void runOnOperation() override {
    func::FuncOp f = getOperation();
    MLIRContext *ctx = f.getContext();

    RewritePatternSet patterns(ctx);
    populateLegalizeControlFlow2Patterns(ctx, &patterns);


    if (failed(applyPatternsAndFoldGreedily(f, std::move(patterns)))) {
      signalPassFailure();
    }
  }
};
} // namespace

void populateLegalizeControlFlow2Patterns(MLIRContext *context,
                                         RewritePatternSet *patterns) {
  patterns->add<AddOpPattern>(context);
}

} // namespace mlir::iree_compiler::stablehlo
