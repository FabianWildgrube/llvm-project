//===-- RISCWISelDAGToDAG.cpp - A Dag to Dag Inst Selector for RISCW ------===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//
//
// This file defines an instruction selector for the RISCW target.
//
//===----------------------------------------------------------------------===//

#include "RISCWSubtarget.h"
#include "RISCWTargetMachine.h"
#include "MCTargetDesc/RISCWMCTargetDesc.h"
#include "llvm/CodeGen/MachineFunction.h"
#include "llvm/CodeGen/SelectionDAGISel.h"

using namespace llvm;

#define DEBUG_TYPE "riscw-isel"
#define PASS_NAME "RISCW DAG->DAG Pattern Instruction Selection"

namespace {
  class RISCWDAGToDAGISel : public SelectionDAGISel {
public:
    explicit RISCWDAGToDAGISel(RISCWTargetMachine &TM, CodeGenOptLevel OL)
      : SelectionDAGISel(TM, OL), Subtarget(nullptr) {}

  bool runOnMachineFunction(MachineFunction &MF) override;

  void Select(SDNode *Node) override;

#include "RISCWGenDAGISel.inc"

private:
  const RISCWSubtarget *Subtarget;
};

bool RISCWDAGToDAGISel::runOnMachineFunction(MachineFunction &MF) {
  Subtarget = &static_cast<const RISCWSubtarget &>(MF.getSubtarget());
  return SelectionDAGISel::runOnMachineFunction(MF);
}

void RISCWDAGToDAGISel::Select(SDNode *Node) {
  unsigned Opcode = Node->getOpcode();

  // If we have a custom node, we already have selected!
  if (Node->isMachineOpcode()) {
    LLVM_DEBUG(errs() << "== "; Node->dump(CurDAG); errs() << "\n");
    Node->setNodeId(-1);
    return;
  }

  // Instruction Selection not handled by the auto-generated tablegen selection
  // should be handled here.
  switch (Opcode) {
  default:
    break;
  }

  // Select the default instruction
  SelectCode(Node);
}

class RISCWDAGToDAGISelLegacy : public SelectionDAGISelLegacy {
public:
    static char ID;

    RISCWDAGToDAGISelLegacy(RISCWTargetMachine& TM, CodeGenOptLevel OL)
      : SelectionDAGISelLegacy(ID, std::make_unique<RISCWDAGToDAGISel>(TM, OL)) {}
};
}

char RISCWDAGToDAGISelLegacy::ID = 0;

INITIALIZE_PASS(RISCWDAGToDAGISelLegacy, DEBUG_TYPE, PASS_NAME, false, false)

FunctionPass* llvm::createRISCWISelDag(RISCWTargetMachine& TM, CodeGenOptLevel OptLevel) {
  return new RISCWDAGToDAGISelLegacy(TM, OptLevel);
}