#!/bin/bash

#Program: SalaryInterview
#Author: Albert Truong

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble interview.asm"
nasm -f elf64 -l interview.lis -o interview.o interview.asm

echo "Compile Main.cpp"
gcc -c -Wall -m64 -g -gdwarf -no-pie -o Main.o Main.cpp -std=c++17

echo "Link the object files"
g++ -m64 -no-pie -o salary.out interview.o Main.o

echo "Run the program SalaryInterview in GDB:"
gdb ./salary.out
echo "The script file will terminate"





