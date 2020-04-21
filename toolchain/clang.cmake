set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR ARM)

if(MINGW OR CYGWIN OR WIN32)
    set(UTIL_SEARCH_CMD where)
elseif(UNIX OR APPLE)
    set(UTIL_SEARCH_CMD which)
endif()

set(TOOLCHAIN_PREFIX arm-none-eabi-)
set(TOOLCHAIN_TRIPLE arm-none-eabi)

execute_process(
        COMMAND ${UTIL_SEARCH_CMD} ${TOOLCHAIN_PREFIX}gcc
        OUTPUT_VARIABLE BINUTILS_PATH
        OUTPUT_STRIP_TRAILING_WHITESPACE
)

get_filename_component(ARM_TOOLCHAIN_DIR ${BINUTILS_PATH} DIRECTORY)
set(triple ${TOOLCHAIN_TRIPLE})
set(CMAKE_ASM_COMPILER clang-9)
set(CMAKE_C_COMPILER clang-9)
set(CMAKE_C_COMPILER_TARGET ${triple})
set(CMAKE_CXX_COMPILER clang++-9)
set(CMAKE_CXX_COMPILER_TARGET ${triple})

set(CMAKE_C_FLAGS_INIT " -B${ARM_TOOLCHAIN_DIR} ")
set(CMAKE_CXX_FLAGS_INIT " -B${ARM_TOOLCHAIN_DIR}  ")
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

set(CMAKE_OBJCOPY llvm-objcopy CACHE INTERNAL "objcopy tool")
set(CMAKE_SIZE_UTIL llvm-size CACHE INTERNAL "size tool")

set(CMAKE_SYSROOT ${ARM_TOOLCHAIN_DIR}/../${TOOLCHAIN_TRIPLE})
set(CMAKE_FIND_ROOT_PATH ${ARM_TOOLCHAIN_DIR}/../${TOOLCHAIN_TRIPLE})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# Optimizations
set(CMAKE_C_FLAGS_DEBUG             "-Og -ggdb3 -DDEBUG" CACHE INTERNAL "c compiler flags debug")
set(CMAKE_CXX_FLAGS_DEBUG           "-Og -ggdb3 -DDEBUG" CACHE INTERNAL "cxx compiler flags debug")
set(CMAKE_ASM_FLAGS_DEBUG           "-ggdb3" CACHE INTERNAL "asm compiler flags debug")
set(CMAKE_EXE_LINKER_FLAGS_DEBUG    "" CACHE INTERNAL "linker flags debug")

set(CMAKE_C_FLAGS_RELEASE           "-flto -Oz -DNDEBUG " CACHE INTERNAL "c compiler flags release")
set(CMAKE_CXX_FLAGS_RELEASE         "-flto -Oz -DNDEBUG " CACHE INTERNAL "cxx compiler flags release")
set(CMAKE_ASM_FLAGS_RELEASE         "" CACHE INTERNAL "asm compiler flags release")
set(CMAKE_EXE_LINKER_FLAGS_RELEASE  "-fuse-ld=lld -flto" CACHE INTERNAL "linker flags release")

string(APPEND CMAKE_EXE_LINKER_FLAGS " -nostdlib")
string(APPEND CMAKE_EXE_LINKER_FLAGS " -L${ARM_TOOLCHAIN_DIR}/../arm-none-eabi/lib/thumb/v7-m/nofp")
string(APPEND CMAKE_EXE_LINKER_FLAGS " -L${ARM_TOOLCHAIN_DIR}/../lib/gcc/arm-none-eabi/9.2.1/thumb/v7-m/nofp")
string(APPEND CMAKE_EXE_LINKER_FLAGS " -lgcc -lnosys -lc")