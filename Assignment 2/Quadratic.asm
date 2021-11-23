;****************************************************************************************************************************
;Program name: "QuadRoot".  This program demonstrates the input of multiple float numbers from the standard input     *
;device device utilizing those values to obtain a quadratic equation and output how many roots and what value the roots are *
; Copyright (C) 2021 Albert Truong.                                                                                         *
;                                                                                                                           *
;This file is part of the software program "QuadRoot".                                                                *
;QuadRoot is free software: you can redistribute it and/or modify it under the terms of the GNU General Public        *
;License version 3 as published by the Free Software Foundation.                                                            *
;QuadRoot is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied       *
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
;  Program name: QuadRoot
;  Programming languages: One modules in C, Two modules in C++ and one module in X86
;  Date program began: 2021-Feb-20
;  Date of last update: 2021-Feb-17
;  Date of reorganization of comments: 2021-Feb-17
;  Files in this program: Second_degree.c, isfloat.cpp, Quad_library.cpp,  Quadratic.asm
;  Status: Finished.  The program was tested extensively with no errors in Ubuntu20.04 LTS on Windows 10 utilizing WSL.
;
;Purpose
;  User input 3 float values (a,b,c). Those values would be placed into quadratic equation and program would determine
;  how many roots and what the roots would be for the quadratic equation.
;
;This file
;   File name: Quadratic.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l Quadratic.lis -o Quadratic.o Quadratic.asm
;
;=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**

;===== Begin code area ================================================================================================
extern printf
extern scanf
extern atof
extern isfloat
extern show_no_root
extern show_one_root
extern show_two_root

global quadRoot

segment .data
welcome db "This program will find the roots of any quadratic equation.",10,0
inputprompt db "Please enter the three floating point coefficients of a quadratic equation in the order a, b, c separated by the end of line character:",10,0
good_bye db "One of these roots will be returned to the caller function.",10,0
three_input db "%s %s %s",0
output_three_float db "Thank you.  The equation is %7.12lf x^2 + %7.12lf x + %7.12lf",10,0
error db "Invalid Input. You can rerun the program.", 10,0
input1 db "%s",0
input2 db "%s",0
input3 db "%s",0
test1 db "Test output %7.6lf.", 10,0

segment .bss  ;Reserved for uninitialized data

segment .text ;Reserved for executing instructions.

quadRoot:

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
mov rdi, welcome               ;"The Assembly function floatio has begun execution"
call printf
pop rax

;============= Begin section to input ========================================================
push qword 0
;Display a prompt message asking for inputs
mov rax, 0
mov rdi, inputprompt          ;"Please input 1 floating point numbers using the keyboard: "
call printf
pop rax



;============= Input and Check Valid Inputs 1 ===============================
;Begin the scanf block
mov rax, 1
sub rsp,1024
mov rdi, input1
mov rsi, rsp
call scanf

;Check if value is float
mov rax,0
mov rdi, rsp
call isfloat
cmp rax, 0
je invalid

jmp valid


valid:
;Convert to float
mov rax,0
mov rdi,rsp
call atof
movsd xmm10, xmm0

;Check if value is 0.0 for a which is invalid
mov r8, 0
cvtsi2sd xmm9,r8
ucomisd xmm10,xmm9
je invalid

push qword 0
mov rax,0
add rsp,1024
pop rax

;============= End of Input and Check Valid Inputs 1 ===============================

;============= Input and Check Valid Inputs 2 ===============================
;Begin the scanf block
mov rax, 1
sub rsp,1024
mov rdi, input2
mov rsi, rsp
call scanf

;Check if value is float
mov rax,0
mov rdi, rsp
call isfloat
cmp rax, 0
je invalid

jmp valid2


valid2:
;Convert to float
mov rax,0
mov rdi,rsp
call atof
movsd xmm11, xmm0
push qword 0
mov rax,0
add rsp,1024
pop rax

;============= End of Input and Check Valid Inputs 2 ===============================

