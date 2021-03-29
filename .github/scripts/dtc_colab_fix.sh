sudo apt install patchelf -y
sudo patchelf --set-interpreter /lib64/ld-linux-x86-64.so.2 $ZEPHYR_SDK_INSTALL_DIR/sysroots/x86_64-pokysdk-linux/usr/bin/dtc