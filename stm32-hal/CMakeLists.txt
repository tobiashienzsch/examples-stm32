project(stm32-hal)

file(GLOB stm32hal_src ${STM_HAL_SDK}/Drivers/STM32F1xx_HAL_Driver/Src/*.c)
string(REPLACE "stm32f1xx_hal_timebase_tim_template.c" "" stm32hal_src "${stm32hal_src}")
string(REPLACE "stm32f1xx_hal_timebase_rtc_alarm_template.c" "" stm32hal_src "${stm32hal_src}")

add_library(${PROJECT_NAME} 
    ${stm32hal_src} 
    #${STM_HAL_SDK}/Drivers/CMSIS/system_stm32f1xx.c
    #${STM_HAL_SDK}/Drivers/CMSIS/Device/ST/STM32F1xx/Source/Templates/system_stm32f1xx.c
)

add_library(stm32::HAL ALIAS ${PROJECT_NAME})

target_include_directories(${PROJECT_NAME} 
    PUBLIC 
        ${STM_HAL_SDK}/Drivers/STM32F1xx_HAL_Driver/Inc
        ${STM_HAL_SDK}/Drivers/CMSIS/Device/ST/STM32F1xx/Include 
        ${STM_HAL_SDK}/Drivers/CMSIS/Include 
        ${STM_HAL_SDK}/Drivers/BSP/STM32F1xx_Nucleo
        ${CMAKE_SOURCE_DIR}/examples/gpio/Inc
)

target_include_directories(${PROJECT_NAME} 
    PUBLIC 
        USE_HAL_DRIVER=1
        STM32F103xB=1
        USE_STM32F1xx_NUCLEO=1
)
