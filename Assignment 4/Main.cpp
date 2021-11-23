//****************************************************************************************************************************
//Program name: "SalaryInterview".  This program demonstrates the input of the user name and salary and ask various questions that *
//may alter the salary of the user. In addition would calculate resistance of the circuit.                                   *
//Copyright (C) 2021 Albert Truong.                                                                                         *
//                                                                                                                           *
//This file is part of the software program "SalaryInterview".                                                                *
//SalaryInterview is free software: you can redistribute it and/or modify it under the terms of the GNU General Public        *
//License version 3 as published by the Free Software Foundation.                                                            *
//SalaryInterview is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied       *
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
//  Program name: SalaryInterview
//  Programming languages: One modules in C++ and one module in X86
//  Date program began: 2021-Apr-15
//  Date of last update: 2021-Apr-25
//  Date of reorganization of comments: 2021-Apr-25
//  Files in this program: Main.cpp, interview.asm
//  Status: Finished.  The program was tested extensively with no errors in Ubuntu20.04 LTS on Windows 10 utilizing WSL.
//
//Purpose
//  This program demonstrates the input of the user name and salary and ask various questions that
//  may alter the salary of the user. In addition would calculate resistance of the circuit.
//
//This file
//   File name: Main.cpp
//   Language: C++
//   Max page width: 132 columns
//   Compile: gcc -c -Wall -m64 -no-pie -o Main.o Main.cpp
//   Link: -m64 -no-pie -o area.out Main.o interview.o
//   Optimal print specification: 132 columns width, 7 points, monospace, 8½x11 paper
//
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
//
//
//===== Begin code area ===========================================================================================================

#include <stdio.h>
#include <stdint.h> //For C99 compatibility
#include <stdlib.h>   //For malloc
#include <iomanip>      // setprecision()
#include <iostream>     // cout, fixed(), showpoint()
#include <string>
#include <fstream>
//At the time of this writing C99 is the newest available standard for C language.  Most modern C compilers conform to the C99 
//standard.  The GNU compiler, known as gcc, is C99 compliant.  If both languages, C and X86, are C99 compliant then object code 
//files from both compilers may be linked to form a single executable. 
//
//The standard prototypes for any functions that may be called later.  This main function calls exactly one function.
extern "C" double work(char[], double);
int main()
{
 char name[100];
 double salary,number;
 std::cout << "Welcome to Software Analysis by Paramount Programmers, Inc.\n";
 std::cout << "Please enter your first and last names and press enter: \n";
 fgets(name,sizeof(name),stdin);
 std::cout << "Thank you " << name << "Our records show that you applied for employment her with our agency a week ago.\n";
 std::cout << "Please enter your expected annual salary when employed at Paramount: ";
 std::cin >> salary;
 std::cout << "\nYour interview with Ms Linda Fenster, Personnel Manager, will begin shortly.\n";
 number = work(name,salary);
 if(number == 1000000)
 std::cout <<"Hello Mr Sawyer. I am the receptionist\n";
 else
 std::cout <<"Hello " << name  << "I am the receptionist\n";

 if(number == 1200.12)
   printf("We have an opening for you in the company cafeteria for $%5.2lf annually.\nTake your time to let use know your decision.\nBye\n", number);
 else if(number == 1000000)
 std::cout << "This envelope has your job offer starting at 1 million annual. Please start any time you like. In the middle time our CTO wishes to have dinner with you.\nHave very nice evening Mr Sawyer.\n";
 else
   printf("This envelope contains your job offer with starting salary $%5.2lf. Please check back on Monday morning at 8am.\nBye\n", number);


 return 0;
}