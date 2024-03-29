*** Settings ***
Suite Setup                   Setup
Suite Teardown                Teardown
Test Setup                    Reset Emulation
Test Teardown                 Test Teardown
Resource                      ${RENODEKEYWORDS}

*** Variables ***
${UART}                       sysbus.uart

*** Keywords ***
Create Machine
    Execute Command          mach create
    Execute Command          machine LoadPlatformDescription @${CURDIR}/../litex-vexriscv-tflite.repl

    Execute Command          sysbus LoadELF @${CURDIR}/../../tflite-micro/tensorflow/lite/micro/tools/make/gen/zephyr_vexriscv_x86_64_default/hello_world/build/zephyr/zephyr.elf

*** Test Cases ***
Should Print Brightness Sequence
    Create Machine
    Create Terminal Tester    ${UART}

    Start Emulation

    Wait For Line On Uart     Booting Zephyr OS
    Wait For Line On Uart     x_value: 1.2566\\d+\\*2\\^-2, y_value: 1.4910\\d+\\*2\\^-2  treatAsRegex=true   timeout=0.1
    Wait For Line On Uart     x_value: 1.1780\\d+\\*2\\^2, y_value: -1.1098\\d+\\*2\\^0   treatAsRegex=true   timeout=0.1
