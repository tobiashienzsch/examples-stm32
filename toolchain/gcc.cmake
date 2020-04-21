set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR ARM)

if(MINGW OR CYGWIN OR WIN32)
    set(UTIL_SEARCH_CMD where)
elseif(UNIX OR APPLE)
    set(UTIL_SEARCH_CMD which)
endif()

set(TOOLCHAIN_PREFIX arm-none-eabi-)

execute_process(
  COMMAND ${UTIL_SEARCH_CMD} ${TOOLCHAIN_PREFIX}gcc
  OUTPUT_VARIABLE BINUTILS_PATH
  OUTPUT_STRIP_TRAILING_WHITESPACE
)

get_filename_component(ARM_TOOLCHAIN_DIR ${BINUTILS_PATH} DIRECTORY)

set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
set(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}gcc)
set(CMAKE_ASM_COMPILER ${TOOLCHAIN_PREFIX}gcc)
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PREFIX}g++)
SET(CMAKE_AR ${TOOLCHAIN_PREFIX}gcc-ar)
SET(CMAKE_NM ${TOOLCHAIN_PREFIX}nm)
SET(CMAKE_RANLIB ${TOOLCHAIN_PREFIX}ranlib)

set(CMAKE_OBJCOPY ${ARM_TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}objcopy CACHE INTERNAL "objcopy tool")
set(CMAKE_SIZE_UTIL ${ARM_TOOLCHAIN_DIR}/${TOOLCHAIN_PREFIX}size CACHE INTERNAL "size tool")

set(CMAKE_SYSROOT ${ARM_TOOLCHAIN_DIR}/../arm-none-eabi)
set(CMAKE_FIND_ROOT_PATH ${BINUTILS_PATH})
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

set(CPU_FLAGS " -mthumb -mcpu=cortex-m3 -march=armv7-m -mfloat-abi=soft")
set(COMPILER_FLAGS "-ffreestanding -ffunction-sections -fdata-sections -fsigned-char -fmessage-length=0 -fshort-enums")

set(CMAKE_C_FLAGS             "${CPU_FLAGS} ${COMPILER_FLAGS}" CACHE INTERNAL "c compiler flags")
set(CMAKE_CXX_FLAGS           "${CPU_FLAGS} ${COMPILER_FLAGS}" CACHE INTERNAL "cxx compiler flags")
set(CMAKE_ASM_FLAGS           "${CPU_FLAGS}" CACHE INTERNAL "asm compiler flags")
set(CMAKE_EXE_LINKER_FLAGS    "${CPU_FLAGS}" CACHE INTERNAL "linker flags release")

set(CMAKE_C_FLAGS_DEBUG             "-Og -g -DDEBUG" CACHE INTERNAL "c compiler flags debug")
set(CMAKE_CXX_FLAGS_DEBUG           "-Og -g -DDEBUG" CACHE INTERNAL "cxx compiler flags debug")
set(CMAKE_ASM_FLAGS_DEBUG           "-g" CACHE INTERNAL "asm compiler flags debug")
set(CMAKE_EXE_LINKER_FLAGS_DEBUG    "" CACHE INTERNAL "linker flags debug")

set(CMAKE_C_FLAGS_RELEASE           " -Os -DNDEBUG " CACHE INTERNAL "c compiler flags release")
set(CMAKE_CXX_FLAGS_RELEASE         " -Os -DNDEBUG " CACHE INTERNAL "cxx compiler flags release")
set(CMAKE_ASM_FLAGS_RELEASE         "" CACHE INTERNAL "asm compiler flags release")
set(CMAKE_EXE_LINKER_FLAGS_RELEASE  " " CACHE INTERNAL "linker flags release")

string(REGEX MATCH ".*\.specs.*" has_specs "${CMAKE_EXE_LINKER_FLAGS}")
if(NOT has_specs)
    string(APPEND CMAKE_EXE_LINKER_FLAGS " -specs=nosys.specs")
endif()