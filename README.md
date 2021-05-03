# TensorFlow Zephyr VexRiscv examples
Copyright (c) 2021 [Antmicro](https://www.antmicro.com)

This repository, developed in collaboration between Antmicro and Google's TF Lite Micro team, is a work in progress but is ultimately meant to contain sources, tests, Google colabs and other material which use TF Lite Micro and Renode to enable easily running TF Lite Micro demos.

### Repo structure

* `.github/workflows` - GH actions files
  * `generate_ipynb_files.yml` - generating `ipynb` files from `py` sources
  * `test_examples.yml` - building and testing examples
* `examples` - scripts and tests for specific TensorFlow Lite examples
  * `hello-world` - hello world demo running in Zephyr on Litex/VexRiscv SoC [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/antmicro/tensorflow-zephyr-vexriscv-examples/blob/master/examples/hello-world/hello_world.ipynb)
  * `magic-wand` - magic wand demo running in Zephyr on Litex/VexRiscv SoC [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/antmicro/tensorflow-zephyr-vexriscv-examples/blob/master/examples/magic-wand/magic_wand.ipynb)

## Prerequisites

Clone the repository and submodules:

```bash
git clone https://github.com/antmicro/tensorflow-zephyr-vexriscv-examples
cd tensorflow-zephyr-vexriscv-examples
```

Export Zephyr configuration:
```bash
export ZEPHYR_TOOLCHAIN_VARIANT=zephyr
export ZEPHYR_SDK_INSTALL_DIR=/opt/zephyr-sdk
```

Install dependecies (tested on Ubuntu 18.04):
```bash
sudo ./install_dependencies.sh
```

Export Tensorflow path:
```bash
export TENSORFLOW_PATH=tensorflow
```

## Building the demos

### Hello World demo

Build the `Hello World` demo with:
```bash
./build.sh hello_world
```

The resulting binaries can be found in the `tensorflow/lite/micro/tools/make/gen/zephyr_vexriscv_x86_64_default/hello_world/build/zephyr` folder.

### Magic Wand demo

Build the `Magic Wand` demo with:
```bash
./build.sh magic_wand
```
The resulting binaries can be found in the `tensorflow/lite/micro/tools/make/gen/zephyr_vexriscv_x86_64_default/magic_wand/build/zephyr` folder.
