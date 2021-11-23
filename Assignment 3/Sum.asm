;****************************************************************************************************************************
;Program name: "sumArray".  This program demonstrates the input of float numbers into an array from the standard input       *
;device utilizing those values to obtain the sum of float numbers in the array                                               *
; Copyright (C) 2021 Albert Truong.                                                                                   *
;                                                                                                                     *
;This file is part of the software program "sumArray".                                                                *
;sumArray is free software: you can redistribute it and/or modify it under the terms of the GNU General Public        *
;License version 3 as published by the Free Software Foundation.                                                      *
;sumArray is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied       *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
;****************************************************************************************************************************


;=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;  Author name: Albert Truong
;  Author email: atruong811@fullerton.edu
;
;Program information
;  Program name: sumArray
;  Programming languages: One modules in C, One modules in C++ and three module in X86
;  Date program began: 2021-March-10
;  Date of last update: 2021-March-21
;  Date of reorganization of comments: 2021-March-21
;  Files in this program: Main.c, Control.asm, Fill.asm,  Sum.asm, Display.cpp
;  Status: Finished.  The program was tested extensively with no errors in Ubuntu20.04 LTS on Windows 10 utilizing WSL.
;
;Purpose
;  User input float values into an array. Those values would be of the array would be added up and the sum value would be
;  returned to the main. 
;
;This file
;   File name: Sum.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l Sum.lis -o Sum.o Sum.asm
;
;=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;
;===== Begin code area ===========================================================================================================
extern printf
extern scanf

global Sum

segment .data
input1 db "%s",0
test1 db "Test output %7.6lf.", 10,0
test2 db "Test output", 10,0
output2 db "%lf",10,0

segment .bss  ;Reserved for uninitialized data

segment .text ;Reserved for executing instructions.

Sum:

;Prolog ===== Insurance for any caller of this assembly module ========================================================
;Any future program calling this module that the data in the caller's GPRs will not be modified.
push rbp
mov  rbp,rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags


push qword 0                           

;-----------------------------Initialize Parameters-----------------------------------------
mov r15, rdi                            ; Copies array that was passed to r15.
mov r14, rsi                            ; Copies number of elements in the array to r14.
mov r13, 0                              ; Sum register to add elements of array to.
mov r12, 0                              ; Counter to to iterate through array.

mov rax, 0                     
pop rax
;-----------------------------------Loop Start----------------------------------------------
loopStart:
; Compares the counter (r12) to the number of elements in the array (r14).
cmp r12, r14                        
jge loopEnd             ;If r12 equals r14, jumps to loopEnd

;--------------------------------Add up values--------------------------------------------
addsd xmm10, [r15 + 8 * r12]            ; Adds element of array at index of r12 to xmm10.
inc r12                                 ; Increments counter r12 by 1.

; Restarts loop
jmp loopStart          

;----------------------------------END OF LOOP----------------------------------------------
loopEnd:
;movsd xmm0, xmm10                      
movsd xmm11,xmm10                      ;Save Xmm10 Values into xmm11


;===== Restore original values to integer registers ===================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
