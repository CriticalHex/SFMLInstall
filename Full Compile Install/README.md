# SFML C++ Project Setup

This project aims to provide a simple and straightforward way to set up a C++ development environment with SFML, including downloading a C++ compiler, precompiled SFML libraries, and installing MinGW make and CMake. It also offers an example C++ program that utilizes SFML, as well as a more complex program that demonstrates mutlifile compilation and dependencies with Makefile.

## Prerequisites

You don't need an IDE to write c++ code, but you'll want one. The example projects contain a VSCode build script, so VSCode is encouraged.

## Getting Started

To set up your development environment, follow these steps:

1. **Install Visual Studio Code:**
   - If you haven't already, download and install Visual Studio Code from the [official website](https://code.visualstudio.com/).

2. **Install C++ Extension:**
   - Open Visual Studio Code.
   - Go to the Extensions view by clicking on the square icon on the sidebar or pressing `Ctrl + Shift + X`.
   - Search for "C++" in the Extensions view search bar.
   - Click on the "Install" button next to the "C++" extension provided by Microsoft.

## Compiling Your Program

There are two methods to compile your C++ program:

### Method 1: Using Visual Studio Code Build Task

1. Open a project folder in Visual Studio Code.

2. Press `Ctrl + Shift + B` to build the program.

3. Once the compilation is complete, you can find the executable file in the project directory.

4. To run it, ensure that your terminal is in the right folder, and just type the name of the executable in the terminal. You could also run `mingw32-make run`

5. To change directories, you can use `cd {directory name}`, to go to a folder within the one you're in, and `cd ..` to move up out of the folder you're in.

### Method 2: Manual Compilation

1. Open the terminal and navigate to the directory with the Makefile in it.

2. Run the following command to compile your program: `mingw32-make`

3. Once the compilation is complete, you can find the executable file in the project directory.

4. To run it, ensure that your terminal is in the right folder, and just type the name of the executable in the terminal. You could also run `mingw32-make run`

5. To change directories, you can use `cd {directory name}`, to go to a folder within the one you're in, and `cd ..` to move up out of the folder you're in.

## Understanding Compilation Process

- **Makefile**: The Makefile is a script that contains instructions on how to compile the C++ program. It specifies dependencies and commands for the compiler to execute.
- **Make**: Make is a build automation tool that reads the Makefile and executes the commands necessary to compile the program.