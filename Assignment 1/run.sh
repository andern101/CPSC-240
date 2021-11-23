#!/bin/bash

#Program: Rectangle Area
#Author: Albert Truong

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble perimeter.asm"
nasm -f elf64 -l perimeter.lis -o perimeter.o perimeter.asm

echo "Compile rectangle.cpp using the gcc compiler"
gcc -c -Wall -m64 -no-pie -o rectangle.o rectangle.cpp

echo "Link the object files using the gcc linker"
gcc -m64 -no-pie -o area.out rectangle.o perimeter.o

echo "Run the program RectangleArea:"
./area.out

echo "The script file will terminate"







