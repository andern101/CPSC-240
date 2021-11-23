;****************************************************************************************************************************
;Program name: "Rectangle Area".  This program demonstrates the input of multiple float numbers from the standard input     *
;device using a single instruction and the output of the perimeter and the average size length                              *
; Copyright (C) 2021 Albert Truong.                                                                                         *
;                                                                                                                           *
;This file is part of the software program "Rectangle Area".                                                                *
;Rectangle Area is free software: you can redistribute it and/or modify it under the terms of the GNU General Public        *
;License version 3 as published by the Free Software Foundation.                                                            *
;Rectangle Area is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied       *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
;****************************************************************************************************************************

;/=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
;
;Author information
;Author name: Albert Truong
;Author email: atruong811@fullerton.edu
;
;Program information
;  Program name: Rectangle Area
;  Programming languages: One modules in C++ and one module in X86
;  Date program began: 2021-Jan-25
;  Date of last update: 2021-Feb-13
;  Date of reorganization of comments: 2021-Feb-13
;  Files in this program: rectangle.cpp, perimeter.asm
;  Status: Finished.  The program was tested extensively with no errors in Ubuntu20.04 LTS on Windows 10 utilizing WSL.
;
;Purpose
;  Show how to input height and length side floating point (64-bit) numbers and output the perimeter and avg. length side.
;
;This file
;   File name: perimeter.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l perimeter.lis -o perimeter.o perimeter.asm


;===== Begin code area ================================================================================================
extern printf
extern scanf
global rectangleArea

segment .data
welcome db "This program will compute the perimeter and the average side length of a rectangle",10,0
heightprompt db "Please enter the height: ",0
widthprompt db "Please enter the width: ",0
perimeter db "The Perimeter is: %5.3lf",10,0
height1 db "%lf",0
width1 db "%lf",0
output_one_float db "The one number is %5.3lf",10,0
avglengthinput db "The length offset the average side is: %5.3lf",10,0
avglength db "%lf",0
good_bye db "The assembly program will send the perimeter to the main",10,0
height db "%lf",0
width db "%lf",0

segment .bss  ;Reserved for uninitialized data

segment .text ;Reserved for executing instructions.

rectangleArea:

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
mov rax, 0                     ;A zero in rax means printf uses no data from xmm registers.
mov rdi, welcome               ;"This program will compute the perimeter and the average side length of a rectangle"
call printf


;============= Begin section to input exactly one float number ========================================================

push qword 0
;Display a prompt message asking for height
mov rax, 0
mov rdi, heightprompt          ;"Please enter the height:  "
call printf
pop rax

;begin scan block for height
push qword 0
mov rax, 0
mov rdi, height1
mov rsi, rsp
call scanf
movsd xmm10, [rsp]
pop rax

;Display a prompt message asking for width
push qword 0
mov rax, 0
mov rdi, widthprompt          ;"Please enter the width: "
call printf
pop rax

;begin scan block for width
push qword 0
mov rax, 1
mov rdi, width1
mov rsi, rsp
call scanf
movsd xmm11, [rsp]
pop rax

;============= End of section to input one float number ===============================================================

;============= Perimeter Calculation =======================================
;Add Width and Height to register xmm12
push qword 0
movsd xmm12,xmm10
addsd xmm12,xmm10
addsd xmm12,xmm11
addsd xmm12,xmm11
pop rax

;Display the perimeter solution
push qword 0
mov rax, 1
mov rdi,perimeter			; "The Perimeter is: %5.3lf"
movsd xmm0, xmm12
call printf
pop rax
;============= End of section to perimeter calculation ==============================================================

;============= Find the Average Length ================================
;Convert Int 4 to Floating Point Num
push qword 4
cvtsi2sd xmm13, [rsp]

;Divide the perimeter( xmm14 by 4(xmm13) )
movsd xmm14, xmm12
divsd xmm14, xmm13
pop rax

;Display the Average Length Solution
push qword 0
mov rax, 1
mov rdi, avglengthinput			;"The length offset the average side is: %5.3lf"
movsd xmm0, xmm14
call printf
pop rax
pop rax
;============= End of the section Find the Average Length ====================================

;============= Prepare to exit from this program ======================================================================

;Display good-bye message (the next block of instructions)
push qword 0
mov rax, 0
mov rdi, good_bye              ;"The assembly program will send the perimeter to the main"
call printf
pop rax

movsd xmm0, xmm12			;Set the return value to the perimeter (xmm12)

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
