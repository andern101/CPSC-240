#!/bin/bash

#Program: sumArray
#Author: Albert Truong

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble Control.asm"
nasm -f elf64 -l Control.lis -o Control.o Control.asm

echo "Assemble Fill.asm"
nasm -f elf64 -l Fill.lis -o Fill.o Fill.asm

echo "Assemble Sum.asm"
nasm -f elf64 -l Sum.lis -o Sum.o Sum.asm

echo "Compile Main.c"
gcc -c -Wall -m64 -no-pie -o Main.o Main.c -std=c11

echo "Compile Display.cpp"
gcc -c -Wall -m64 -no-pie -o Display.o Display.cpp -std=c++17

echo "Link the object files"
g++ -m64 -no-pie -o arraySum.out Control.o Fill.o Sum.o Main.o Display.o

echo "Run the program arraySum:"
./arraySum.out

echo "The script file will terminate"





