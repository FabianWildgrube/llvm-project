//=== RISCW.h - Top-level interface for RISCW representation ----*- C++ -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the entry points for global functions defined in
// the LLVM RISCW backend.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_RISCW_RISCW_H
#define LLVM_LIB_TARGET_RISCW_RISCW_H

namespace llvm {
class FunctionPass;
class PassRegistry;
class RISCWTargetMachine;
enum class CodeGenOptLevel;

// Declare functions to create passes here!
FunctionPass* createRISCWISelDag(RISCWTargetMachine& TM, CodeGenOptLevel OptLevel);

void initializeRISCWDAGToDAGISelLegacyPass(PassRegistry &);

} // namespace llvm

#endif // end LLVM_LIB_TARGET_RISCW_RISCW_H