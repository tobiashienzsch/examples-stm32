cmake_minimum_required(VERSION 3.13)
project(stm32-examples ASM C CXX)

# Only do these if this is the main project, 
# and not if it is included through add_subdirectory
if(CMAKE_PROJECT_NAME STREQUAL PROJECT_NAME)
    set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
    set(CMAKE_EXECUTABLE_SUFFIX ".elf")
    
    set(CMAKE_C_STANDARD 11)
    set(CMAKE_C_STANDARD_REQUIRED ON)
    set(CMAKE_C_EXTENSIONS OFF)

    set(CMAKE_CXX_STANDARD 17)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)
    set(CMAKE_CXX_EXTENSIONS OFF)

    set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
    set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
    set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
endif()

set(STM_HAL_SDK "${CMAKE_CURRENT_LIST_DIR}/3rd_party/STM32CubeF1")
set(LINKER_FILE "${CMAKE_CURRENT_LIST_DIR}/linker_scripts/STM32F103VBIx_FLASH.ld")

string(APPEND CMAKE_EXE_LINKER_FLAGS " -Wl,-T ${LINKER_FILE}")
string(APPEND CMAKE_EXE_LINKER_FLAGS " -Wl,--gc-sections")

include(cmake/utils.cmake)
include(cmake/stm32.cmake)

add_subdirectory(examples/gpio)
add_subdirectory(examples/spi)
add_subdirectory(examples/uart)

