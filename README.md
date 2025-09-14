# quiz-system-8086
An interactive multiple-choice quiz system implemented in x86 Assembly using DOS interrupts and mouse interface. Designed for the 8086 microprocessor architecture.
# Quiz System in x86 Assembly

This project is a **multiple-choice quiz system** written in 8086 Assembly language. It runs in real mode DOS using BIOS and DOS interrupts, and even supports **mouse interaction** for answering questions.

##  Features

- Input number of questions and choices.
- Dynamically enter question content and choices.
- Use mouse to select the correct answer.
- Set a timer for the quiz.
- Use of macros for modularity.
- Console UI with cursor control and custom screen clearing.

##  Technologies

- **Language:** 8086 Assembly
- **Platform:** DOS (Real Mode)
- **Tools:** MASM / TASM assembler
- **Interfaces:** BIOS Interrupts (`INT 10h`, `INT 33h`) and DOS Interrupts (`INT 21h`)

##  File Structure

- `TEST.asm`: Main assembly source code file implementing the full quiz system.

##  Mouse Integration

The program uses:
- `INT 33h` for mouse display, configuration, and click detection.
- Cursor-based user interface for selecting choices interactively.

##  Timer Functionality

Users can input the duration of the quiz in minutes. The program then waits for mouse input within that time using a delay loop.

##  How to Run

1. Assemble using **MASM** or **TASM**:
   ```bash
   tasm TEST.asm
   tlink TEST.obj
