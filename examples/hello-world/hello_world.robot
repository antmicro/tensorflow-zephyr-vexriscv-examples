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

    Execute Command          sysbus LoadELF @${CURDIR}/../../artifacts/binaries/hello_world/zephyr.elf

*** Test Cases ***
Should Print Brightness Sequence
    Create Machine
    Create Terminal Tester    ${UART}

    Start Emulation

    Wait For Line On Uart     Booting Zephyr OS
    Wait For Line On Uart     x_value: 1.2566366*2^-2, y_value: 1.4910772*2^-2
    Wait For Line On Uart     x_value: 1.1780966*2^2, y_value: -1.1098361*2^0