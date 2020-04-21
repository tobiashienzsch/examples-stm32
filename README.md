# Examples STM32 + CMake + C/C++

Build the examples from the [STMicroelectronics/STM32CubeF1](https://github.com/STMicroelectronics/STM32CubeF1) library with `CMake`, `GCC` & `Clang`

## Quick Start

```sh
git clone --recursive https://github.com/tobiashienzsch/examples-stm32.git
```

```sh
make CONFIG=Release     # GCC release build. Release is default.
make clean              # Remove build dir
make CLANG=1            # Clang release build
```

## ToDo

- LTO for GCC.
- Fix warnings with clang asm files.
- Set linker script in each project. Not globally.
