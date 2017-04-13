# File: joltik.s
# Date: 24, April, 2016
# Usage: Joltik.c implementation on ARM Cortex-M4, optimized for code size

        .align 2
        .thumb
# =============================================================================
# Code section
# =============================================================================
        .text
# =============================================================================
# Procedure: set nonce in the tweak
# Arguments:
#   1. addr to tweak, stored in R0
#   2. addr to nonce, stored in R1
# Global variables: none
# Return value: none
# Used registers: R0, R1, R2, R3, R4, R5
# =============================================================================
# TODO: use a loop to minimize the size
set_nonce_in_tweak:
# tweak[0] = (tweak[0]&0xf0) ^ (nonce[0] >> 4)
    PUSH        {r4-r5}                 @ save the content of R4-R5
    LDRB        r2,     [r0]            @ load tweak[0]
    MOV         r5,     #0xf0
    AND         r2,     r2,     r5      @ tweak[0] & 0xf0
    LDRB        r3,     [r1]            @ load nonce[0]
    ADD         r1,     r1,     #1
    LSR         r4,     r3,     #4      @ nonce[0] >> 4
    EOR         r4,     r2,     r4
    STRB        r4,     [r0]            @ store to tweak[0]
    ADD         r0,     r0,     #1
# tweak[1] = ((nonce[0]&0xf) << 4) ^ (nonce[1] >> 4)
    LSR         r5,     r5,     #4      @ now R5 holds 0xf
    LDRB        r2,     [r1]            @ load nonce[1]
    ADD         r1,     r1,     #1
    AND         r3,     r3,     r5      @ still holds nonce[0]
    LSL         r3,     r3,     #4
    LSR         r4,     r2,     #4
    EOR         r4,     r3,     r4
    STRB        r4,     [r0]            @ store to tweak[1]
    ADD         r0,     r0,     #1
# tweak[2] = ((nonce[1]&0xf) << 4) ^ (nonce[2] >> 4)
    LDRB        r3,     [r1]            @ load nonce[2]
    ADD         r1,     r1,     #1
    AND         r2,     r2,     r5      @ still holds nonce[1]
    LSL         r2,     r2,     #4
    LSR         r4,     r3,     #4
    EOR         r4,     r2,     r4
    STRB        r4,     [r0]            @ store to tweak[2]
    ADD         r0,     r0,     #1
# tweak[3] = ((nonce[2]&0xf) << 4) ^ (nonce[3] >> 4)
    LDRB        r2,     [r1]            @ load nonce[3]
    ADD         r1,     r1,     #1
    AND         r3,     r3,     r5      @ still holds nonce[2]
    LSL         r3,     r3,     #4
    LSR         r4,     r2,     #4
    EOR         r4,     r3,     r4
    STRB        r4,     [r0]            @ store to tweak[3]
    ADD         r0,     r0,     #1
# tweak[4] = ((nonce[3]&0xf) << 4)
    AND         r2,     r2,     r5      @ still holds nonce[3]
    LSL         r2,     r2,     #4
    STRB        r2,     [r0]            @ store to tweak[4]
    POP         {r4-r5}                 @ restore the content of R4-R5
    BX          lr                      @ return
# =============================================================================
# Procedure: set block num in the tweak
# Arguments:
#   1. addr to tweak, stored in R0
#   2. block num, stored in R1
# Global variables: none
# Return value: none
# Used registers: R0, R1, R2, R3, R4
# =============================================================================
set_block_number_in_tweak:
    PUSH        {r4}                    @ save content of R4
