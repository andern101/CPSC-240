;****************************************************************************************************************************
;Program name: "SalaryInterview".  This program demonstrates the input of the user name and salary and ask various questions that *
;may alter the salary of the user. In addition would calculate resistance of the circuit.                                   *
;Copyright (C) 2021 Albert Truong.                                                                                         *
;                                                                                                                           *
;This file is part of the software program "SalaryInterview".                                                                *
;SalaryInterview is free software: you can redistribute it and/or modify it under the terms of the GNU General Public        *
;License version 3 as published by the Free Software Foundation.                                                            *
;SalaryInterview is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied       *
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
;  Program name: SalaryInterview
;  Programming languages: One modules in C++ and one module in X86
;  Date program began: 2021-Apr-15
;  Date of last update: 2021-Apr-25
;  Date of reorganization of comments: 2021-Apr-25
;  Files in this program: Main.cpp, interview.asm
;  Status: Finished.  The program was tested extensively with no errors in Ubuntu20.04 LTS on Windows 10 utilizing WSL.
;
;Purpose
;  This program demonstrates the input of the user name and salary and ask various questions that
;  may alter the salary of the user. In addition would calculate resistance of the circuit.
;
;This file
;   File name: interview.asm
;   Language: X86 with Intel syntax.
;   Max page width: 132 columns
;   Assemble: nasm -f elf64 -l interview.lis -o interview.o interview.asm

;===== Begin code area ================================================================================================
extern printf
extern scanf
global work

segment .data
welcome db "Hello %s I am Ms Fenster.  The interview will begin now.",10,0
wow db "Wow! $%8.2lf. ",0
low1 db "That's not a lot of cash. ",10,0
high1 db "That's a lot of cash. ",10,0
mid1 db "That's a good salary. ",10,0
sawyercheck db "Who do you think you are, Chris Sawyer (y or n)? ",10,0
sawyercheckAns db "%s",0
resistanceWelcome db "Alright. Now we will work on your electricity.",10,0
circuit1prompt db "Please enter the resistance of circuit #1 in ohms: ",10 ,0
circuit2prompt db "What is the resistance of circuit #2 in ohms: ",10 ,0
circuit1 db "%lf",0
circuit2 db "%lf",0
totalResistance db "The total resistance is %7.8lf Ohms.",10,0
cscheck db "Were you a computer science major (y or n)? ",10,0
cscheckAns db "%s",0
good_bye db "Thank you.  Please follow the exit signs to the front desk.",10,0
sample db "%s",0
tester db "Yes, This is a Test",10,0

segment .bss  ;Reserved for uninitialized data

segment .text ;Reserved for executing instructions.

work:

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

;Save the value passed through from the main    
mov r15, rdi        ;Save the Name value
movsd xmm15, xmm0   ;Save the Salary value

;===== Analyze Salary of the User ===================================================================
;Welcome user with a message
push qword 0
mov rax, 0
mov rdi, welcome    ;"Hello %s . I am Ms Fenster.  The interview will begin now."
mov rsi, r15
call printf
pop rax

;Print Wow message with salary
mov rax, 1
mov rdi, wow   ;"Wow! $%8.2lf"
movsd xmm0, xmm15
call printf

;Convert 50,000 to float to check salary
mov r10, 50000
cvtsi2sd xmm10, r10

;Convert 200,000 to float to check salary
mov r10, 200000
cvtsi2sd xmm11, r10

;Compare salary to see if below 50,000
ucomisd xmm15, xmm10
jb low

;Compare salary to see if above 200,000
ucomisd xmm15, xmm11
ja high

;Salary if above 50,000 but below 200,000
mov rax, 1
mov rdi, mid1   ;"That's an good salary. "
call printf
jmp sawyerLoop

;Salary if below 50,000
low:
mov rax, 1
mov rdi, low1   ;"That's not a lot of cash. "
call printf
jmp sawyerLoop

;Salary if above 200,000
high:
mov rax, 1
mov rdi, high1  ;"That's a lot of cash. "
call printf
jmp sawyerLoop

