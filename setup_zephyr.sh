#/bin/sh

set -e

ZEPHYR_BASE=zephyr
west init -m https://github.com/zephyrproject-rtos/zephyr.git .
virtualenv -p python3 ${ZEPHYR_BASE}/venv-zephyr
. ${ZEPHYR_BASE}/venv-zephyr/bin/activate
python ${ZEPHYR_BASE}/venv-zephyr/bin/pip install -r ${ZEPHYR_BASE}/scripts/requirements.txt
deactivate