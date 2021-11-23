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
//   File name: Display.cpp
//   Language: C++
//   Max page width: 132 columns
//   Compile: gcc -c -Wall -m64 -no-pie -o Display.o Display.cpp -std=c++17
//   Link: g++ -m64 -no-pie -o arraySum.out Control.o Fill.o Sum.o Main.o Display.o
//   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//
//===== Begin code area ===========================================================================================================

#include <iostream>

extern "C" void Display(double n[],long max);


void Display(double n[],long max)
{
    for(int i=0; i< max; i++)
    {
        printf("%15.12lf \n", n[i]);
    }

}

//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