;===== Ask if User is Chris Sawyer ===================================================================
;Begin Loop of Sawyer Question if answer is not y or n
sawyerLoop:
push qword 0
mov rax, 0
mov rdi, sawyercheck    ;"Who do you think you are, Chris Sawyer (y or n)? "
call printf
pop rax

;Scan block to check for y or n
mov rax, 0
mov rdi, sawyercheckAns
mov rsi, rsp
call scanf
mov r15, [rsp]

;Check Sawyer question answered y
cmp r15, 'y'
je sawyerYes

;Sawyer question answered n if not would reset loop
cmp r15, 'n'
je sawyerNo
jne sawyerLoop

;Sawyer question answered y and set return salary value to 1,000,000 and go to exit
sawyerYes:
mov r10, 1000000
cvtsi2sd xmm15, r10
jmp exit

;===== Collect Resistance Values of the Circuit ===================================================================
;Sawyer question answered n and begins Resistant Calculation    
sawyerNo:
push qword 0
mov rax, 0
mov rdi, resistanceWelcome  ;"Alright. Now we will work on your electricity."
call printf
pop rax

;Display a prompt message asking for circuit 1 resistance
push qword 0
mov rax, 0
mov rdi, circuit1prompt          ;"Please enter the resistance of circuit #1 in ohms: "
call printf
pop rax

;begin scan block for circuit 1 resistance
mov rax, 1
mov rdi, circuit1
mov rsi, rsp
call scanf
movsd xmm11, [rsp]

;Display a prompt message asking for circuit 2 resistance
push qword 0
mov rax, 0
mov rdi, circuit2prompt          ;"What is the resistance of circuit #2 in ohms: "
call printf
pop rax

;begin scan block for circuit 2 resistance
mov rax, 1
mov rdi, circuit2
mov rsi, rsp
call scanf
movsd xmm12, [rsp]

;===== Calculate Resistance of the Circuit ===================================================================
;Convert 1 to float and set xmm14 to 1
mov r8,1
cvtsi2sd xmm13, r8   ;Convert 1 to float
movsd xmm14, xmm13   ;Set xmm14 to 1

;Divide values 1/(the circuit resistance value)
divsd xmm13,xmm11   ;Divide 1(xmm13)/xmm10
divsd xmm14,xmm12   ;Divide 1(xmm14)/xmm11

;Add Each xmm13,xmm14 together into xmm9
addsd xmm9,xmm13
addsd xmm9,xmm14

;Divide 1(xmm8)/xmm9 to convert added solution to the correct solution
mov r9,1        
cvtsi2sd xmm8, r9   ;Convert 1 to float
divsd xmm8,xmm9     ;Divide 1(xmm8)/xmm9 to convert added solution to the correct solution

;Print total resistance value of the circuit
mov rax, 1
mov rdi, totalResistance			;"The resistance of the entire circuit is %7.8lf"
movsd xmm0, xmm8
call printf

;===== Ask if user is Computer Science Major ===================================================================
;Begin the Computer Science Major Question Loop
csLoop:
push qword 0
mov rax, 0
mov rdi, cscheck    ;"Were you a computer science major (y or n)? "
call printf
pop rax

;Reset the stack before scan block
pop rax
push qword 0

;Scan block for Computer Science Question either y or n
mov rax, 0
mov rdi, cscheckAns
mov rsi, rsp
call scanf
mov r10, [rsp]

;Check Computer Science question answered n
cmp r10, 'n'
je csNo

;Check Computer Science question answered y if not would reset loop
cmp r10, 'y'
je csYes
jne csLoop

;Computer Science question answered n and set xmm15 to nonCS value which is 1200.12 and exit
csNo:
mov r12, 0x4092C07AE147AE14 ; IEEE 754 - 1200.12
movq xmm15, r12
jmp exit

;Computer Science question answered y and set xmm15 to CSMaj value which is 88000.88 and exit
csYes:
mov r12,0x40F57C0E147AE148 ;IEEE 754 - 88000.88
movq xmm15, r12
jmp exit

;Exit where it output good bye message and return xmm15 value to the main.cpp
exit:
push qword 0
mov rax, 0
mov rdi, good_bye   ;"Thank you.  Please follow the exit signs to the front desk."
call printf
pop rax

movsd xmm0,xmm15

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
