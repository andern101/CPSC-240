#!/bin/bash

#Program: QuadRoot
#Author: Albert Truong

#Delete some un-needed files
rm *.o
rm *.out

echo "Assemble Quadratic.asm"
nasm -f elf64 -l Quadratic.lis -o Quadratic.o Quadratic.asm

echo "Compile Second_degree.c"
gcc -c -Wall -m64 -no-pie -o Second_degree.o Second_degree.c -std=c11

echo "Compile isfloat.cpp"
gcc -c -Wall -m64 -no-pie -o isfloat.o isfloat.cpp -std=c++17

echo "Compile Quad_library.cpp"
gcc -c -Wall -m64 -no-pie -o Quad_library.o Quad_library.cpp -std=c++17

echo "Link the object files"
g++ -m64 -no-pie -o quadRootAns.out Quadratic.o Second_degree.o isfloat.o Quad_library.o

echo "Run the program quadRoot:"
./quadRootAns.out

echo "The script file will terminate"





