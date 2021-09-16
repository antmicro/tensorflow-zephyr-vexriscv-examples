#!/bin/bash -xeu

BUMP_ZEPHYR_SHA=$(cat ${GITHUB_WORKSPACE}/zephyr.sha)
BUMP_ZEPHYR_URL="https://github.com/zephyrproject-rtos/zephyr/archive/${BUMP_ZEPHYR_SHA}.zip"
BUMP_ZEPHYR_TF_URL="ZEPHYR_URL := \"${BUMP_ZEPHYR_URL}\""

wget ${BUMP_ZEPHYR_URL} &> /dev/null
BUMP_ZEPHYR_MD5=$(md5sum ${BUMP_ZEPHYR_SHA}.zip)
rm ${BUMP_ZEPHYR_SHA}.zip
BUMP_ZEPHYR_MD5=$(echo ${BUMP_ZEPHYR_MD5} | cut -d ' ' -f 1)
BUMP_ZEPHYR_TF_MD5="ZEPHYR_MD5 := \"${BUMP_ZEPHYR_MD5}\""

sed -i "s@^ZEPHYR_URL :=.*@${BUMP_ZEPHYR_TF_URL}@" tflite-micro/tensorflow/lite/micro/tools/make/third_party_downloads.inc
sed -i "s@^ZEPHYR_MD5 :=.*@${BUMP_ZEPHYR_TF_MD5}@" tflite-micro/tensorflow/lite/micro/tools/make/third_party_downloads.inc

# Finding required version of the zephyr-sdk
TOOLCHAIN_VERSION=$(curl https://raw.githubusercontent.com/zephyrproject-rtos/zephyr/${BUMP_ZEPHYR_SHA}/cmake/verify-toolchain.cmake | \
	grep --only-matching --extended 'TOOLCHAIN_ZEPHYR_MINIMUM_REQUIRED_VERSION [0-9]+\.[0-9]+(\.[0-9]+)?' |cut -d ' ' -f 2)
# Extend version to SemVer standard
case "$(echo $TOOLCHAIN_VERSION | tr '.' '\n' | wc -l)" in
    "2")
        SDK_VERSION=$TOOLCHAIN_VERSION.0
        ;;
    "3")
        SDK_VERSION=$TOOLCHAIN_VERSION
        ;;
    *)
        echo "Unrecognized format of SDK version : $TOOLCHAIN_VERSION" && exit 1
esac

ZEPHYR_SDK_RELEASES_URL="https://github.com/zephyrproject-rtos/sdk-ng/releases/download"
ZEPHYR_SDK_FILENAME="zephyr-sdk-${SDK_VERSION}-linux-x86_64-setup.run"

sed -i "s@^wget ${ZEPHYR_SDK_RELEASES_URL}.*@wget ${ZEPHYR_SDK_RELEASES_URL}/v${SDK_VERSION}/${ZEPHYR_SDK_FILENAME}@" install_dependencies.sh
sed -i "s@^chmod +x.*@chmod +x ${ZEPHYR_SDK_FILENAME}@" install_dependencies.sh
sed -i "s@^\./.*@./${ZEPHYR_SDK_FILENAME} -- -y -d \$ZEPHYR_SDK_INSTALL_DIR@" install_dependencies.sh
