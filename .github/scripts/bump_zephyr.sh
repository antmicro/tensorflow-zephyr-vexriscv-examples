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

# Finding latest release of the zephyr-sdk. See https://docs.github.com/en/rest/reference/repos#releases for details
RELEASES_JSON=`curl https://api.github.com/repos/zephyrproject-rtos/sdk-ng/releases 2>/dev/null`
SDK_VERSION=`echo "${RELEASES_JSON}" |grep 'tag_name' | head --lines 1 | grep --extended-regexp --only-matching '[0-9]+\.[0-9]+\.[0-9]+'`
if [ -z $SDK_VERSION]; then
    echo Failed to get latest SDK version && exit 1
fi;

ZEPHYR_SDK_RELEASES_URL="https://github.com/zephyrproject-rtos/sdk-ng/releases/download"
ZEPHYR_SDK_FILENAME="zephyr-sdk-${SDK_VERSION}-x86_64-linux-setup.run"

sed -i "s@^wget ${ZEPHYR_SDK_RELEASES_URL}.*@wget ${ZEPHYR_SDK_RELEASES_URL}/v${SDK_VERSION}/${ZEPHYR_SDK_FILENAME}@" install_dependencies.sh
sed -i "s@^chmod +x.*@chmod +x ${ZEPHYR_SDK_FILENAME}@" install_dependencies.sh
sed -i "s@^\./.*@./${ZEPHYR_SDK_FILENAME} -- -y -d \$ZEPHYR_SDK_INSTALL_DIR@" install_dependencies.sh
