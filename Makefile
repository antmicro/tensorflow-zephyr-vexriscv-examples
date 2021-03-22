export ZEPHYR_SDK_INSTALL_DIR?=/opt/zephyr-sdk
export ZEPHYR_BASE=${CURDIR}/zephyr
export ZEPHYR_TOOLCHAIN_VARIANT=zephyr
export TOOLCHAIN_BASE=${ZEPHYR_SDK_INSTALL_DIR}/riscv64-zephyr-elf/riscv64-zephyr-elf
export TOOLCHAIN_VERSION=9.2.0

TENSORFLOW_BASE=${CURDIR}/tensorflow
PROJECT_INCLUDES += ${CURDIR} ${TENSORFLOW_BASE} ${ZEPHYR_BASE} ${TOOLCHAIN_BASE}/include/c++/${TOOLCHAIN_VERSION} ${TOOLCHAIN_BASE}/include/c++/${TOOLCHAIN_VERSION}/riscv64-zephyr-elf ${TOOLCHAIN_BASE}/include ${TOOLCHAIN_BASE}/include/c++/${TOOLCHAIN_VERSION}/riscv64-zephyr-elf/rv32i/ilp32
GENDIR := gen

magic_wand:
	( \
	  cp examples/magic-wand/zephyr_cmake_project.cmake ${TENSORFLOW_BASE}/CMakeLists.txt; \
	  sed -i -E 's#\%\{INCLUDE_DIRS\}\%#$(PROJECT_INCLUDES)#g' ${TENSORFLOW_BASE}/CMakeLists.txt; \
	  . ${ZEPHYR_BASE}/venv-zephyr/bin/activate; \
	  cmake -B${GENDIR}/magic_wand/build -S${TENSORFLOW_BASE} -DBOARD="litex_vexriscv" -DPython_ROOT_DIR=${ZEPHYR_BASE}/venv-zephyr/bin/; \
	  make -C ${GENDIR}/magic_wand/build; \
	  mkdir -p bin/magic_wand/ && cp ${GENDIR}/magic_wand/build/zephyr/zephyr.elf bin/magic_wand; \
	)

clean:
	rm -rf ${GENDIR} ${TENSORFLOW_BASE}/CMakeLists.txt bin
