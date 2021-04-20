export ZEPHYR_SDK_INSTALL_DIR?=/opt/zephyr-sdk
export PROJECT_BASE=${CURDIR}
export ZEPHYR_BASE=${PROJECT_BASE}/zephyr
export ZEPHYR_TOOLCHAIN_VARIANT=zephyr
export TOOLCHAIN_BASE=${ZEPHYR_SDK_INSTALL_DIR}/riscv64-zephyr-elf/riscv64-zephyr-elf
export TOOLCHAIN_VERSION=9.2.0

TENSORFLOW_BASE=${PROJECT_BASE}/tensorflow
PROJECT_INCLUDES += ${PROJECT_BASE} ${TENSORFLOW_BASE} ${ZEPHYR_BASE} ${ZEPHYR_BASE}/include ${TOOLCHAIN_BASE}/include/c++/${TOOLCHAIN_VERSION} ${TOOLCHAIN_BASE}/include/c++/${TOOLCHAIN_VERSION}/riscv64-zephyr-elf ${TOOLCHAIN_BASE}/include ${TOOLCHAIN_BASE}/include/c++/${TOOLCHAIN_VERSION}/riscv64-zephyr-elf/rv32i/ilp32
GENDIR := gen

hello_world:
	( \
	  cp examples/hello-world/zephyr_cmake_project.cmake ${TENSORFLOW_BASE}/CMakeLists.txt; \
	  sed -i -E 's#\%\{INCLUDE_DIRS\}\%#$(PROJECT_INCLUDES)#g' ${TENSORFLOW_BASE}/CMakeLists.txt; \
	  cp examples/hello-world/prj.conf ${TENSORFLOW_BASE}; \
	  cmake -B${GENDIR}/hello_world/build -S${TENSORFLOW_BASE} -DBOARD="litex_vexriscv" -DPython_ROOT_DIR=${ZEPHYR_BASE}/venv-zephyr/bin/; \
	  make -C ${GENDIR}/hello_world/build; \
	  mkdir -p artifacts/binaries/hello_world && cp ${GENDIR}/hello_world/build/zephyr/zephyr.elf artifacts/binaries/hello_world; \
	)

magic_wand:
	( \
	  cp examples/magic-wand/zephyr_cmake_project.cmake ${TENSORFLOW_BASE}/CMakeLists.txt; \
	  sed -i -E 's#\%\{INCLUDE_DIRS\}\%#$(PROJECT_INCLUDES)#g' ${TENSORFLOW_BASE}/CMakeLists.txt; \
	  cp examples/magic-wand/prj.conf ${TENSORFLOW_BASE}; \
	  cmake -B${GENDIR}/magic_wand/build -S${TENSORFLOW_BASE} -DBOARD="litex_vexriscv" -DPython_ROOT_DIR=${ZEPHYR_BASE}/venv-zephyr/bin/; \
	  make -C ${GENDIR}/magic_wand/build; \
	  mkdir -p artifacts/binaries/magic_wand && cp ${GENDIR}/magic_wand/build/zephyr/zephyr.elf artifacts/binaries/magic_wand; \
	)

clean:
	rm -rf ${GENDIR} ${TENSORFLOW_BASE}/CMakeLists.txt ${TENSORFLOW_BASE}/prj.conf artifacts/binaries
