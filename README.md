# Simple-Computer-System

This project involves the design and implementation of a 5-stage pipeline CPU using Verilog and an operating system written in C, compiled to RISC-V instructions. The project also includes a simple user interface and support for various keyboard commands.

## Features

### CPU Design
- **5-Stage Pipeline CPU**: Implemented in Verilog, supporting RISC-V instructions.
- **Operating System**: Developed in C and compiled to run on the RISC-V architecture.

### User Interface
- **Character Input**: Supports case sensitivity, deletion, text wrapping, and screen scrolling.
- **Keyboard Commands**: Includes commands for echoing input, displaying the current time, and performing arithmetic calculations.

## Project Structure

- `cpu.hw/`
- `cpu.ip_user_files/`
- `cpu.srcs/`

### 1. `cpu.hw/`
This folder includes the hardware design files for the CPU. It contains the HDL (Hardware Description Language) files, such as Verilog or VHDL, which define the hardware logic of the CPU. The design in this folder represents the core architecture of the processor being developed or simulated on the FPGA.

### 2. `cpu.ip_user_files/`
This directory holds user-specific configuration and files related to the use of IP (Intellectual Property) cores. IP cores are pre-designed and pre-verified blocks, which can be used to accelerate development. This folder might include configuration files, custom parameter settings, or modifications made to the standard IP cores used in the project.

### 3. `cpu.srcs/`
The `srcs` (sources) folder holds the source code files for the CPU system. These can include the HDL files (Verilog/VHDL), testbenches, simulation scripts, and constraint files. The `cpu.srcs` directory typically forms the backbone of the project, as it contains the fundamental code that describes how the FPGA should be configured and how the CPU will behave.

## Getting Started

### Prerequisites
- Vivado Design Suite (e.g., Xilinx Vivado)

### Installation
1. Clone the repository:
    ```sh
    git clone https://github.com/yun-ni-2024/Simple-Computer-System.git
    ```
2. Navigate to the project directory:
    ```sh
    cd yun-ni-2024/Simple-Computer-System
    ```

### Using Vivado to Run the Project and Generate the Bitstream
1. **Open Vivado**:
    - Launch Vivado Design Suite on your computer.

2. **Create a New Project**:
    - Go to `File` > `New Project`.
    - Follow the wizard to create a new project, specifying the project name and location.

3. **Add Sources**:
    - Add the HDL files from the `cpu.hw/` and `cpu.srcs/` directories to the project.
    - Include any necessary constraint files from the `cpu.srcs/` directory.

4. **Configure IP Cores**:
    - If using IP cores, configure them according to the settings in the `cpu.ip_user_files/` directory.

5. **Synthesize the Design**:
    - Click on `Run Synthesis` to synthesize the HDL design.

6. **Implement the Design**:
    - After synthesis, click on `Run Implementation` to implement the design.

7. **Generate the Bitstream**:
    - Once implementation is complete, click on `Generate Bitstream` to create the binary bitstream file.

### Commands
- **Echo Input**: Type any text after `echo` and press Enter to see it echoed back.
- **Show Time**: Type `time` to display the current system time.
- **Fibnacci**: Type a number after `fib` and press Enter to see the Fibnacci item indexed by the number.
- **Calculate Expressions**: Type arithmetic expressions (e.g., `eval 2 + 2`) to see the result.
- **Bubble Sort**: Type `bs` followed by a list of numbers to sort them using bubble sort.
- **Quick Sort**: Type `qs` followed by a list of numbers to sort them using quicksort.

## Effect Display

Here are some images to showcase the effects:

![](rsc/1.png)
![](rsc/2.png)
![](rsc/3.png)
![](rsc/4.png)
