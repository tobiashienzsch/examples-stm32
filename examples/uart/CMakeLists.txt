project(uart)

add_library(uart_startup Src/startup_stm32f103xb.s)
add_library(uart_system Src/system_stm32f1xx.c Src/stm32f1xx_it.c Src/stm32f1xx_hal_msp.c)
create_stm32_hal_target(uart_stm32hal)
target_link_libraries(uart_system PUBLIC uart_stm32hal)

if ("${CMAKE_C_COMPILER_ID}" STREQUAL "Clang")
    list(APPEND uart_test_obj ${ARM_TOOLCHAIN_DIR}/../arm-none-eabi/lib/thumb/v7-m/nofp/crt0.o)
    list(APPEND uart_test_obj ${ARM_TOOLCHAIN_DIR}/../lib/gcc/arm-none-eabi/9.2.1/thumb/v7-m/nofp/crti.o)
endif()

add_executable(${PROJECT_NAME} Src/main.c ${uart_test_obj})
target_link_libraries(${PROJECT_NAME} uart_startup uart_system)

firmware_size(${PROJECT_NAME})
generate_object(${PROJECT_NAME} .bin binary)

if ("${CMAKE_C_COMPILER_ID}" STREQUAL "GNU")
    generate_object(${PROJECT_NAME} .hex ihex)
endif()
