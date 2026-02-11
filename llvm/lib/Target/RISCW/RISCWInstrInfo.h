//===-- RISCWInstrInfo.h - RISCW Instruction Information ----------*- C++
//-*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file contains the RISCW implementation of the TargetInstrInfo class.
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_LIB_TARGET_RISCW_RISCWINSTRINFO_H
#define LLVM_LIB_TARGET_RISCW_RISCWINSTRINFO_H

#include "RISCW.h"
#include "RISCWRegisterInfo.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/CodeGen/TargetInstrInfo.h"

#define GET_INSTRINFO_HEADER
#include "RISCWGenInstrInfo.inc"

namespace llvm {

class RISCWSubtarget;

class RISCWInstrInfo : public RISCWGenInstrInfo {
  const RISCWRegisterInfo RegInfo;

public:
  explicit RISCWInstrInfo(const RISCWSubtarget &STI);

  const RISCWRegisterInfo &getRegisterInfo() const { return RegInfo; }

protected:
  const RISCWSubtarget &STI;
};
} // namespace llvm

#endif // end LLVM_LIB_TARGET_RISCW_RISCWINSTRINFO_H