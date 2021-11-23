//****************************************************************************************************************************
//Program name: "QuadRoot".  This program demonstrates the input of three float numbers from the standard input        *
//device utilizing those values to obtain a quadratic equation and output how many roots and what value the roots are  *                             *
// Copyright (C) 2021 Albert Truong.                                                                                   *
//                                                                                                                     *
//This file is part of the software program "QuadRoot".                                                                *
//QuadRoot is free software: you can redistribute it and/or modify it under the terms of the GNU General Public        *
//License version 3 as published by the Free Software Foundation.                                                      *
//QuadRoot is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied       *
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
//  Program name: QuadRoot
//  Programming languages: One modules in C, Two modules in C++ and one module in X86
//  Date program began: 2021-Feb-20
//  Date of last update: 2021-Feb-17
//  Date of reorganization of comments: 2021-Feb-17
//  Files in this program: Second_degree.c, isfloat.cpp, Quad_library.cpp,  Quadratic.asm
//  Status: Finished.  The program was tested extensively with no errors in Ubuntu20.04 LTS on Windows 10 utilizing WSL.
//
//Purpose
//  User input 3 float values (a,b,c). Those values would be placed into quadratic equation and program would determine
//  how many roots and what the roots would be for the quadratic equation.
//
//This file
//   File name: Second_degree.c
//   Language: C
//   Max page width: 132 columns
//   Compile: gcc -c -Wall -m64 -no-pie -o Second_degree.o Second_degree.c -std=c11
//   Link: g++ -m64 -no-pie -o quadRootAns.out Quadratic.o Second_degree.o isfloat.o Quad_library.o
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

extern double quadRoot();
//
int main(int argc, char* argv[])
{double answer = 0.0;
 printf("Welcome to Root Calculator.\nProgrammed by Albert Truong, Professional Programmer.\n");
 answer = quadRoot();
 printf("The main driver received %8.12lf and has decided to keep it.\n",answer);
 printf("Now 0.00 will be returned to the operating system. Have a nice day. Bye.\n");
 return 0;
}
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**




