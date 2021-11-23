//****************************************************************************************************************************
//Program name: "QuadRoot".  This program demonstrates the input of multiple float numbers from the standard input     *
//device device utilizing those values to obtain a quadratic equation and output how many roots and what value the roots are *
// Copyright (C) 2021 Albert Truong.                                                                                         *
//                                                                                                                           *
//This file is part of the software program "QuadRoot".                                                                *
//QuadRoot is free software: you can redistribute it and/or modify it under the terms of the GNU General Public        *
//License version 3 as published by the Free Software Foundation.                                                            *
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
//   File name: Quad_library.cpp
//   Language: C++
//   Max page width: 132 columns
//   Compile: gcc -c -Wall -m64 -no-pie -o Quad_library.o Quad_library.cpp -std=c++17
//   Link: g++ -m64 -no-pie -o quadRootAns.out Quadratic.o Second_degree.o isfloat.o Quad_library.o
//   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//===== Begin code area ================================================================================================

#include <iostream>

extern "C" void Quad_library();
extern "C" void show_no_root();
extern "C" void show_one_root(double root);
extern "C" void show_two_root(double root1, double root2);

void show_no_root()
{
    printf("There exist no roots from the equation.\n");
}

void show_one_root(double root)
{
        printf("The one root from the equation is %8.12lf\n",root);

}

void show_two_root(double root1, double root2)
{
        printf("The two root from the equation is %8.12lf and %8.12lf\n",root1 ,root2);

}
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
