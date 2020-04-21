macro(create_stm32_hal_target target_name)
    file(GLOB stm32hal_src ${STM_HAL_SDK}/Drivers/STM32F1xx_HAL_Driver/Src/*.c)
    string(REPLACE "stm32f1xx_hal_timebase_tim_template.c" "" stm32hal_src "${stm32hal_src}")
    string(REPLACE "stm32f1xx_hal_timebase_rtc_alarm_template.c" "" stm32hal_src "${stm32hal_src}")

    add_library(${target_name} ${stm32hal_src} ${STM_HAL_SDK}/Drivers/BSP/STM32F1xx_Nucleo/stm32f1xx_nucleo.c)

    target_include_directories(${target_name} 
        PUBLIC 
            ${STM_HAL_SDK}/Drivers/STM32F1xx_HAL_Driver/Inc
            ${STM_HAL_SDK}/Drivers/CMSIS/Device/ST/STM32F1xx/Include 
            ${STM_HAL_SDK}/Drivers/CMSIS/Include 
            ${STM_HAL_SDK}/Drivers/BSP/STM32F1xx_Nucleo
            ${CMAKE_CURRENT_SOURCE_DIR}/Inc
    )

    target_compile_definitions(${target_name} 
        PUBLIC 
            USE_HAL_DRIVER=1
            STM32F103xB=1
            USE_STM32F1xx_NUCLEO=1
    )
endmacro()