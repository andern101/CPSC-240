//****************************************************************************************************************************
//Program name: "sumArray".  This program demonstrates the input of float numbers into an array from the standard input       *
//device utilizing those values to obtain the sum of float numbers in the array                                               *
// Copyright (C) 2021 Albert Truong.                                                                                   *
//                                                                                                                     *
//This file is part of the software program "sumArray".                                                                *
//sumArray is free software: you can redistribute it and/or modify it under the terms of the GNU General Public        *
//License version 3 as published by the Free Software Foundation.                                                      *
//sumArray is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied       *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https:;www.gnu.org/licenses/>.                            *
//****************************************************************************************************************************


//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//Author information
//  Author name: Albert Truong
//  Author email: atruong811@fullerton.edu
//
//Program information
//  Program name: sumArray
//  Programming languages: One modules in C, One modules in C++ and three module in X86
//  Date program began: 2021-March-10
//  Date of last update: 2021-March-21
//  Date of reorganization of comments: 2021-March-21
//  Files in this program: Main.c, Control.asm, Fill.asm,  Sum.asm, Display.cpp
//  Status: Finished.  The program was tested extensively with no errors in Ubuntu20.04 LTS on Windows 10 utilizing WSL.
//
//Purpose
//  User input float values into an array. Those values would be of the array would be added up and the sum value would be
//  returned to the main. 
//
//This file
//   File name: Main.c
//   Language: C
//   Max page width: 132 columns
//   Compile: gcc -c -Wall -m64 -no-pie -o Main.o Main.c -std=c11
//   Link: g++ -m64 -no-pie -o arraySum.out Control.o Fill.o Sum.o Main.o Display.o
//   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//
//===== Begin code area ===========================================================================================================

#include <stdio.h>
#include <stdint.h> //For C99 compatibility
#include <time.h>
//#include <sys/time.h>
#include <stdlib.h>   //For malloc

extern double sumArray();
//
int main(int argc, char* argv[])
{double answer = 0.0;
 printf("Welcome to High Speed Array Summation by Albert Truong.\n");
  printf("Software Licensed by GNU GPL 3.0\nVersion 1.0 released on January 28, 2021.\n");
 answer = sumArray();
 printf("The main has received this number %8.12lf and has decided to keep it.\n",answer);
 printf("Thank you for using High Speed Array Software.\n");
 printf("For system support contact Albert Truong at atruong811@csu.fullerton.edu\n");
 printf("A zero will be returned to the operating system.\n");
 return 0;
}
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**




