cd $TENSORFLOW_PATH && make -f tensorflow/lite/micro/tools/make/Makefile TARGET=zephyr_vexriscv $1_bin
mkdir -p binaries/$1 && cp $TENSORFLOW_PATH/tensorflow/lite/micro/tools/make/gen/zephyr_vexriscv_x86_64_default/$1/build/zephyr/zephyr.elf binaries/$1/$1_zephyr.elf