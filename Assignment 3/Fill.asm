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
;   File name: Fill.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l Fill.lis -o Fill.o Fill.asm
;
;=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;
;===== Begin code area ===========================================================================================================
extern printf
extern scanf
extern atof

global Fill

segment .data
welcome db "Please enter floating point numbers separated by ws.",10,0
welcome2 db "When finished press enter followed by cntl+D.",10,0
tester db "Test",10,0
input1 db "%lf",0
output1 db "%lf",10,0

segment .bss  ;Reserved for uninitialized data

segment .text ;Reserved for executing instructions.

Fill:

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

;Registers rax, rip, and rsp are usually not backed up.
push qword 0
;-----------------------------Initialize Parameters-----------------------------------------
mov r15, rdi                      ; Address of array saved to r15.
mov r14, rsi                      ; Max number of elements allowed in array.
mov r13, 0                        ; Set counter to 0 elements in Array.

;-----------------------------Display Instructions-----------------------------------------
push qword 0
mov rax, 0                     
mov rdi, welcome               ;"Please enter floating point numbers separated by ws."
call printf
pop rax 

push qword 0
mov rax, 0                     
mov rdi, welcome2               ;"When finished press enter followed by cntl+D."
call printf
pop rax
;---------------------------------Loop Start---------------------------------------------
loopStart:

; User Input into array from scanf.
mov rax, 0                    
mov rdi, input1
push qword 0
mov rsi, rsp  
call scanf
movsd xmm15, xmm0

; Checks if CTRl-D is Inputted.
cdqe
cmp rax, -1                          
je loopEnd                          ; If CTRl-D is entered, jump to loopEnd.
 
pop r12


;--------------------------------Add Float Input into Array--------------------------------------------
movsd [r15 + 8 * r13], xmm15            ; Add Float input into array at index of r13 counter.
inc r13                                 ; Increments counter r13 by 1.



;-----------------------------Array Capacity Check-------------------------------------------
cmp r13, r14                           ; Compares # of elements (r13) to capacity (r14).
je end                                 ; If r13 equals r14, jumps to end

; Restarts loop.
jmp loopStart

;---------------------------------END OF LOOP-----------------------------------------------
loopEnd:
pop rax

;------------------------------------EXIT---------------------------------------------------
end:
pop rax
mov rax, r13

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
