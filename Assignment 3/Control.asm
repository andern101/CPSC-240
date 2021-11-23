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
;   File name: Control.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l Control.lis -o Control.o Control.asm

;
;=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;
;===== Begin code area ===========================================================================================================
extern printf
extern scanf
extern atof
extern Fill
extern Sum
extern Display


arraysize equ 100

global sumArray

segment .data
welcome db "Welcome to HSAS.  The accuracy and reliability of this program is guaranteed by Albert T",10,0
inputprompt db "The numbers you entered are these: ",10,0
good_bye db "The control module will now return the sum to the caller module.",10,0
output_sum db "The sum of these values is %15.12lf",10,0
input1 db "%15.12lf",0
test1 db "Test output %15.6lf.", 10,0
tester1 db "Test", 10,0

segment .bss  ;Reserved for uninitialized data
floatarray: resq 100

segment .text ;Reserved for executing instructions.

sumArray:

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


;Display a welcome message to the viewer.
mov rax, 0                     
mov rdi, welcome               ;""Welcome to HSAS.  The accuracy and reliability of this program is guaranteed by Albert T""
call printf
pop rax

;---------------------------Call Function Fill to input value into array---------------------------------------

mov rdi, floatarray              ; Passes the floatarray into rdi
mov rsi, arraysize               ; Passes the max array size into rsi register.
mov rax, 0
call Fill                        ; Calls Fill function.
mov r14, rax;                    ; Passes # of elements in the array stored in rax to r14.

;---------------------------Display message inputed value to array---------------------------------------
mov rdi, inputprompt             ;"The numbers you entered are these: "
mov rax, 0
call printf                             

;----------------------------Display Elements of Array--------------------------------------
mov rdi, floatarray               ; Passes the array as first parameter into rdi.
mov rsi, r14                      ; Passes # of elements in the array stored in r14.
mov rax, 0
call Display                      ; Calls display function.
pop rax

;-----------------------------------Call Sum Function-----------------------------------------------
mov rdi, floatarray                 ; Passes the array as first parameter into rdi.
mov rsi, r14                        ; Passes # of elements in the array stored in r14.
mov rax, 0
call Sum                            ; Calls Sum function.

;--------------------------Prints out the Sum output--------------------------- 
push qword 0
mov rax, 1
mov rdi, output_sum                 ; "The sum of these values is %15.12lf"
movsd xmm0,xmm11
call printf                             
pop rax

;---------------------------------Starts End Exit-------------------------------------- 
push qword 0
mov rax, 0
mov rdi, good_bye                  ;"The control module will now return the sum to the caller module."
call printf                             

movsd xmm0,xmm11                   ;Return Sum Value
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
