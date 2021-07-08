#!/bin/bash

BUMP_ZEPHYR_SHA=$(cat $(dirname $(dirname $(dirname $(realpath ${BASH_SOURCE[0]}))))/zephyr.sha)
BUMP_ZEPHYR_URL="https://github.com/zephyrproject-rtos/zephyr/archive/${BUMP_ZEPHYR_SHA}.zip"
BUMP_ZEPHYR_TF_URL="ZEPHYR_URL := \"${BUMP_ZEPHYR_URL}\""

wget ${BUMP_ZEPHYR_URL} &> /dev/null
BUMP_ZEPHYR_MD5=$(md5sum ${BUMP_ZEPHYR_SHA}.zip)
rm ${BUMP_ZEPHYR_SHA}.zip
set -- ${BUMP_ZEPHYR_MD5}
BUMP_ZEPHYR_MD5=$1
BUMP_ZEPHYR_TF_MD5="ZEPHYR_MD5 := \"${BUMP_ZEPHYR_MD5}\""

sed -i "s@^ZEPHYR_URL :=.*@${BUMP_ZEPHYR_TF_URL}@" tflite-micro/tensorflow/lite/micro/tools/make/third_party_downloads.inc
sed -i "s@^ZEPHYR_MD5 :=.*@${BUMP_ZEPHYR_TF_MD5}@" tflite-micro/tensorflow/lite/micro/tools/make/third_party_downloads.inc

ZEPHYR_SDK_RELEASES_URL="https://github.com/zephyrproject-rtos/sdk-ng/releases/download"
ZEPHYR_SDK_VERSION="v0.12.4"
ZEPHYR_SDK_FILENAME="zephyr-sdk-0.12.4-x86_64-linux-setup.run"

sed -i "s@^wget ${ZEPHYR_SDK_RELEASES_URL}.*@wget ${ZEPHYR_SDK_RELEASES_URL}/${ZEPHYR_SDK_VERSION}/${ZEPHYR_SDK_FILENAME}@" install_dependencies.sh
sed -i "s@^chmod +x.*@chmod +x ${ZEPHYR_SDK_FILENAME}@" install_dependencies.sh
sed -i "s@^\./.*@./${ZEPHYR_SDK_FILENAME} -- -y -d \$ZEPHYR_SDK_INSTALL_DIR@" install_dependencies.sh
