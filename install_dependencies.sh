sudo apt update && sudo apt install -y cmake ninja-build gperf ccache dfu-util device-tree-compiler wget python python3-pip python3-setuptools python3-tk python3-wheel xz-utils file make gcc gcc-multilib locales tar curl unzip xxd
pip3 install --upgrade --user cmake virtualenv PyYAML pyelftools
wget https://github.com/zephyrproject-rtos/sdk-ng/releases/download/v0.11.2/zephyr-sdk-0.11.2-setup.run
chmod +x zephyr-sdk-0.11.2-setup.run
./zephyr-sdk-0.11.2-setup.run -- -y -d $ZEPHYR_SDK_INSTALL_DIR
wget http://mirror.tensorflow.org/github.com/antmicro/zephyr/archive/55e36b9.zip && unzip 55e36b9.zip
mkdir zephyr && mv zephyr-55e36b93796f09c4ab6de70161318e79025615db/* zephyr
virtualenv -p python3 zephyr/venv-zephyr
. zephyr/venv-zephyr/bin/activate
pip3 install --user -r zephyr/scripts/requirements.txt
deactivate