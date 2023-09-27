; RUN: llc -mtriple=amdgcn--amdpal -mcpu=gfx1100 -mattr=-xnack -verify-machineinstrs < %s | FileCheck -check-prefixes=GCN -enable-var-scope %s

; TODO: write a amdgpu_cs function that calls some other functions
; Make sure to copy the nr of gprs from the failing example in AnyDSL
; Check that the rsrc1 register and the kernel info gpr counts fit together
; This should fail initially and be fixed by my change.

; GCN: amdpal.pipelines:
; GCN-NEXT:  - .registers:
; GCN-NEXT:      0x2e12 (COMPUTE_PGM_RSRC1): 0xaf01ca{{$}}
; GCN-NEXT:      0x2e13 (COMPUTE_PGM_RSRC2): 0x8001{{$}}
; GCN-NEXT:    .shader_functions:
; GCN-NEXT:      dynamic_stack:
; GCN-NEXT:        .lds_size:       0{{$}}
; GCN-NEXT:        .sgpr_count:     0x28{{$}}
; GCN-NEXT:        .stack_frame_size_in_bytes: 0x10{{$}}
; SDAG-NEXT:        .vgpr_count:     0x2{{$}}
; GISEL-NEXT:        .vgpr_count:     0x3{{$}}
; GCN-NEXT:      dynamic_stack_loop:
; GCN-NEXT:        .lds_size:       0{{$}}
; SDAG-NEXT:        .sgpr_count:     0x25{{$}}
; GISEL-NEXT:        .sgpr_count:     0x26{{$}}
; GCN-NEXT:        .stack_frame_size_in_bytes: 0x10{{$}}
; SDAG-NEXT:        .vgpr_count:     0x3{{$}}
; GISEL-NEXT:        .vgpr_count:     0x4{{$}}
; GCN-NEXT:      multiple_stack:
; GCN-NEXT:        .lds_size:       0{{$}}
; GCN-NEXT:        .sgpr_count:     0x21{{$}}
; GCN-NEXT:        .stack_frame_size_in_bytes: 0x24{{$}}
; GCN-NEXT:        .vgpr_count:     0x3{{$}}
; GCN-NEXT:      no_stack:
; GCN-NEXT:        .lds_size:       0{{$}}
; GCN-NEXT:        .sgpr_count:     0x20{{$}}
; GCN-NEXT:        .stack_frame_size_in_bytes: 0{{$}}
; GCN-NEXT:        .vgpr_count:     0x1{{$}}
; GCN-NEXT:      no_stack_call:
; GCN-NEXT:        .lds_size:       0{{$}}
; GCN-NEXT:        .sgpr_count:     0x25{{$}}
; GCN-NEXT:        .stack_frame_size_in_bytes: 0x10{{$}}
; GCN-NEXT:        .vgpr_count:     0x3{{$}}
; GCN-NEXT:      no_stack_extern_call:
; GCN-NEXT:        .lds_size:       0{{$}}
; GFX8-NEXT:        .sgpr_count:     0x28{{$}}
; GFX9-NEXT:        .sgpr_count:     0x2c{{$}}
; GCN-NEXT:        .stack_frame_size_in_bytes: 0x10{{$}}
; GCN-NEXT:        .vgpr_count:    0x2b{{$}}
; GCN-NEXT:      no_stack_extern_call_many_args:
; GCN-NEXT:        .lds_size:       0{{$}}
; GFX8-NEXT:        .sgpr_count:     0x28{{$}}
; GFX9-NEXT:        .sgpr_count:     0x2c{{$}}
; GCN-NEXT:        .stack_frame_size_in_bytes: 0x90{{$}}
; GCN-NEXT:        .vgpr_count:     0x2b{{$}}
; GCN-NEXT:      no_stack_indirect_call:
; GCN-NEXT:        .lds_size:       0{{$}}
; GFX8-NEXT:        .sgpr_count:     0x28{{$}}
; GFX9-NEXT:        .sgpr_count:     0x2c{{$}}
; GCN-NEXT:        .stack_frame_size_in_bytes: 0x10{{$}}
; GCN-NEXT:        .vgpr_count:     0x2b{{$}}
; GCN-NEXT:      simple_lds:
; GCN-NEXT:        .lds_size:       0x100{{$}}
; GCN-NEXT:        .sgpr_count:     0x20{{$}}
; GCN-NEXT:        .stack_frame_size_in_bytes: 0{{$}}
; GCN-NEXT:        .vgpr_count:     0x1{{$}}
; GCN-NEXT:      simple_lds_recurse:
; GCN-NEXT:        .lds_size:       0x100{{$}}
; GCN-NEXT:        .sgpr_count:     0x28{{$}}
; GCN-NEXT:        .stack_frame_size_in_bytes: 0x10{{$}}
; GCN-NEXT:        .vgpr_count:     0x29{{$}}
; GCN-NEXT:      simple_stack:
; GCN-NEXT:        .lds_size:       0{{$}}
; GCN-NEXT:        .sgpr_count:     0x21{{$}}
; GCN-NEXT:        .stack_frame_size_in_bytes: 0x14{{$}}
; GCN-NEXT:        .vgpr_count:     0x2{{$}}
; GCN-NEXT:      simple_stack_call:
; GCN-NEXT:        .lds_size:       0{{$}}
; GCN-NEXT:        .sgpr_count:     0x25{{$}}
; GCN-NEXT:        .stack_frame_size_in_bytes: 0x20{{$}}
; GCN-NEXT:        .vgpr_count:     0x4{{$}}
; GCN-NEXT:      simple_stack_extern_call:
; GCN-NEXT:        .lds_size:       0{{$}}
; GFX8-NEXT:        .sgpr_count:     0x28{{$}}
; GFX9-NEXT:        .sgpr_count:     0x2c{{$}}
; GCN-NEXT:        .stack_frame_size_in_bytes: 0x20{{$}}
; GCN-NEXT:        .vgpr_count:     0x2b{{$}}
; GCN-NEXT:      simple_stack_indirect_call:
; GCN-NEXT:        .lds_size:       0{{$}}
; GFX8-NEXT:        .sgpr_count:     0x28{{$}}
; GFX9-NEXT:        .sgpr_count:     0x2c{{$}}
; GCN-NEXT:        .stack_frame_size_in_bytes: 0x20{{$}}
; GCN-NEXT:        .vgpr_count:     0x2b{{$}}
; GCN-NEXT:      simple_stack_recurse:
; GCN-NEXT:        .lds_size:       0{{$}}
; GCN-NEXT:        .sgpr_count:     0x28{{$}}
; GCN-NEXT:        .stack_frame_size_in_bytes: 0x20{{$}}
; GCN-NEXT:        .vgpr_count:     0x2a{{$}}
; GCN-NEXT: ...
