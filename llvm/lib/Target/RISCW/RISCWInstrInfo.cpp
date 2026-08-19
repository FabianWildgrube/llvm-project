//===-- RISCWInstrInfo.cpp - RISCW Instruction Information ----------------===//
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

#include "RISCWInstrInfo.h"

#include "RISCWMachineFunction.h"
#include "RISCWTargetMachine.h"
#include "MCTargetDesc/RISCWMCTargetDesc.h"
#include "llvm/ADT/STLExtras.h"
#include "llvm/CodeGen/MachineInstrBuilder.h"
#include "llvm/MC/TargetRegistry.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/ErrorHandling.h"

using namespace llvm;

#define DEBUG_TYPE "riscw-instrinfo"

#define GET_INSTRINFO_CTOR_DTOR
#include "RISCWGenInstrInfo.inc"

RISCWInstrInfo::RISCWInstrInfo(const RISCWSubtarget &STI)
    : RISCWGenInstrInfo(STI, RegInfo, RISCW::ADJCALLSTACKDOWN,
                        RISCW::ADJCALLSTACKUP),
      RegInfo(STI.getHwMode()), STI(STI) {}