;============= Input and Check Valid Inputs 3 ===============================
;Begin the scanf block
mov rax, 1
sub rsp,1024
mov rdi, input3
mov rsi, rsp
call scanf

;Check if value is float
mov rax,0
mov rdi, rsp
call isfloat
cmp rax, 0
je invalid

jmp valid3

invalid:
push qword 0
mov rdi, error
call printf
pop rax
mov r10, 0
cvtsi2sd xmm10, r10
add rsp,1024
jmp exit

valid3:
;Convert to float
mov rax,0
mov rdi,rsp
call atof
movsd xmm12, xmm0
push qword 0
mov rax,0
add rsp,1024
pop rax
;============= End of Input and Check Valid Inputs 3 ===============================

;============= Output three float value into quadratic equation ====================================
mov rax, 3
mov rdi, output_three_float
movsd xmm0, xmm10
movsd xmm1, xmm11
movsd xmm2, xmm12
call printf
;============= End of Output three float value into quadratic equation ====================================


;============= Checks for roots of quadratic equation ====================================
;Get copy of each value (a,b,c)
movsd xmm13,xmm10 ;copy of a
movsd xmm14,xmm11 ;copy of b
movsd xmm15,xmm12 ;copy of c

mulsd xmm14, xmm14 ;b^2

;Get 4ac
mov r8, 4
cvtsi2sd xmm9,r8
mulsd xmm13,xmm15 ;a*c
mulsd xmm13,xmm9 ;4a*c

subsd xmm14,xmm13 ;(b^2 - 4ac)

;Check (b^2 - 4ac) to 0.00
mov r9,0
cvtsi2sd xmm8,r9
ucomisd xmm14,xmm8
jb noroot    ; less than 0.00
je oneroot   ; equal to 0.00
ja tworoot   ; greater than 0.00

noroot:
mov r9, 0
cvtsi2sd xmm10,r9
call show_no_root
jmp done

oneroot:
;Get -b/2a
mov r10, -1
cvtsi2sd xmm8, r10
mulsd xmm8,xmm11 ;-b
mov r11,2
cvtsi2sd xmm9, r11
mulsd xmm9,xmm10 ;2a
divsd xmm8,xmm9  ;-b/2a
movsd xmm0, xmm8
movsd xmm10,xmm8
call show_one_root
jmp done

tworoot:
; Get values of(-b (+/-) sqrt(b^2 -4ac))/(2a)
sqrtsd xmm9,xmm14 ;sqrt(b^2 -4ac)

;Get -b
mov r10, -1
cvtsi2sd xmm8, r10
mulsd xmm11,xmm8 ;-b
movsd xmm12, xmm11 ; copy of -b

; Solve -b (+/-) sqrt(b^2 -4ac)
addsd xmm11, xmm9 ;-b + sqrt(b^2 -4ac)
subsd xmm12, xmm9 ;-b - sqrt(b^2 -4ac)

;Get 2a
mov r11,2
cvtsi2sd xmm9, r11
mulsd xmm9,xmm10 ;2a

;Solve (-b (+/-) sqrt(b^2 -4ac))/(2a)
divsd xmm11,xmm9 ;(-b + sqrt(b^2 -4ac))/2a
divsd xmm12,xmm9 ;(-b - sqrt(b^2 -4ac))/2a
movsd xmm0,xmm11
movsd xmm1,xmm12
movsd xmm10,xmm11 ;Return the (-b + sqrt(b^2 -4ac))/2a value
call show_two_root
jmp done

done:
movsd xmm0, xmm10 ;Set the return Value

;============= End of the section that Checks for roots of quadratic equation ====================================


;============= Prepare to exit from this program ======================================================================
exit:


;Display good-bye message (the next block of instructions)
push qword 0
mov rax, 0
mov rdi, good_bye              ;"The floating module will return the large number to the caller.  ....."
call printf
pop rax                        ;Reverse the push near the beginning of this asm function.
movsd xmm0, xmm10



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