# tweak[4] = (tweak[4]&0xf0) ^ ((block_no >> 24ULL) & 0x0f)
    MOV         r4,     #0xf0
    LDRB        r2,     [r0, #4]        @ load tweak[4]
    AND         r2,     r2,     r4      @ tweak[4] & 0xf0
    LSR         r3,     r1,     #24
    LSR         r4,     r4,     #4      @ now r4 holds 0x0f
    AND         r3,     r3,     r4
    EOR         r3,     r3,     r2
    STRB        r3,     [r0, #4]        @ store to tweak[4]
# tweak[5] = ((block_no >> 16ULL) & 0xff)
    MOV         r4,     #0xff
    LSR         r2,     r1,     #16
    AND         r2,     r2,     r4
    STRB        r2,     [r0, #5]        @ store to tweak[5]
# tweak[6] = ((block_no >>  8ULL) & 0xff)
    LSR         r2,     r1,     #8
    AND         r2,     r2,     r4
    STRB        r2,     [r0, #6]        @ store to tweak[6]
# tweak[7] = ((block_no >>  0ULL) & 0xff)
    AND         r1,     r1,     r4
    STRB        r1,     [r0, #7]        @ store to tweak[7]
    POP         {r4}                    @ restore content of R4
    BX          lr                      @ return
# =============================================================================
# Procedure: set stage in the tweak
# Arguments:
#   1. addr to tweak, stored in R0
#   2. value to set, stored in R1
# Global variables: none
# Return value: none
# Used registers: R0, R1, R2, R3
# =============================================================================
set_stage_in_tweak:
# tweak[0]=(tweak[0] & 0x0f) ^ value
    MOV         r3,     #0x0f
    LDRB        r2,     [r0]            @ load tweak[0]
    AND         r2,     r2,     r3
    EOR         r2,     r2,     r1
    STRB        r2,     [r0]            @ store to tweak[0]
    BX          lr                      @ return
# =============================================================================
# Procedure: memcpy
# Arguments:
#   1. addr to dest, stored in R0
#   2. addr to src, stored in R1
#   3. size of src, stored in R2
# Global variables: none
# Return value: none
# Used registers: R0, R1, R2, R3, R4
# =============================================================================
        .global memcpy
        .type memcpy STT_FUNC
memcpy:
    PUSH        {r4}                    @ save r4
    MOV         r3,     #0              @ set counter i = 0
LOOP_MEMCPY:
    LDRB        r4,     [r1, r3]        @ load src[i]
    STRB        r4,     [r0, r3]        @ store to dest[i]
# increment i
    ADD         r3,     r3,     #1
    CMP         r3,     r2
    BNE         LOOP_MEMCPY
# memcpy done
    POP         {r4}                    @ retore r4
    BX          lr
# =============================================================================
# Procedure: my_memset
# Arguments:
#   1. addr to dest, an array of bytes, stored in R0
#   2. a byte, fill value, stored in R1
#   3. size of dest array, stored in R2
# Global variables: none
# Return value: none
# Used registers: R0, R1, R2, R3
# =============================================================================
        .global my_memset
        .type my_memset STT_FUNC
my_memset:
    MOV         r3,     #0              @ set counter i = 0
LOOP_MEMSET:
    STRB        r1,     [r0, r3]        @ store to dest[i]
# increment i
    ADD         r3,     r3,     #1
    CMP         r3,     r2              @ i == size
    BNE         LOOP_MEMSET
# memset done
    BX          lr
# =============================================================================
# Procedure: memcmp
# Arguments:
#   1. addr to ptr1, an array of bytes, stored in R0
#   2. addr to ptr2, an array of bytes, stored in R1
#   3. number of bytes to compare, stored in R2
# Global variables: none
# Return value: stored in R0
#   1. < 0: if the first unmatched byte in ptr1 has a lower value than in ptr2
#   2. = 0: the content of both memory blocks are equal
#   3. > 0: the opposite of case 1
# Used registers: R0, R1, R2, R3, R4, R5
# =============================================================================
        .global memcmp
        .type memcmp STT_FUNC
memcmp:
    PUSH        {r4-r5}                 @ save R4-R5
    MOV         r4,     #0              @ set i = 0
    MOV         r5,     r2              @ copy size into r5
LOOP_MEMCMP:
    LDRB        r2,     [r0, r4]        @ load ptr1[i]
    LDRB        r3,     [r1, r4]        @ load ptr2[i]
    SUB         r2,     r2,     r3      @ r2 = ptr1[i] - ptr2[i]
    CMP         r2,     #0
    BNE         MEMCMP_RETURN         
# increment i:
    ADD         r4,     r4,     #1
    CMP         r4,     r5              @ i == size
    BNE         LOOP_MEMCMP
MEMCMP_RETURN:
# return value is in R2
    MOV         r0,     r2              @ copy return value into r0
# memcmp done
    POP         {r4-r5}                 @ restore R4-R5
    BX          lr
# =============================================================================
# Procedure: set tweak in the tweakey, 192 bit version
# Arguments:
#   1. addr to tweakey, stored in R0
#   2. addr to tweak, stored in R1
# Global variables: none
# Return value: none
# Used registers: R0, R1, R2, R3
# =============================================================================
set_tweak_in_tweakey:
    PUSH        {lr}                    @ save lr
# memcpy(tweakey+16, tweak, 8)
    ADD         r0,     r0,     #16
    MOV         r2,     #8              @ size of tweak is 8 bytes
    BL          memcpy
    POP         {r2}                    @ restore lr
    BX          r2                      @ return
# =============================================================================
# Procedure: xor 2 blocks of 8 bytes and save to the first block
# Arguments:
#   1. addr to block 1, stored in R0
#   2. addr to block 2, stored in R1
# Global variables: none
# Return value: none
# Used registers: R0, R1, R2, R3, R4
# =============================================================================
xor_values:
    PUSH        {r4}                    @ save content of R4
    MOV         r2,     #0              @ counter
XOR_BYTE:
    LDRB        r3,     [r0, r2]        @ load v1[i]
    LDRB        r4,     [r1, r2]        @ load v2[i]
    EOR         r4,     r3,     r4
    STRB        r4,     [r0, r2]        @ store to v1[i]
    ADD         r2,     r2,     #1      @ increment the counter
    CMP         r2,     #8
    BNE         XOR_BYTE
# xor done
    POP         {r4}                    @ restore content of R4
    BX          lr                      @ return
# =============================================================================
# Procedure: find unpadded length of a message
# Arguments: addr to block 1, stored in R0
# Global variables: none
# Return value: the unpadded length, stored in R0
# Used registers: R0, R1, R2
# =============================================================================
get_unpadded_length:
    MOV         r1,     r0              @ addr to the msg
    MOV         r0,     #7              @ length
# for(i=7;message[i]==0x00 && i>0;--i);
CHECK_BYTE:
    LDRB        r2,     [r1, r0]        @ load msg[i]
    CMP         r2,     #0              @ msg[i] == 0x00
    BNE         CHECK_MSG
    CMP         r0,     #0              @ i > 0
    BEQ         CHECK_MSG
    SUB         r0,     #1
    B           CHECK_BYTE
CHECK_MSG:
# if(message[i]==0x80) return i
    CMP         r2,     #0x80
    BEQ         GUL_RETURN
    MOV         r0,     #1              @ immediate value is 0-255, can't use -1
    NEG         r0,     r0              @ return -1
GUL_RETURN:
    BX          lr                      @ return 
# =============================================================================
# Procedure: mix
# Arguments:
#    1. addr to array A, stored in R0
#    2. addr to array B, stored in R1
#    3. size of the arrays, should be the same, stored in R2, at most 16
#    4. addr to storage Out1, stored in R3
#    5. addr to storage Out2, stored on system stack
# Global variables: none
# Return value: none
# Used registers: R0-R3, R4-R7
# =============================================================================
mix:
    PUSH        {r0-r7,lr}              @ save R0-R7, and lr, sp -= 9*4
    MOV         r4,     sp              @ r4 is now the frame pointer
# stack layout:
#   (low) r0, r1, r2, r3, r4, r5, r6, r7, lr, Out2 (high)
# copy A to Out1
    MOV         r1,     r0              @ src = A
    MOV         r0,     r3              @ dest = Out1
    BL          memcpy
# copy B to Out2
    LDR         r1,     [r4, #4]        @ src = B
    LDR         r0,     [r4, #36]       @ dest = Out2
    LDR         r2,     [r4, #8]        @ size = s
    BL          memcpy
# prepare for the rest, r0: addr to Out1, r1: addr to Out2, r2: size of them
    LDR         r0,     [r4, #12]       @ r0 = addr to Out1
    LDR         r1,     [r4, #36]       @ r1 = addr to Out2
    LDR         r2,     [r4, #8]        @ r2 = s
# reserve local vars
    SUB         r4,     r4,     r2      @ reserve local var S[s], save to r4
    SUB         r5,     r4,     r2      @ reverse local var rotS[s], save to r5
# stack layout:
# (low) rotS[s] S[s] r0, r1, r2, r3, r4, r5, r6, r7, lr, Out2 (high)
# ptr:  r5      r4
    MOV         r3,     #0              @ set counter i = 0
# for(i=0; i<s; i++) S[i] = A[i] ^ B[i];
CALC_S:
    LDRB        r6,     [r0, r3]        @ load A[i]
    LDRB        r7,     [r1, r3]        @ load B[i]
    EOR         r6,     r6,     r7      @ calc A[i] ^ B[i]
    STRB        r6,     [r4, r3]        @ store to S[i]
# increment i
    ADD         r3,     r3,     #1
    CMP         r3,     r2              @ i == s
    BNE         CALC_S
# for(i=0; i<s; i++) {rotS[i] = S[i]<<1; rotS[i] ^= (S[(i+1)%s]>>7) & 0x1;}
    MOV         r3,     #0              @ reset i = 0
CALC_ROTS:
    ADD         r7,     r3,     #1      @ i + 1
# (i+1) mod s
    CMP         r7,     r2              @ i+1 == s
    BNE         MIX_MOD_DONE
    MOV         r7,     #0              @ (i+1)%s
MIX_MOD_DONE:
    LDRB        r7,     [r4, r7]        @ load S[(i+1)%s]
    LSR         r7,     r7,     #7
    MOV         r6,     #0x1            @ prepare the mask
    AND         r7,     r7,     r6
# i
    LDRB        r6,     [r4, r3]        @ load S[i]
    LSL         r6,     r6,     #1
    EOR         r6,     r7,     r6
    STRB        r6,     [r5, r3]        @ store to rotS[i]
# increment i
    ADD         r3,     r3,     #1
    CMP         r3,     r2              @ i == s
    BNE         CALC_ROTS
# for(i=0; i<s; i++) { Out1[i] = A[i] ^ rotS[i]; Out2[i] = B[i] ^ rotS[i]; }
    MOV         r3,     #0              @ reset i = 0
CALC_OUT:
    LDRB        r6,     [r0, r3]        @ load Out1[i] = A[i]
    LDRB        r7,     [r5, r3]        @ load rotS[i]
    EOR         r6,     r6,     r7
    STRB        r6,     [r0, r3]        @ save to Out1[i]
    LDRB        r6,     [r1, r3]        @ load Out2[i] = B[i]
    EOR         r6,     r6,     r7
    STRB        r6,     [r1, r3]        @ save to Out2[i]
# increment i
    ADD         r3,     r3,     #1
    CMP         r3,     r2              @ i == s
    BNE         CALC_OUT
# done mix
    POP         {r0-r7}                 @ restore content of R0-R7
    POP         {r2}                    @ lr
    BX          r2                      @ return
# =============================================================================
# Procedure: XLS
# Arguments:
#    1. a byte isDirect, stored in R0
#    2. addr to message, an array of byte, stored in R1
#    3. size of the msg, stored in R2
#    4. addr to tweakey, an byte array, of size 192/8 = 24, stored in R3
#    5. addr to tweak, an byte array of size 8, stored on top of the stack
#    6. block number(l), stored as the 2nd item on the stack
#    7. addr to cipher, an array of byte, stored as the 3rd item of the stack
# Global variables: none
# Return value: none
# Used registers: R0-R3, R4-R7
# =============================================================================
XLS:
    PUSH        {r0-r7,lr}              @ save R0-R7, and lr, sp -= 9*4
    MOV         r7,     sp              @ now r7 = sp
# stack layout:
# (low)  r0, r1, r2, r3, r4, r5, r6, r7, lr, tweak, l, cipher (high)
# ptr:   r7(sp)
# reserve local vars
    SUB        r7,        r7,        #24            @ reserve tweak_result[8],
                                        @ mix_result1[8], mix_result2[8]
    MOV        sp,        r7                    @ update sp
# stack layout:
# (low) tweak_result[8], mix_result1[8], mix_result2[8], r0, r1, r2, r3,
#    r4, r5, r6, r7, lr, tweak, l, cipher (high)
# ptr:  r7(sp)
    LDR         r5,     [r7, #60]       @ load addr to tweak into r5
                                        @ 3*8 + 9*4 = 60
    LDR         r6,     [r7, #36]       @ load addr to tweakey into r6
                                        @ 3*8 + 3*4 = 36
# init counter:
    MOV         r4,     #0              @ set counter round_num = 0
# for(round_num = 0; round_num < 3; round_num++) {
XLS_LOOP:
    CMP         r4,     #0              @ round_num == 0, 1st round
    BNE         XLS_SET_BLOCK_NUM_DONE
# set_block_number_in_tweak (tweak, l);
    MOV         r0,     r5              @ copy addr to tweak into r0
    LDR         r1,     [r7, #64]       @ load l into r1
    BL          set_block_number_in_tweak    @ tweak is updated
XLS_SET_BLOCK_NUM_DONE:
    CMP         r4,     #1              @ 2nd round, use MSB_XLS2
    BEQ         XLS_SET_MSB_R2
    MOV         r1,     #0x8            @ MSB_XLS1 = 0x8<<4
    B           XLS_SET_MSB_DONE
XLS_SET_MSB_R2:
    MOV         r1,     #0x9
XLS_SET_MSB_DONE:
    LSL         r1,     r1,     #4      @ perform the shift
# set_stage_in_tweak (tweak, MSB_XLS?);
    MOV         r0,     r5              @ copy addr to tweak into r0
    BL          set_stage_in_tweak      @ tweak is updated
# set_tweak_in_tweakey(tweakey, tweak);
    MOV         r0,     r6              @ copy addr to tweakey into r0
    MOV         r1,     r5              @ copy addr to tweak into r1
    BL          set_tweak_in_tweakey    @ tweakey is updated
# set tweak_src:
    CMP         r4,     #0
    BEQ         XLS_SET_TWEAK_SRC_R1
# 2nd or 3rd round, tweak_src = tweak_result
    MOV         r1,     r7              @ copy addr to tweak_result into r1
    B           XLS_SET_TWEAK_SRC_DONE
XLS_SET_TWEAK_SRC_R1:
# tweak_src = message
    LDR         r1,     [r7, #28]       @ load addr to message into r1
                                        @ 3*8 + 4 = 28
XLS_SET_TWEAK_SRC_DONE:
    MOV         r2,     r6              @ copy addr to tweakey into r2
    MOV         r3,     r7              @ copy addr to tweak_result into r3
# switch over isDirect
    LDR         r0,     [r7, #24]       @ load isDirect into r0, 3*8 = 24
    CMP         r0,     #0
    BEQ         XLS_DE                  @ decrypt
# encrypt
    MOV         r0,     #192            @ TWEAKEY_STATE_SIZE = 192
    BL          aesTweakEncrypt         @ tweak_result is updated, as ct
    B           XLS_IS_DIRECT_DONE
XLS_DE:
# decrypt:
    MOV         r0,     #192            @ TWEAKEY_STATE_SIZE = 192
    BL          aesTweakDecrypt         @ tweak_result is updated, as pt
XLS_IS_DIRECT_DONE:
    CMP         r4,     #2
    BEQ         XLS_MIX_DONE            @ no need to mix for 3rd round
# set mix_src:
    CMP         r4,     #0
    BEQ         XLS_SET_MIX_SRC_R1
# 2nd round, mix_src = mix_result2
    MOV         r1,     r7
    ADD         r1,     r1,     #16     @ copy addr to mix_result2 into r1
    B           XLS_SET_MIX_SRC_DONE
XLS_SET_MIX_SRC_R1:
# 1st round, mix_src = message+8
    LDR         r1,     [r7, #28]       @ load addr to message into r1
    ADD         r1,     r1,     #8      @ now message+8
XLS_SET_MIX_SRC_DONE:
# mix (tweak_result+8-s, mix_src, s, mix_result1, mix_result2);
    LDR         r2,     [r7, #32]       @ load size of message into r2
    MOV         r3,     r7
    ADD         r3,     r3,     #16     @ addr to mix_result2
    PUSH        {r3}                    @ 5th argument for mix
    SUB         r3,     r3,     #8      @ addr to mix_result1
    MOV         r0,     r7              @ addr to tweak_result
    ADD         r0,     r0,     #8      @ tweak_resul+8
    SUB         r0,     r0,     r2      @ tweak_result+8-s
    BL          mix                     @ mix_resul1 and mix_result2 are
                                        @ updated
    POP         {r0}                    @ remove 5th argument from stack
# memcpy(tweak_result+8-s, mix_result1, s);
    LDR         r2,     [r7, #32]       @ load size of message into r2
    MOV         r1,     r7
    ADD         r1,     r1,     #8      @ addr to mix_result1
    MOV         r0,     r7
    ADD         r0,     r0,     #8      @ tweak_result+8
    SUB         r0,     r0,     r2      @ tweak_result+8-s
    BL          memcpy
# tweak_result[8-s-1] ^= 1;
    LDR         r2,     [r7, #32]       @ load size of message into r2
    SUB         r2,     r2,     #7      @ s-7
    NEG         r2,     r2              @ 7-s
    LDRB        r0,     [r7, r2]        @ load tweak_result[7-s] into r0
    MOV         r1,     #1
    EOR         r0,     r0,     r1
    STRB        r0,     [r7, r2]        @ write back
XLS_MIX_DONE:
# increment counter:
    ADD         r4,     r4,     #1
    CMP         r4,     #3
    BNE         XLS_LOOP
# write the outputs:
    LDR         r4,     [r7, #68]       @ load addr to cipher into r4
                                        @ 3*8 + 11*4 = 68
# memcpy (cipher, tweak_result, 8);
    MOV         r0,     r4              @ r0 = addr to cipher
    MOV         r1,     r7              @ r1 = addr to tweak_result
    MOV         r2,     #8              @ size = 8
    BL          memcpy                  @ cipher is updated
# memcpy (cipher+8, mix_result2, s);
    LDR         r2,     [r7, #32]       @ load size of message into r2
    MOV         r1,     r7
    ADD         r1,     r1,     #16     @ r1 = addr to mix_result2
    MOV         r0,     r4              @ r0 = addr to cipher
    ADD         r0,     r0,     #8      @ now cipher+8
    BL          memcpy                  @ cipher is updated
# done
    ADD         r7,     r7,     #24
    MOV            sp,        r7                @ restore sp
    POP            {r0-r7}                    @ restore R0-R7
    POP         {r2}                    @ lr
    BX          r2                      @ return
# =============================================================================
# Procedure: joltik_aead_encrypt
# Arguments:
#    1. addr to ass_data, a byte array, stored in R0
#    2. ass_data_len, size of ass_data, stored in R1
#    3. addr to message, a byte array, stored in R2
#    4. size of message, stored in R3
#    5. addr to key, a byte array, stored on top of the stack
#    6. addr to nonce, a byte array, stored as the 2nd item on the stack
#    7. addr to ciphertext, a byte array, stored as the 3rd item on the stack
#     8. c_len: addr to the size of ciphertext, stored as 4th item on the stack
# Global variables: none
# Return value: none
# Used registers: R0-R3, R4-R7
# =============================================================================
        .global joltik_aead_encrypt
        .type joltik_aead_encrypt STT_FUNC
joltik_aead_encrypt:
    PUSH        {r0-r7,lr}              @ save R0-R7, and lr, sp -= 9*4
    MOV         r4,     sp              @ use r4 to keep original sp
    MOV            r5,        sp                @ r5 = sp
    SUB            r5,        r5,        #80        @ reserve space for local variables
    MOV            sp,        r5                @ update sp
    MOV         r6,     r0              @ copy addr to ass_data into r6
    MOV         r7,     r1              @ copy ass_data_len into r7
# stack layout:
# (low) c_star[8], temp[8], Final[8], Checksum[8], last_block[8], Auth[8],
# tweak[8], tweakey[24], r0, r1, r2, r3, r4, r5, r6, r7, lr, key, nonce,
# ciphertext, c_len (high)
# call joltik_aead_init
    MOV         r0,     r5
    ADD         r0,     r0,     #48     @ copy addr to tweak into r0
    MOV         r1,     r5
    ADD         r1,     r1,     #56     @ copy addr to tweakey into r1
    MOV         r2,     #116            @ 80 + 9*4 = 116
    LDR         r2,     [r5, r2]        @ load addr to key into r2
    MOV         r3,     #120            @ 80 + 10*4 = 120
    LDR         r3,     [r5, r3]        @ load addr to nonce into r3
    BL          joltik_aead_init
# call joltik_aead_ass_data
    MOV         r0,     r6              @ copy addr to ass_data into r0
    MOV         r1,     r7              @ copy ass_data_len into r1
    MOV         r2,     r5
    ADD         r2,     r2,     #48     @ copy addr to tweak into r2
    MOV         r3,     r5
    ADD         r3,     r3,     #32     @ addr to last_block
    PUSH        {r3}                    @ 7th argument
    SUB         r3,     r3,     #24     @ addr to temp
    PUSH        {r3}                    @ 6th argument
    ADD         r3,     r3,     #32     @ addr to Auth
    PUSH        {r3}                    @ 5th argument
    ADD         r3,     r3,     #16     @ copy addr to tweakey into r3
    BL          joltik_aead_ass_data
# now we handle the message:
    LDR            r7,        [r4, #12]        @ dedicate r7 to be m_len
    CMP            r7,        #8                @ compare m_len with 8
    BGE         JAE_MSG_LONG_JUMP_AGAIN @ msg length >= 8
# msg length < 8:
    MOV         r6,     r5
    ADD         r6,     r6,     #48     @ r6 holds addr to tweak
# memset(last_block, 0, 8);
    MOV            r0,        r5
    ADD            r0,        r0,        #32        @r0 = addr last_block
    MOV            r1,        #0                @r1 = 0
    MOV            r2,        #8                @r2 = 8
    BL            my_memset
# memcpy(last_block, message, m_len);
    MOV            r0,        r5
    ADD            r0,        r0,        #32        @r0 = addr last_block
    LDR            r1,        [r4, #8]        @r1 = addr message
    MOV            r2,        r7                @r2 = m_len
    BL            memcpy
# last_block[m_len] = 0x80;
    MOV            r0,        r5
    ADD            r0,        r0,        #32        @r0 = addr last_block
    MOV            r1,        #0x80            @r1 = 0x80
    STRB        r1,        [r0, r7]        @last_block[m_len] = 0x80;
# set_block_number_in_tweak (tweak, 0);
    MOV            r0,        r6
    MOV            r1,        #0                @r1 = 0
    BL            set_block_number_in_tweak
# set_stage_in_tweak (tweak, MSB_M_ONE_LEFT_UP);
    MOV            r0,        r6
    MOV            r1,        #0x0            @r1 = 0x0<<4 = 0x0
    BL            set_stage_in_tweak
# set_tweak_in_tweakey(tweakey, tweak);
    MOV            r0,        r5
    ADD            r0,        r0,        #56        @r0 = addr tweakey
    MOV            r1,        r6
    BL            set_tweak_in_tweakey

    B           JAE_MSG_LONG_JUMP_AGAIN_NEXT
JAE_MSG_LONG_JUMP_AGAIN:
    B           JAE_MSG_LONG            @ branch out of range
JAE_MSG_LONG_JUMP_AGAIN_NEXT:

# aesTweakEncrypt (TWEAKEY_STATE_SIZE, last_block, tweakey, temp);
    MOV            r0,        #192            @r0 = TWEAKEY_STATE_SIZE
    MOV            r1,        r5
    ADD            r1,        r1,        #32        @r1 = addr last_block
    MOV            r2,        r5
    ADD            r2,        r2,        #56        @r2 = addr tweakey
    MOV            r3,        r5
    ADD            r3,        r3,        #8        @r3 = addr temp
    BL            aesTweakEncrypt
# xor_values (Auth, temp);
    MOV            r0,        r5
    ADD            r0,        r0,        #40        @r0 = addr Auth
    MOV            r1,        r5
    ADD            r1,        r1,        #8        @r1 = addr temp
    BL            xor_values
# set_stage_in_tweak (tweak, MSB_M_ONE_LEFT_DOWN);
    MOV            r0,        r6
    MOV            r1,        #0x4            @r1 = 0x4
    LSL            r1,        r1,        #4        @r1 = 0x4<<4
    BL            set_stage_in_tweak
# set_tweak_in_tweakey(tweakey, tweak);
    MOV            r0,        r5
    ADD            r0,        r0,        #56        @r0 = addr tweakey
    MOV            r1,        r6
    BL            set_tweak_in_tweakey
# aesTweakEncrypt (TWEAKEY_STATE_SIZE, Auth, tweakey, c_star);
    MOV            r0,        #192            @r0 = TWEAKEY_STATE_SIZE
    MOV            r1,        r5
    ADD            r1,        r1,        #40        @r1 = addr Auth
    MOV            r2,        r5
    ADD            r2,        r2,        #56        @r2 = addr tweakey
    MOV            r3,        r5                @r3 = addr c_star
    BL            aesTweakEncrypt
# set_stage_in_tweak (tweak, MSB_M_ONE_RIGHT_UP);
    MOV            r0,        r6
    MOV            r1,        #0x1            @r1 = 0x1
    LSL            r1,        r1,        #4        @r1 = 0x1<<4
    BL            set_stage_in_tweak
# set_tweak_in_tweakey(tweakey, tweak);
    MOV            r0,        r5
    ADD            r0,        r0,        #56        @r0 = addr tweakey
    MOV            r1,        r6
    BL            set_tweak_in_tweakey
# aesTweakEncrypt (TWEAKEY_STATE_SIZE, last_block, tweakey, temp);
    MOV            r0,        #192            @r0 = TWEAKEY_STATE_SIZE
    MOV            r1,        r5
    ADD            r1,        r1,        #32        @r1 = addr last_block
    MOV            r2,        r5
    ADD            r2,        r2,        #56        @r2 = addr tweakey
    MOV            r3,        r5
    ADD            r3,        r3,        #8        @r3 = addr temp
    BL            aesTweakEncrypt
# xor_values (Auth, temp);
    MOV            r0,        r5
    ADD            r0,        r0,        #40        @r0 = addr Auth
    MOV            r1,        r5
    ADD            r1,        r1,        #8        @r1 = addr temp
    BL            xor_values
# set_block_number_in_tweak (tweak, 0);
    MOV            r0,        r6
    MOV            r1,        #0                @r1 = 0
    BL            set_block_number_in_tweak
# set_stage_in_tweak (tweak, MSB_M_ONE_RIGHT_DOWN);
    MOV            r0,        r6
    MOV            r1,        #0x5            @r1 = 0x5
    LSL            r1,        r1,        #4        @r1 = 0x5<<4
    BL            set_stage_in_tweak
# set_tweak_in_tweakey(tweakey, tweak);
    MOV            r0,        r5
    ADD            r0,        r0,        #56        @r0 = addr tweakey
    MOV            r1,        r6
    BL            set_tweak_in_tweakey
# aesTweakEncrypt (TWEAKEY_STATE_SIZE, Auth, tweakey, temp);
    MOV            r0,        #192            @r0 = TWEAKEY_STATE_SIZE
    MOV            r1,        r5
    ADD            r1,        r1,        #40        @r1 = addr Auth
    MOV            r2,        r5
    ADD            r2,        r2,        #56        @r2 = addr tweakey
    MOV            r3,        r5
    ADD            r3,        r3,        #8        @r3 = addr temp
    BL            aesTweakEncrypt
# prepare for the followings 3 function calls:
    LDR            r6,        [r4, #44]        @ r6 = addr ciphertext
# memcpy (ciphertext, c_star, m_len);
    MOV         r0,     r6              @ r1 = addr ciphertext
    MOV            r1,        r5                @r1 = addr c_star
    MOV            r2,        r7                @r2 = m_len
    BL            memcpy
# memcpy (ciphertext+m_len, c_star+m_len, 8-m_len);
    MOV         r0,     r6
    ADD            r0,        r0,        r7        @r0 = ciphertext+m_len
    MOV            r1,        r5                @r1 = addr c_star
    ADD            r1,        r1,        r7        @r1 = c_star+m_len
    MOV            r2,        #8                @r2 = 8
    SUB            r2,        r2,        r7        @r2 = 8 - m_len
    BL            memcpy
# memcpy (ciphertext+m_len+8-m_len, temp, m_len);
    MOV         r0,     r6
    ADD            r0,        r0,        #8        @r0 = ciphertext+8
    MOV            r1,        r5
    ADD            r1,        r1,        #8        @r1 = addr temp
    MOV            r2,        r7                @r2 = m_len
    BL            memcpy
# *c_len=8+m_len;
    MOV            r0,        #8                @r0 = 8
    ADD            r0,        r0,        r7        @r0 = 8 + m_len
    LDR         r1,     [r4, #48]       @ load addr to c_len
    STR            r0,        [r1]            @ overwrite *c_len
    B            goDone
JAE_MSG_LONG:
# memset (Checksum, 0, 8);
    MOV            r0,        r5
    ADD            r0,        r0,        #24        @r0 = addr Checksum
    MOV            r1,        #0                @r1 = 0
    MOV            r2,        #8                @r2 = 8
    BL            my_memset
# i = 1;
    MOV            r6,        #1                @set r6,which is still counter to 1
# while (8*i  <= m_len) {
JAE_MSG_LONG_LOOP:
# condition check:
    MOV            r0,     r6
    LSL         r0,     r0,     #3      @ 8*i
    CMP            r0,        r7                @compare r0 with m_len
    BGT            JAE_MSG_LONG_LOOP_DONE
# xor_values (Checksum, message+8*(i-1));
    MOV            r0,        r5
    ADD            r0,        r0,        #24        @r0 = addr Checksum
    SUB            r1,        r6,     #1      @ i-1
    LSL         r1,     r1,     #3      @ 8*(i-1)
    LDR            r2,        [r4, #8]        @r2 = addr message
    ADD            r1,        r1,        r2        @r1 = message+8*(i-1)
    BL            xor_values
# set_block_number_in_tweak (tweak, i);
    MOV            r0,        r5
    ADD            r0,        r0,        #48        @r0 = addr tweak
    MOV            r1,        r6                @r1 = i
    BL            set_block_number_in_tweak
# set_stage_in_tweak (tweak, MSB_M_UP);
    MOV            r0,        r5
    ADD            r0,        r0,        #48        @r0 = addr tweak
    MOV            r1,        #0                @r1 = 0x0
    BL            set_stage_in_tweak
# set_tweak_in_tweakey(tweakey, tweak);
    MOV            r0,        r5
    ADD            r0,        r0,        #56        @r0 = addr tweakey
    MOV            r1,        r5
    ADD            r1,        r1,        #48        @r1 = tweak
    BL            set_tweak_in_tweakey
# aesTweakEncrypt (TWEAKEY_STATE_SIZE, message+8*(i-1), tweakey, temp);
    MOV            r0,        #192            @r0 = TWEAKEY_STATE_SIZE
    SUB         r1,     r6,     #1      @ i-1
    LSL         r1,     r1,     #3      @ 8*(i-1)
    LDR            r2,        [r4, #8]        @r2 = addr message
    ADD            r1,        r1,        r2        @r1 = message+8*(i-1)
    MOV            r2,        r5
    ADD            r2,        r2,        #56        @r2 = addr tweakey
    MOV            r3,        r5
    ADD            r3,        r3,        #8        @r3 = addr temp
    BL            aesTweakEncrypt
# xor_values  (Auth, temp);
    MOV            r0,        r5
    ADD            r0,        r0,        #40        @r0 = addr Auth
    MOV            r1,        r5
    ADD            r1,        r1,        #8        @r1 = addr temp
    BL            xor_values
# set_stage_in_tweak (tweak, MSB_M_DOWN);
    MOV            r0,        r5
    ADD            r0,        r0,        #48        @r0 = addr tweak
    MOV            r1,        #0x4            @r1 = 0x4
    LSL            r1,        r1,        #4        @r1 = 0x4<<4
    BL            set_stage_in_tweak
# set_tweak_in_tweakey(tweakey, tweak);
    MOV            r0,        r5
    ADD            r0,        r0,        #56        @r0 = addr tweakey
    MOV            r1,        r5
    ADD            r1,        r1,        #48        @r1 = tweak
    BL            set_tweak_in_tweakey
# aesTweakEncrypt (TWEAKEY_STATE_SIZE, Auth, tweakey, ciphertext+8*(i-1));
    MOV            r1,        r5
    ADD            r1,        r1,        #40        @r1 = addr Auth
    MOV            r2,        r5
    ADD            r2,        r2,        #56        @r2 = addr tweakey
    SUB         r3,     r6,     #1      @ i-1
    LSL         r3,     r3,     #3      @ 8*(i-1)
    LDR            r0,        [r4, #44]        @r0 = addr ciphertext
    ADD            r3,        r3,        r0        @r3 = ciphertext+8*(i-1)
    MOV            r0,        #192            @r0 = TWEAKEY_STATE_SIZE
    BL            aesTweakEncrypt
#i++;
    ADD            r6,        r6,        #1        @increase counter
    B           JAE_MSG_LONG_LOOP
JAE_MSG_LONG_LOOP_DONE:
# set_stage_in_tweak (tweak, MSB_M_LAST_AUTH);
    MOV            r0,        r5
    ADD            r0,        r0,        #48        @r0 = addr tweak
    MOV            r1,        #0x1            @r1 = 0x1
    LSL            r1,        r1,        #4        @r1 = 0x1<<4
    BL            set_stage_in_tweak
# set_tweak_in_tweakey(tweakey, tweak);
    MOV            r0,        r5
    ADD            r0,        r0,        #56        @r0 = addr tweakey
    MOV            r1,        r5
    ADD            r1,        r1,        #48        @r1 = addr tweak
    BL            set_tweak_in_tweakey
# aesTweakEncrypt (TWEAKEY_STATE_SIZE, Checksum, tweakey, temp);
    MOV            r0,        #192            @r0 = TWEAKEY_STATE_SIZE
    MOV            r1,        r5
    ADD            r1,        r1,        #24        @r1 = addr Checksum
    MOV            r2,        r5
    ADD            r2,        r2,        #56        @r2 = addr tweakey
    MOV            r3,        r5
    ADD            r3,        r3,        #8        @r3 = addr temp
    BL            aesTweakEncrypt
# xor_values (Auth, temp);
    MOV            r0,        r5
    ADD            r0,        r0,        #40        @r0 = addr Auth
    MOV            r1,        r5
    ADD            r1,        r1,        #8        @r1 = addr temp
    BL            xor_values
# set_stage_in_tweak (tweak, MSB_M_LAST_CIPH);
    MOV            r0,        r5
    ADD            r0,        r0,        #48        @r0 = addr tweak
    MOV            r1,        #0x5            @r1 = 0x5
    LSL            r1,        r1,        #4        @r1 = 0x5<<4
    BL            set_stage_in_tweak
# set_tweak_in_tweakey(tweakey, tweak);
    MOV            r0,        r5
    ADD            r0,        r0,        #56        @r0 = addr tweakey
    MOV            r1,        r5
    ADD            r1,        r1,        #48        @r1 = addr tweak
    BL            set_tweak_in_tweakey
# aesTweakEncrypt (TWEAKEY_STATE_SIZE, Auth, tweakey, Final);
    MOV            r0,        #192            @r0 = TWEAKEY_STATE_SIZE
    MOV            r1,        r5
    ADD            r1,        r1,        #40        @r1 = addr Auth
    MOV            r2,        r5
    ADD            r2,        r2,        #56        @r2 = addr tweakey
    MOV            r3,        r5
    ADD            r3,        r3,        #16        @r3 = addr Final
    BL            aesTweakEncrypt
# if (m_len> 8*(i-1)) {
    SUB         r0,     r6,     #1      @ i-1
    LSL         r0,     r0,     #3      @ 8*(i-1)
    CMP            r7,        r0                @compare m_len with 8*(i-1)
    BLE            JAE_MSG_LB_COMPLETE     @ last block is complete
# uint8_t XLSin[16]; using c_star and temp
# uint8_t XLSout[16]; using Checksum and last_block
# s=m_len-8*(i-1);
    SUB         r0,     r6,     #1      @ i-1
    LSL         r0,     r0,     #3      @ 8*(i-1)
    SUB            r7,        r7,        r0        @dedicate r7 to be s = m_len-8*(i-1)
# memcpy(XLSin, message+8*(i-1), s);
    SUB         r0,     r6,     #1      @ i-1
    LSL         r0,     r0,     #3      @ 8*(i-1)
    LDR            r1,        [r4, #8]        @r1 = addr message
    ADD            r1,        r1,        r0        @r1 = message+8*(i-1)
    MOV            r0,        r5                @r0 = addr XLSin
    MOV            r2,        r7                @r2 = s
    BL            memcpy
# memcpy(XLSin+s, Final, 8);
    MOV            r0,        r5                @r0 = addr XLSin
    ADD            r0,        r0,        r7        @r0 = XLSin+s
    MOV            r1,        r5
    ADD            r1,        r1,        #16        @r1 = addr Final
    MOV            r2,        #8                @r2 = 8
    BL            memcpy
# XLS (1, XLSin, s, tweakey, tweak, i-1, XLSout);
    MOV         r0,     #1              @ r0 = 1
    MOV         r1,     r5              @ r1 = addr to XLSin(c_star + temp)
    MOV            r3,        r5
    ADD            r3,        r3,        #56        @r3 = addr tweakey
    MOV         r2,     r5
    ADD         r2,     r2,     #24     @ addr to XLSout(Checksum+last_block)
    PUSH        {r2}                    @ 7th argument
    SUB         r2,     r6,     #1      @ i-1
    PUSH        {r2}                    @ 6th argument
    MOV         r2,     r5
    ADD         r2,     r2,     #48     @ addr to tweak
    PUSH        {r2}                    @ 5th argument
    MOV            r2,        r7                @r2 = s
    BL            XLS
    POP         {r0-r2}                 @ remove arguments from stack
# memcpy (ciphertext+8*(i-1), XLSout, s);
    SUB         r0,     r6,     #1      @ i-1
    LSL         r0,     r0,     #3      @ 8*(i-1)
    LDR            r1,        [r4, #44]        @r1 = addr ciphertext
    ADD            r0,        r0,        r1        @r0 = ciphertext+8*(i-1)
    MOV            r1,        r5
    ADD            r1,        r1,        #24        @r1 = addr XLSout
    MOV            r2,        r7                @r2 = s
    BL            memcpy
# memcpy (ciphertext+m_len, XLSout+s, 8);
    LDR            r0,        [r4, #12]        @r0 = m_len
    LDR            r1,        [r4, #44]        @r1 = addr ciphertext
    ADD            r0,        r0,        r1        @r0 = ciphertext+m_len
    MOV            r1,        r5
    ADD            r1,        r1,        #24        @r1 = addr XLSout
    ADD            r1,        r1,        r7        @r1 = XLSout+s
    MOV            r2,        #8                @r2 = 8
    BL            memcpy
# load m_len into r7:
    LDR            r7,        [r4, #12]        @r0 = m_len
    B            skipGoElse2
JAE_MSG_LB_COMPLETE:
# else {memcpy (ciphertext+m_len, Final, 8);}
    LDR            r0,        [r4, #12]        @r0 = m_len
    LDR            r1,        [r4, #44]        @r1 = addr ciphertext
    ADD            r0,        r0,        r1        @r0 = ciphertext+m_len
    MOV            r1,        r5
    ADD            r1,        r1,        #16        @r1 = Final
    MOV            r2,        #8                @r2 = 8
    BL            memcpy
skipGoElse2:
# *c_len=8+m_len;
    MOV            r0,        #8                @r0 = 8
    ADD            r0,        r0,        r7        @r0 = 8 + m_len
    LDR         r1,     [r4, #48]       @ load addr to c_len
    STR            r0,        [r1]            @ overwrite *c_len
goDone:
    MOV            sp,        r4                @restore the SP
    POP            {r0-r7}                    @restore registers
    POP         {r2}                    @ lr
    BX          r2                      @ return
# =============================================================================
# Procedure: joltik_aead_decrypt
# Arguments:
#    1. addr to ass_data, a byte array, stored in R0
#    2. size of ass_data, stored in R1
#    3. addr to message, a byte array, stored in R2
#    4. addr to size of message, stored in R3
#    5. addr to key, a byte array, stored on top of the stack
#    6. addr to nonce, a byte array, stored as the 2nd item on the stack
#    7. addr to ciphertext, a byte array, stored as the 3rd item on the stack
#     8. c_len, size of ciphertext, stored as the 4th item on the stack
# Global variables: none
# Return value: an integer, stored in R0
# Used registers: R0-R3, R4-R7
# =============================================================================
        .global joltik_aead_decrypt
        .type joltik_aead_decrypt STT_FUNC
joltik_aead_decrypt:
    PUSH        {r0-r7,lr}              @ save R0-R7, lr, sp -= 9*4
# stack layout:
# (low)  r0, r1, r2, r3, r4, r5, r6, r7, lr, key, nonce, ct, c_len (high)
# ptr:   r7(sp)
# reserve local vars
    MOV         r7,     sp
    SUB         r7,     r7,     #88     @ 8*8 + 24 = 88
    MOV         sp,     r7              @ update sp
    MOV         r4,     r0              @ copy addr to ass_data into r4
    MOV         r5,     r1              @ copy ass_data_len into r5
# stack layout:
# (low) tweak[8], tweakey[24], Auth[8], last_block[8], Checksum[8],
# Final[8], temp[8], temp_msg[8], c_star[8],  r0, r1, r2, r3, r4, r5, r6, r7,
# lr, key, nonce, ciphertext, c_len (high)
# joltik_aead_init(tweak, tweakey, key, nonce):
    MOV         r0,     r7              @ copy addr to tweak into r0
    MOV         r1,     r7
    ADD         r1,     r1,     #8      @ copy addr to tweakey into r1
    LDR         r2,     [r7, #124]      @ load addr to key into r2
    MOV         r3,     #128
    LDR         r3,     [r7, r3]        @ load addr to nonce into r3
                                        @ 88 + 9*4 + 4 = 128
    BL          joltik_aead_init
# associated data:
# call joltik_aead_ass_data
    MOV         r0,     r4              @ copy addr to ass_data into r0
    MOV         r1,     r5              @ copy ass_data_len into r1
    MOV         r2,     r7              @ copy addr to tweak into r2
    MOV         r3,     r7
    ADD         r3,     r3,     #40
    PUSH        {r3}                    @ 7th argument, addr to last_block
    ADD         r3,     r3,     #24
    PUSH        {r3}                    @ 6th argument, addr to temp
    SUB         r3,     r3,     #32
    PUSH        {r3}                    @ 5th argument, addr to Auth
    SUB         r3,     r3,     #24     @ copy addr to tweakey into r3
    BL          joltik_aead_ass_data
# message:
    MOV         r0,     #136
    LDR         r5,     [r7, r0]        @ load c_len into r5
                                        @ 88 + 9*4 + 3*4 = 136
    MOV         r0,     #132
    LDR         r6,     [r7, r0]        @ load addr to ciphertext into r6
    CMP         r5,     #16             @ c_len - 8 >= 8
    BGE        JAD_MSG_LONG_JUMP_AGAIN
# message is shorter than 8
# memcpy(c_star, ciphertext, 8);
    MOV         r0,     r7
    ADD         r0,     r0,     #80     @ copy addr to c_star into r0
                                        @ 8 + 24 + 6*8 = 80
    MOV         r1,     r6              @ copy addr to ciphertext into r1
    MOV         r2,     #8
    BL          memcpy                  @ c_star is updated
# Decrypt the block:
# set_block_number_in_tweak (tweak, 0);
    MOV         r0,     r7              @ copy addr to tweak into r0
    MOV         r1,     #0
    BL          set_block_number_in_tweak   @ tweak is updated
# set_stage_in_tweak (tweak, MSB_M_ONE_LEFT_DOWN);
    MOV         r0,     r7              @ copy addr to tweak into r0
    MOV         r1,     #0x4            @ MSB_M_ONE_LEFT_DOWN = 0x4<<4
    LSL         r1,     r1,     #4
# set_tweak_in_tweakey(tweakey, tweak);
    MOV         r0,     r7
    ADD         r0,     r0,     #8      @ copy addr to tweakey into r0
    MOV         r1,     r7              @ copy addr to tweak into r1
    BL          set_tweak_in_tweakey    @ tweakey is updated
# aesTweakDecrypt (TWEAKEY_STATE_SIZE, c_star, tweakey, temp);
    MOV         r0,     #192            @ TWEAKEY_STATE_SIZE = 192
    MOV         r1,     r7
    ADD         r1,     r1,     #80     @ copy addr to c_star into r1
    MOV         r2,     r7
    ADD         r2,     r2,     #8      @ copy addr to tweakey into r2
    MOV         r3,     r7
    ADD         r3,     r3,     #64     @ copy addr to temp into r3
                                        @ 8 + 24 + 8*4 = 64
    BL          aesTweakDecrypt         @ temp is updated
# Decrypt again to get the message block:
# xor_values(Auth, temp);
    MOV         r0,     r7
    ADD         r0,     r0,     #32     @ copy addr to Auth into r0
    MOV         r1,     r7
    ADD         r1,     r1,     #64     @ copy addr to temp into r1
    BL          xor_values              @ Auth is updated
# set_stage_in_tweak (tweak, MSB_M_ONE_LEFT_UP);
    MOV         r0,     r7              @ copy addr to tweak into r0
    MOV         r1,     #0              @ MSB_M_ONE_LEFT_UP = 0x0<<4 = 0
    BL          set_stage_in_tweak      @ tweak is updated
# set_tweak_in_tweakey(tweakey, tweak);
    MOV         r0,     r7
    ADD         r0,     r0,     #8      @ copy addr to tweakey into r0
    MOV         r1,     r7              @ copy addr to tweak into r1
    BL          set_tweak_in_tweakey    @ tweakey is updated
# aesTweakDecrypt (TWEAKEY_STATE_SIZE, Auth, tweakey, temp_msg);
    MOV         r0,     #192            @ TWEAKEY_STATE_SIZE = 192
    MOV         r1,     r7
    ADD         r1,     r1,     #32     @ copy addr to Auth into r1
    MOV         r2,     r7
    ADD         r2,     r2,     #8      @ copy addr to tweakey into r2
    MOV         r3,     r7
    ADD         r3,     r3,     #72     @ copy addr to temp_msg into r3
                                        @ 8 + 24 + 8*5 = 72
    BL          aesTweakDecrypt         @ temp_msg is updated, as pt
    B           JAD_MSG_LONG_JUMP_AGAIN_NEXT

JAD_MSG_LONG_JUMP_AGAIN:
    B           JAD_MSG_LONG            @ branch out of range
JAD_MSG_LONG_JUMP_AGAIN_NEXT:

# First check on the n-bit tag condition:
# the plaintext must be c_len-8 bytes long
# if((c_len-8) != getUnpaddedLength(temp_msg)) return -1;
    MOV         r0,     r7
    ADD         r0,     r0,     #72     @ copy addr to temp_msg into r0
    BL          get_unpadded_length     @ result = R0
    ADD         r0,     r0,     #8
    CMP         r5,     r0              @ c_len != 8 + unpadded_length
    MOV         r0,     #1
    NEG         r0,     r0              @ return -1
    BNE         JAD_MSG_DONE_JUMP_AGAIN
# Update the plaintext length by removing the size of tag from c_len
# *m_len=c_len-8;
    MOV         r0,      #100           @ 88 + 3*4 = 100
    LDR         r0,     [r7, r0]        @ load addr to m_len into r0
    MOV         r2,     r5
    SUB         r2,     r2,     #8      @ c_len - 8
    STR         r2,     [r0]            @ write to *m_len
# Write the plaintext
# memcpy(message, temp_msg, *m_len);
    MOV         r0,     #96
    LDR         r0,     [r7, r0]        @ load addr to message into r0
    MOV         r1,     r7
    ADD         r1,     r1,     #72     @ copy addr to temp_msg into r1
                                        @ r2 still holds *m_len
    MOV         r5,     r2              @ dont need c_len anymore, save *m_len
    BL          memcpy                  @ message is updated
# Update the Auth value
# memcpy(Auth, temp, 8);
    MOV         r0,     r7
    ADD         r0,     r0,     #32     @ copy addr to Auth into r0
    MOV         r1,     r7
    ADD         r1,     r1,     #64     @ copy addr to temp into r1
    MOV         r2,     #8
    BL          memcpy                  @ Auth is updated
# Encrypt the checksum
# set_stage_in_tweak (tweak, MSB_M_ONE_RIGHT_UP);
    MOV         r0,     r7              @ copy addr to tweak into r0
    MOV         r1,     #0x1
    LSL         r1,     r1,     #4      @ MSB_M_ONE_RIGHT_UP = 0x1<<4
    BL          set_stage_in_tweak      @ tweak is updated
# set_tweak_in_tweakey(tweakey, tweak);
    MOV         r0,     r7
    ADD         r0,     r0,     #8      @ copy addr to tweakey into r0
    MOV         r1,     r7              @ copy addr to tweak into r1
    BL          set_tweak_in_tweakey    @ tweakey is updated
# aesTweakEncrypt (TWEAKEY_STATE_SIZE, temp_msg, tweakey, temp);
    MOV         r0,     #192            @ TWEAKEY_STATE_SIZE = 192
    MOV         r1,     r7
    ADD         r1,     r1,     #72     @ copy addr to temp_msg into r1
    MOV         r2,     r7
    ADD         r2,     r2,     #8      @ copy addr to tweakey into r2
    MOV         r3,     r7
    ADD         r3,     r3,     #64     @ copy addr to temp into r3
    BL          aesTweakEncrypt         @ temp is updated, as ct
# Update the Auth value
# xor_values (Auth, temp);
    MOV         r0,     r7
    ADD         r0,     r0,     #32     @ copy addr to Auth into r0
    MOV         r1,     r7
    ADD         r1,     r1,     #64     @ copy addr to temp into r1
    BL          xor_values              @ Auth is updated
# Check the remaining of the tag
# set_stage_in_tweak (tweak, MSB_M_ONE_RIGHT_DOWN);
    MOV         r0,     r7              @ copy addr to tweak into r0
    MOV         r1,     #0x5
    LSL         r1,     r1,     #4      @ MSB_M_ONE_RIGHT_DOWN = 0x5<<4
    BL          set_stage_in_tweak      @ tweak is updated
# set_tweak_in_tweakey(tweakey, tweak);
    MOV         r0,     r7
    ADD         r0,     r0,     #8      @ copy addr to tweakey into r0
    MOV         r1,     r7              @ copy addr to tweak into r1
    BL          set_tweak_in_tweakey    @ tweakey is updated
# aesTweakEncrypt (TWEAKEY_STATE_SIZE, Auth, tweakey, temp);
    MOV         r0,     #192            @ TWEAKEY_STATE_SIZE = 192
    MOV         r1,     r7
    ADD         r1,     r1,     #32     @ copy addr to Auth into r1
    MOV         r2,     r7
    ADD         r2,     r2,     #8      @ copy addr to tweakey into r2
    MOV         r3,     r7
    ADD         r3,     r3,     #64     @ copy addr to temp into r3
    BL          aesTweakEncrypt         @ temp is updated, as ct
# if(0 != memcmp(ciphertext+8, temp, *m_len)) return -1;
    MOV         r0,     #132
    LDR         r0,     [r7, r0]        @ load addr to ciphertext into r0
                                        @ 88 + 9*4 + 2*4 = 132
    ADD         r0,     r0,     #8      @ now ciphertext+8
    MOV         r1,     r7
    ADD         r1,     r1,     #64     @ copy addr to temp into r1
    MOV         r2,     r5              @ copy *m_len into r2
    BL          memcmp                  @ result is in r0
    CMP         r0,     #0
    BEQ         JAD_MSG_DONE_JUMP_AGAIN @ return 0, in r0 already
    MOV         r0,     #1              @ return -1
    NEG         r0,     r0
    B           JAD_MSG_DONE_JUMP_AGAIN
JAD_MSG_LONG:
# msg of any length >= 8, most likely to be the case
# Update the size of the plaintext
# *m_len=c_len-8;
    MOV         r0,      #100           @ 88 + 3*4 = 100
    LDR         r0,     [r7, r0]        @ load addr to m_len into r0
    MOV         r2,     r5              @ r5 still holds c_len
    SUB         r2,     r2,     #8      @ c_len - 8
    STR         r2,     [r0]            @ write to *m_len
    MOV         r5,     r2              @ copy *m_len into r5
# memset (Checksum, 0, 8);
    MOV         r0,     r7              @ 8 + 24 + 2*8 = 48
    ADD         r0,     r0,     #48     @ copy addr to Checksum into r0
    MOV         r1,     #0
    MOV         r2,     #8
    BL          my_memset                  @ Checksum is zeroed
# prepare for the loop: r5 = *m_len, r6 = addr to message
    MOV         r0,     #96
    LDR         r6,     [r7, r0]        @ load addr to message into r6
# i = 1;
    MOV         r4,     #1              @ i = 1
# while (8*i <= *m_len) {
JAD_MSG_LOOP:
# condition check:
    MOV         r0,     r4
    LSL         r0,     r0,     #3      @ 8*i
    CMP         r0,     r5              @ 8*i <= *m_len
    BGT         JAD_MSG_LOOP_DONE
# Decrypt the current ciphertext block
# set_block_number_in_tweak (tweak, i);
    MOV         r0,     r7              @ copy addr to tweak into r0
    MOV         r1,     r4
    BL          set_block_number_in_tweak   @ tweak is updated
# set_stage_in_tweak (tweak, MSB_M_DOWN);
    MOV         r0,     r7              @ copy addr to tweak into r0
    MOV         r1,     #4
    LSL         r1,     r1,     #4      @ MSB_M_DOWN = 0x4<<4
    BL          set_stage_in_tweak      @ tweak is updated
# set_tweak_in_tweakey(tweakey, tweak);
    MOV         r0,     r7
    ADD         r0,     r0,     #8      @ copy addr to tweakey into r0
    MOV         r1,     r7              @ copy addr to tweak into r1
    BL          set_tweak_in_tweakey    @ tweakey is updated
# aesTweakDecrypt (TWEAKEY_STATE_SIZE, ciphertext+8*(i-1), tweakey, temp);
    MOV         r0,     #192            @ TWEAKEY_STATE_SIZE = 192
    SUB         r2,     r4,     #1      @ i-1
    LSL         r2,     r2,     #3      @ 8*(i-1)
    MOV         r1,     #132
    LDR         r1,     [r7, r1]        @ load addr to ciphertext into r1
    ADD         r1,     r1,     r2      @ now ciphertext+8*(i-1)
    MOV         r2,     r7
    ADD         r2,     r2,     #8      @ copy addr to tweakey into r2
    MOV         r3,     r7
    ADD         r3,     r3,     #64     @ copy addr to temp into r3
                                        @ 8 + 24 + 8*4 = 64
    BL          aesTweakDecrypt         @ temp is updated, as pt

    B           JAD_MSG_DONE_JUMP_AGAIN_NEXT
JAD_MSG_DONE_JUMP_AGAIN:
    B           JAD_MSG_DONE            @ coz branch out of range
JAD_MSG_DONE_JUMP_AGAIN_NEXT:

# Update the Auth value
# xor_values (Auth, temp);
    MOV         r0,     r7
    ADD         r0,     r0,     #32     @ copy addr to Auth into r0
    MOV         r1,     r7
    ADD         r1,     r1,     #64     @ copy addr to temp into r1
    BL          xor_values              @ Auth is updated
# Obtain the plaintext block
# set_stage_in_tweak (tweak, MSB_M_UP);
    MOV         r0,     r7              @ copy addr to tweak into r0
    MOV         r1,     #0              @ MSB_M_UP = 0x0<<4 = 0
    BL          set_stage_in_tweak      @ tweak is updated
# set_tweak_in_tweakey(tweakey, tweak);
    MOV         r0,     r7
    ADD         r0,     r0,     #8      @ copy addr to tweakey into r0
    MOV         r1,     r7              @ copy addr to tweak into r1
    BL          set_tweak_in_tweakey    @ tweakey is updated
# aesTweakDecrypt (TWEAKEY_STATE_SIZE, Auth, tweakey, message+8*(i-1));
    MOV         r0,     #192            @ TWEAKEY_STATE_SIZE = 192
    MOV         r1,     r7
    ADD         r1,     r1,     #32     @ copy addr to Auth into r1
    MOV         r2,     r7
    ADD         r2,     r2,     #8      @ copy addr to tweakey into r2
    SUB         r3,     r4,     #1      @ i-1
    LSL         r3,     r3,     #3      @ 8*(i-1)
    ADD         r3,     r3,     r6      @ copy message+8*(i-1) into r3
    BL          aesTweakDecrypt         @ message is updated, as pt
# Update the Checksum
# xor_values (Checksum, message+8*(i-1));
    MOV         r0,     r7
    ADD         r0,     r0,     #48     @ copy addr to Checksum into r0
    SUB         r1,     r4,     #1      @ i-1
    LSL         r1,     r1,     #3      @ 8*(i-1)
    ADD         r1,     r1,     r6      @ copy message+8(i-1) into r1
    BL          xor_values              @ Checksum is updated
# Update the Auth value
# memcpy(Auth, temp, 8);
    MOV         r0,     r7
    ADD         r0,     r0,     #32     @ copy addr to Auth into r0
    MOV         r1,     r7
    ADD         r1,     r1,     #64     @ copy addr to temp into r1
    MOV         r2,     #8
    BL          memcpy                  @ Auth is updated
# incremen i:
    ADD         r4,     r4,     #1
    B           JAD_MSG_LOOP
JAD_MSG_LOOP_DONE:
# Encrypt the checkum
# set_stage_in_tweak (tweak, MSB_M_LAST_AUTH);
    MOV         r0,     r7              @ copy addr to tweak into r0
    MOV         r1,     #0x1
    LSL         r1,     r1,     #4      @ MSB_M_LAST_AUTH = 0x1<<4
    BL          set_stage_in_tweak      @ tweak is updated
# set_tweak_in_tweakey(tweakey, tweak);
    MOV         r0,     r7
    ADD         r0,     r0,     #8      @ copy addr to tweakey into r0
    MOV         r1,     r7              @ copy addr to tweak into r1
    BL          set_tweak_in_tweakey    @ tweakey is updated
# aesTweakEncrypt (TWEAKEY_STATE_SIZE, Checksum, tweakey, temp);
    MOV         r0,     #192            @ TWEAKEY_STATE_SIZE = 192
    MOV         r1,     r7
    ADD         r1,     r1,     #48     @ copy addr to Checksum into r1
    MOV         r2,     r7
    ADD         r2,     r2,     #8      @ copy addr to tweakey into r2
    MOV         r3,     r7
    ADD         r3,     r3,     #64     @ copy addr to temp into r3
    BL          aesTweakEncrypt         @ temp is updated, as ct
# Update the Auth value
# xor_values (Auth, temp);
    MOV         r0,     r7
    ADD         r0,     r0,     #32     @ copy addr to Auth into r0
    MOV         r1,     r7
    ADD         r1,     r1,     #64     @ copy addr to temp into r1
    BL          xor_values              @ Auth is updated
# Obtain the Final value
# set_stage_in_tweak (tweak, MSB_M_LAST_CIPH);
    MOV         r0,     r7              @ copy addr to tweak into r0
    MOV         r1,     #0x5
    LSL         r1,     r1,     #4      @ MSB_M_LAST_CIPH = 0x5<<4
    BL          set_stage_in_tweak      @ tweak is updated
# set_tweak_in_tweakey(tweakey, tweak);
    MOV         r0,     r7
    ADD         r0,     r0,     #8      @ copy addr to tweakey into r0
    MOV         r1,     r7              @ copy addr to tweak into r1
    BL          set_tweak_in_tweakey    @ tweakey is updated
# aesTweakEncrypt (TWEAKEY_STATE_SIZE, Auth, tweakey, Final);
    MOV         r0,     #192            @ TWEAKEY_STATE_SIZE = 192
    MOV         r1,     r7
    ADD         r1,     r1,     #32     @ copy addr to Auth into r1
    MOV         r2,     r7
    ADD         r2,     r2,     #8      @ copy addr to tweakey into r2
    MOV         r3,     r7
    ADD         r3,     r3,     #56     @ copy addr to Final into r3
    BL          aesTweakEncrypt         @ Final is updated, as ct
# check message length:
    SUB         r0,     r4,     #1      @ i-1
    LSL         r0,     r0,     #3      @ 8*(i-1)
    CMP         r5,     r0              @ *m_len > 8*(i-1)
    BLE         JAD_MSG_LB_COMPLETE
# If the last block is incomplete:
# uint8_t XLSin[16] : reuse last_block[8] + Checksum[8]
# uint8_t XLSout[16] : resue temp[8] + temp_msg[8]
# s denotes the number of bytes in the last partial block
# s=c_len-8-8*(i-1);
    MOV         r0,     #136
    LDR         r6,     [r7, r0]        @ load c_len into r6
    MOV         r1,     r4
    LSL         r1,     r1,     #3      @ 8*i
    SUB         r6,     r6,     r1      @ s = c_len - 8*i = c_len-8-8*(i-1)
# Prepare the input to XLS
# memcpy(XLSin, ciphertext+8*(i-1), s); /* copy the s-byte partial block */
    MOV         r0,     r7
    ADD         r0,     r0,     #40     @ reuse last_block and Checksum
    SUB         r1,     r4,     #1      @ i-1
    LSL         r1,     r1,     #3      @ 8*(i-1)
    MOV         r2,     #132
    LDR         r2,     [r7, r2]        @ load addr to ciphertext into r2
    ADD         r1,     r1,     r2      @ copy addr to ciphertext+8*(i-1)
    MOV         r2,     r6              @ copy s into r2
    BL          memcpy                  @ XLSin is updated
# memcpy(XLSin+c_len-8-8*(i-1), ciphertext+c_len-8, 8); /* append tag */
    MOV         r0,     r7
    ADD         r0,     r0,     #40     @ resue last_block and Checksum
    ADD         r0,     r0,     r6      @ XLSin+s
    SUB         r1,     r4,     #1      @ i-1
    LSL         r1,     r1,     #3      @ 8*(i-1)
    ADD         r1,     r1,     r6      @ 8*(i-1) + s = c_len-8
    MOV         r2,     #132
    LDR         r2,     [r7, r2]        @ load addr to ciphertext into r2
    ADD         r1,     r1,     r2      @ r1 = ciphertext+c_len-8
    MOV         r2,     #8
    BL          memcpy                  @ XLSin is updated
# Apply inverse XLS
# XLS (0, XLSin, s, tweakey, tweak, i-1, XLSout);
    MOV         r0,     #0
    MOV         r1,     r7
    ADD         r1,     r1,     #40     @ reuse last_block and Checksum
    MOV         r2,     r6              @ copy s into r2
    MOV         r3,     r7
    ADD         r3,     r3,     #64     @ XLSout, reuse temp and temp_msg
    PUSH        {r3}                    @ 7th argument
    SUB         r3,     r4,     #1      @ i-1
    PUSH        {r3}                    @ 6th argument
    MOV         r3,     r7
    PUSH        {r3}                    @ addr to tweak, 5th argument
    ADD         r3,     r3,     #8      @ copy addr to tweakey into r3
    BL          XLS                     @ XLSout is updated
    POP         {r0-r2}                 @ remove the arguments, r7 = sp again
# Check the Final value
# if(0!=memcmp(Final, XLSout+s, 8)) return -1;
    MOV         r0,     r7
    ADD         r0,     r0,     #56     @ copy addr to Final into r0
    MOV         r1,     r7
    ADD         r1,     r1,     #64     @ XLSout, reuse temp and temo_msg
    ADD         r1,     r1,     r6      @ XLSout+s
    MOV         r2,     #8
    BL          memcmp                  @ result = R0
    MOV         r1,     r0              @ copy result into r1
    MOV         r0,     #1
    NEG         r0,     r0              @ return -1
    CMP         r1,     #0
    BNE         JAD_MSG_DONE
# Write the remaining s bytes in the plaintext
# memcpy(message+*m_len-s, XLSout, s);
    MOV         r0,     #96             @ 88 + 2*4 = 96
    LDR         r0,     [r7, r0]        @ load addr to message into r0
    ADD         r0,     r0,     r5      @ message+*m_len
    SUB         r0,     r0,     r6      @ message+*m_len-s
    MOV         r1,     r7
    ADD         r1,     r1,     #64     @ XLSout, reuse temp and temp_msg
    MOV         r2,     r6              @ copy s into r2
    BL          memcpy
    MOV         r0,     #0              @ return 0
    B           JAD_MSG_DONE
# if the last block is complete:
JAD_MSG_LB_COMPLETE:
# If the tag does not match, return error
# if(0!=memcmp(Final, ciphertext+c_len-8, 8)) return -1;
    MOV         r0,     r7
    ADD         r0,     r0,     #56     @ copy addr to Final into r0
    MOV         r1,     #132            @ 88 + 9*4 + 2*4 = 132
    LDR         r1,     [r7, r1]        @ load addr to ciphertext into r1
    MOV         r2,     #136
    LDR         r2,     [r7, r2]        @ load c_len into r2
    SUB         r2,     r2,     #8      @ c_len-8
    ADD         r1,     r1,     r2      @ ciphertext+c_len-8
    MOV         r2,     #8
    BL          memcmp                  @ result = R0
    CMP         r0,     #0
    BEQ         JAD_MSG_DONE            @ r0 = return value = 0
    MOV         r0,     #1
    NEG         r0,     r0              @ return value = -1
JAD_MSG_DONE:
# done, return value in r0
    ADD         r7,     r7,     #88     @ 8*8 + 24 = 88
    MOV         sp,     r7              @ restore sp
    MOV         lr,     r0              @ lr holds the return value
    POP            {r0-r7}                    @ restore R0-R7
    POP         {r2}                    @ lr
    MOV         r0,     lr              @ return value
    BX          r2                      @ return
# =============================================================================
# Procedure: joltik_aead_ass_data
# Arguments:
#    1. addr to ass_data, a byte array, stored in R0
#    2. ass_data_len, size of ass_data, stored in R1
#    3. addr to tweak, a byte array, stored in R2
#    4. addr to tweakey, a byte array, stored in R3
#    5. addr to Auth, a byte array, stored as the 1st item on stack
#    6. addr to temp, a byte array, stored as the 2nd item on the stack
#    7. addr to last_block, a byte array, stored as the 3rd item on the stack
# Global variables: none
# Return value: none
# Used registers: R0-R3, R4-R7
# =============================================================================
joltik_aead_ass_data:
    PUSH        {r0-r7, lr}             @ save R0-R7 and lr
# stack layout:
# (low)  r0, r1, r2, r3, r4, r5, r6, r7, lr, Auth, temp, last_block (high)
# ptr:   r7(sp)
    MOV         r7,     sp              @ now r7 = sp
    MOV         r6,     r0              @ copy addr to ass_data into r6
    MOV         r5,     r2              @ copy addr to tweak into r5
# memset (Auth, 0, 8);
    LDR         r0,     [r7, #36]       @ load addr to Auth into r0
    MOV         r1,     #0
    MOV         r2,     #8
    BL          my_memset                  @ Auth is zeroed
# set_stage_in_tweak (tweak, MSB_AD);
    MOV         r0,     r5              @ copy addr to tweak into r0
    MOV         r1,     #0x2
    LSL         r1,     r1,     #4      @ MSB_AD = 0x2<<4
    BL          set_stage_in_tweak      @ tweak is updated
# set i = 1
    MOV         r4,     #1
# while (8*i+8 <= ass_data_len) {
AUTH_LOOP:
# condition check:
    ADD         r0,     r4,     #1      @ i+1
    LSL         r0,     r0,     #3      @ 8*i+8
    LDR         r1,     [r7, #4]        @ load ass_data_len into r1
    CMP         r0,     r1              @ 8*i+8 <= ass_data_len
    BGT         AUTH_LOOP_DONE
# set_block_number_in_tweak (tweak, i);
    MOV         r0,     r5              @ copy addr to tweak into r0
    MOV         r1,     r4              @ copy i into r1
    BL          set_block_number_in_tweak   @ tweak is updated
# set_tweak_in_tweakey(tweakey, tweak);
    LDR         r0,     [r7, #12]       @ load addr to tweakey into r0
    MOV         r1,     r5              @ copy addr to tweak into r1
    BL          set_tweak_in_tweakey    @ tweakey is updated
# aesTweakEncrypt (TWEAKEY_STATE_SIZE, ass_data+8*(i-1), tweakey, temp);
    MOV         r0,     #192            @ TWEAKEY_STATE_SIZE = 192
    SUB         r1,     r4,     #1      @ i-1
    LSL         r1,     r1,     #8      @ 8*(i-1)
    ADD         r1,     r1,     r6      @ ass_data+8*(i-1)
    LDR         r2,     [r7, #12]       @ load addr to tweakey into r2
    LDR         r3,     [r7, #40]       @ load addr to temp into r3
    BL          aesTweakEncrypt         @ temp is updated, as ct
# xor_values (Auth, temp);
    LDR         r0,     [r7, #36]       @ load addr to Auth into r0
    LDR         r1,     [r7, #40]       @ load addr to temp into r3
    BL          xor_values              @ Auth is updated
# increment i:
    ADD         r4,     r4,     #1      @ i++
    B           AUTH_LOOP
AUTH_LOOP_DONE:
# last block
    MOV         r0,     r4
    LSL         r0,     r0,     #3      @ 8*i
    LDR         r1,     [r7, #4]        @ load ass_data_len into r1
    CMP         r0,     r1
    BEQ         AUTH_LB_FULL        @ last block is full
# last block is not full or there is no associated data provided:
    LDR         r1,     [r7, #4]        @ load ass_data_len into r1
    CMP         r1,     #8              @ ass_data_len < 8
    BLT         AUTH_NO_LB
# set_block_number_in_tweak (tweak, i);
    MOV         r0,     r5              @ copy addr to tweak into r0
    MOV         r1,     r4              @ copy i into r1
    BL          set_block_number_in_tweak   @ tweak is updated
# set_tweak_in_tweakey(tweakey, tweak);
    LDR         r0,     [r7, #12]       @ load addr to tweakey into r0
    MOV         r1,     r5              @ copy addr to tweak into r1
    BL          set_tweak_in_tweakey    @ tweakey is updated
# aesTweakEncrypt (TWEAKEY_STATE_SIZE, ass_data+8*(i-1), tweakey, temp);
    MOV         r0,     #192            @ TWEAKEY_STATE_SIZE = 192
    SUB         r1,     r4,     #1      @ i-1
    LSL         r1,     r1,     #3      @ 8*(i-1)
    ADD         r1,     r1,     r6      @ ass_data+8*(i-1)
    LDR         r2,     [r7, #12]       @ load addr to tweakey into r2
    LDR         r3,     [r7, #40]       @ load addr to temp into r3
    BL          aesTweakEncrypt         @ temp is updated, as ct
# xor_values (Auth, temp);
    LDR         r0,     [r7, #36]       @ load addr to Auth into r0
    LDR         r1,     [r7, #40]       @ load addr to temp into r1
    BL          xor_values              @ Auth is updated
    B           AUTH_LB_NOT_FULL_DONE
AUTH_NO_LB:
    MOV         r4,     #0              @ i = 0
AUTH_LB_NOT_FULL_DONE:
# memset(last_block, 0, 8);
    LDR         r0,     [r7, #44]       @ load addr to last_block into r0
    MOV         r1,     #0
    MOV         r2,     #8
    BL          my_memset                  @ last_block is updated
# memcpy(last_block, ass_data+8*i, ass_data_len-8*i);
    LDR         r0,     [r7, #44]       @ load addr to last_block into r0
    MOV         r1,     r4
    LSL         r1,     r1,     #3      @ 8*i
    LDR         r2,     [r7, #4]        @ load ass_data_len into r2
    SUB         r2,     r2,     r1      @ ass_data_len-8*i
    ADD         r1,     r1,     r6      @ ass_data+8*i
    BL          memcpy                  @ last_block is updated
# last_block[ass_data_len-8*i] = 0x80;
    MOV         r0,     r4
    LSL         r0,     r0,     #3      @ 8*i
    LDR         r1,     [r7, #4]        @ load ass_data_len into r1
    SUB         r1,     r1,     r0      @ ass_data_len-8*i
    MOV         r2,     #0x80
    LDR         r0,     [r7, #44]       @ load addr to last_block into r0
    STRB        r2,     [r0, r1]        @ write
# xor_values (Auth, last_block);
    LDR         r0,     [r7, #36]       @ load addr to Auth into r0
    LDR         r1,     [r7, #44]       @ load addr to last_block into r1
    BL          xor_values              @ Auth is updated
# set_stage_in_tweak (tweak, MSB_AD_LAST_PARTIAL);
    MOV         r0,     r5              @ copy addr to tweak into r0
    MOV         r1,     #0x7            @ MSB_AD_LAST_PARTIAL = 0x7<<4
    LSL         r1,     r1,     #4
    BL          set_stage_in_tweak      @ tweak is updated
    B           AUTH_LB_DONE
AUTH_LB_FULL:
# if (ass_data_len==8*i) {
# xor_values (Auth, ass_data+8*(i-1));
    LDR         r0,     [r7, #36]       @ load addr to Auth into r0
    SUB         r1,     r4,     #1      @ i-1
    LSL         r1,     r1,     #3      @ 8*(i-1)
    ADD         r1,     r1,     r6      @ ass_data+8(i-1)
    BL          xor_values              @ Auth is updated
# set_stage_in_tweak (tweak, MSB_AD_LAST_FULL);
    MOV         r0,     r5              @ copy addr to tweak into r0
    MOV         r1,     #0x6
    LSL         r1,     r1,     #4      @ MSB_AD_LAST_FULL = 0x6<<4
    BL          set_stage_in_tweak      @ tweak is updated
AUTH_LB_DONE:
# Last BC call for the associated data
    LDR         r6,     [r7, #12]       @ load addr to tweakey into r06
# set_block_number_in_tweak (tweak, ass_data_len/8);
    MOV         r0,     r5              @ copy addr to tweak into r0
    LDR         r1,     [r7, #4]        @ load ass_data_len into r1
    LSR         r1,     r1,     #3      @ ass_data_len/8
    BL          set_block_number_in_tweak   @ tweak is updated
# set_tweak_in_tweakey(tweakey, tweak);
    MOV         r0,     r6              @ copy addr to tweakey into r0
    MOV         r1,     r5              @ copy addr to tweak into r1
    BL          set_tweak_in_tweakey    @ tweakey is updated
# aesTweakEncrypt (TWEAKEY_STATE_SIZE, Auth, tweakey, Auth);
    MOV         r0,     #192            @ TWEAKEY_STATE_SIZE = 192
    LDR         r1,     [r7, #36]       @ load addr to Auth into r0
    MOV         r2,     r6              @ copy addr to tweakey into r2
    MOV         r3,     r1              @ copy addr to Auth into r3
    BL          aesTweakEncrypt         @ Auth is updated, as ct
# done
    POP         {r0-r7}                 @ restore R0-R7
    POP         {r0}                    @ lr
    BX          r0                      @ return
# =============================================================================
# Procedure: joltik_aead_init
# Arguments:
#    1. addr to tweak, a byte array, stored in R1
#     2. addr to tweakey, a byte array, stored in R2
#    3. addr to key, a byte array, stored in R3
#    4. addr to nonce, a byte array, stored in R4
# Global variables: none
# Return value: none
# Used registers: R0-R3, R4-R7
# =============================================================================
joltik_aead_init:
    PUSH        {r4-r7, lr}             @ save R4-R7, lr
    MOV         r4,     r0              @ copy addr to tweak into r4
    MOV         r5,     r1              @ copy addr to tweakey into r5
    MOV         r6,     r2              @ copy addr to key into r6
    MOV         r7,     r3              @ copy addr to nonce into r7
# Fill the tweak from nonce
# memset(tweak, 0, sizeof(tweak));
    MOV         r1,     #0              @ fill in zero
    MOV         r2,     #8              @ sizeof(tweak) = 8
    BL          my_memset
# set_nonce_in_tweak (tweak, nonce);
    MOV         r0,     r4              @ copy addr to tweak into r0
    MOV         r1,     r7              @ copy addr to nonce into r1
    BL          set_nonce_in_tweak      @ tweak is updated
# memcpy(tweakey, key, 16);
    MOV         r0,     r5              @ copy addr to tweakey into r0
    MOV         r1,     r6              @ copy addr to key into r1
    MOV         r2,     #16
    BL          memcpy                  @ tweakey is updated
# done
    POP         {r4-r7}                 @ restore R4-R7
    POP         {r2}                    @ lr
    BX          r2                      @ return
