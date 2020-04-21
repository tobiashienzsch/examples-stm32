project(spi)

add_library(spi_startup Src/startup_stm32f103xb.s)
add_library(spi_system Src/system_stm32f1xx.c Src/stm32f1xx_it.c Src/stm32f1xx_hal_msp.c)
create_stm32_hal_target(spi_stm32hal)
target_link_libraries(spi_system PUBLIC spi_stm32hal)

if ("${CMAKE_C_COMPILER_ID}" STREQUAL "Clang")
    list(APPEND spi_test_obj ${ARM_TOOLCHAIN_DIR}/../arm-none-eabi/lib/thumb/v7-m/nofp/crt0.o)
    list(APPEND spi_test_obj ${ARM_TOOLCHAIN_DIR}/../lib/gcc/arm-none-eabi/9.2.1/thumb/v7-m/nofp/crti.o)
endif()

add_executable(${PROJECT_NAME} Src/main.cpp ${spi_test_obj})
target_link_libraries(${PROJECT_NAME} spi_startup spi_system)

firmware_size(${PROJECT_NAME})
generate_object(${PROJECT_NAME} .bin binary)

if ("${CMAKE_C_COMPILER_ID}" STREQUAL "GNU")
    generate_object(${PROJECT_NAME} .hex ihex)
endif()
