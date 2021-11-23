//****************************************************************************************************************************
//Program name: "Rectangle Area".  This program demonstrates the input of multiple float numbers from the standard input     *
//device using a single instruction and the output of the perimeter and the average size length                              *
// Copyright (C) 2021 Albert Truong.                                                                                         *
//                                                                                                                           *
//This file is part of the software program "Rectangle Area".                                                                *
//Rectangle Area is free software: you can redistribute it and/or modify it under the terms of the GNU General Public        *
//License version 3 as published by the Free Software Foundation.                                                            *
//Rectangle Area is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied       *
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
//  Program name: Rectangle Area
//  Programming languages: One modules in C++ and one module in X86
//  Date program began: 2021-Jan-25
//  Date of last update: 2021-Feb-13
//  Date of reorganization of comments: 2021-Feb-13
//  Files in this program: rectangle.cpp, perimeter.asm
//  Status: Finished.  The program was tested extensively with no errors in Ubuntu20.04 LTS on Windows 10 utilizing WSL.
//
//Purpose
//  Show how to input height and length side floating point (64-bit) numbers and output the perimeter and avg. length side.
//
//This file
//   File name: rectangle.cpp
//   Language: C++
//   Max page width: 132 columns
//   Compile: gcc -c -Wall -m64 -no-pie -o rectangle.o rectangle.cpp
//   Link: -m64 -no-pie -o area.out rectangle.o perimeter.o
//   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//
//===== Begin code area ===========================================================================================================

#include <stdio.h>
#include <stdint.h> //For C99 compatibility
#include <stdlib.h>   //For malloc
//At the time of this writing C99 is the newest available standard for C language.  Most modern C compilers conform to the C99 
//standard.  The GNU compiler, known as gcc, is C99 compliant.  If both languages, C and X86, are C99 compliant then object code 
//files from both compilers may be linked to form a single executable. 
//
//The standard prototypes for any functions that may be called later.  This main function calls exactly one function.
extern "C" double rectangleArea();
//
int main()
{
 double answer = 0.000;
 printf("Welcome to a friendly assembly program by Albert Truong\n");
 answer = rectangleArea();
 printf("The main function recieved this number %5.3lf and has decided to keep it.\n", answer);
 printf("A 0 will be returned to the operating system.\nHave a nice day\n");
 return 0;
}
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**




