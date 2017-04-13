# File: 64_operations.s
# Date: 26, April, 2016
# Usage: Emulate 64-bit operations on ARM Cortex-M4

# Convention: The 64 bit operands are stored in the following format.
# 0x12345678ffff0000 is stored as:
#
# content:       0x12345678    0xffff0000
# memory addr:      (high) <---> (low)

# =============================================================================
# Code section
# =============================================================================
        .text
# =============================================================================
# Procedure: AND_64
# Arguments:
#       two 64 bit integers x and y
#       1. lower 32 bit of x: R0
#       2. higher 32 bit of x: R1
#       3. lower 32 bit of y: R2
#       4. higher 32 bit of y: R3
# Global variables: none
# Return value:
#       x & y
#       1. lower 32 bit of the result: R0
#       2. higher 32 bit of the result: R1
# Used registers: R0, R1, R2, R3
# =============================================================================
        .global AND_64
        .type AND_64 STT_FUNC
AND_64:
    AND         r0,     r0,     r2      @ lower half
    AND         r1,     r1,     r3      @ higher half
    BX          lr                      @ return
# =============================================================================
# Procedure: XOR_64
# Arguments:
#       two 64 bit integers x and y
#       1. lower 32 bit of x: R0
#       2. higher 32 bit of x: R1
#       3. lower 32 bit of y: R2
#       4. higher 32 bit of y: R3
# Global variables: none
# Return value:
#       x ^ y
#       1. lower 32 bit of the result: R0
#       2. higher 32 bit of the result: R1
# Used registers: R0, R1, R2, R3
# =============================================================================
        .global XOR_64
        .type XOR_64 STT_FUNC
XOR_64:
    EOR         r0,     r0,     r2      @ lower half
    EOR         r1,     r1,     r3      @ higher half
    BX          lr                      @ return
# =============================================================================
# Procedure: LSR_64
# Arguments:
#       64 bit integers x
#       1. lower 32 bit of x: R0
#       2. higher 32 bit of x: R1
#       3. shift offset: R2
# Global variables: none
# Return value:
#       x >> offset
#       1. lower 32 bit of the result: R0
#       2. higher 32 bit of the result: R1
# Used registers: R0, R1, R2, R3, R4
# =============================================================================
        .global LSR_64
        .type LSR_64 STT_FUNC
LSR_64:
    PUSH        {r4}                    @ save R4
# if offset >= 64, result is 0
    CMP         r2,     #64
    BLT         LSR_64_LT_64      
    MOV         r0,     #0
    MOV         r1,     #0
    B           LSR_64_RETURN
LSR_64_LT_64: # if offset >= 32
    CMP         r2,     #32
    BLT         LSR_64_LT_32
    mov         r0,     r1
    mov         r1,     #0              @ the higher half is all shifted
    SUB         r2,     r2,     #32     @ shifted 32 bits already
    LSR         r0,     r0,     r2      @ continue
    B           LSR_64_RETURN
LSR_64_LT_32: # if offset < 32
    MOV         r4,     #32
    SUB         r4,     r4,     r2      @ 32 - offset(the num of dropped bits)
    MOV         r3,     r1
    LSL         r3,     r3,     r4      @ prepare mask
    LSR         r0,     r0,     r2
    ORR         r0,     r0,     r3      @ the lower half
    LSR         r1,     r1,     r2      @ the higher half
LSR_64_RETURN:
    POP         {r4}                    @ restore R4
    BX          lr
# =============================================================================
# Procedure: LSL_64
# Arguments:
#       64 bit integers x
#       1. lower 32 bit of x: R0
#       2. higher 32 bit of x: R1
#       3. shift offset: R2
# Global variables: none
# Return value:
#       x << offset
#       1. lower 32 bit of the result: R0
#       2. higher 32 bit of the result: R1
# Used registers: R0, R1, R2, R3, R4
# =============================================================================
        .global LSL_64
        .type LSL_64 STT_FUNC
LSL_64:
    PUSH        {r4}                    @ save R4
# if offset >= 64, result is 0
    CMP         r2,     #64
    BLT         LSL_64_LT_64      
    MOV         r0,     #0
    MOV         r1,     #0
    B           LSL_64_RETURN
LSL_64_LT_64: # if offset >= 32
    CMP         r2,     #32
    BLT         LSL_64_LT_32
    MOV         r1,     r0
    MOV         r0,     #0              @ the lower half is all shifted
    SUB         r2,     r2,     #32     @ shifted 32 bit already
    LSL         r1,     r1,     r2      @ finish the rest
    B           LSL_64_RETURN
LSL_64_LT_32: # if offset < 32
    MOV         r4,     #32
    SUB         r4,     r4,     r2      @ 32 - offset(the num of dropped bits)
    MOV         r3,     r0
    LSR         r3,     r3,     r4      @ prepare mask
    LSL         r1,     r1,     r2      @ higher half
    ORR         r1,     r1,     r3      @ fill in the missing lower bits
    LSL         r0,     r0,     r2      @ lower half
LSL_64_RETURN:
    POP         {r4}                    @ restore R4
    BX          lr
