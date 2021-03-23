# Tensorflow zephyr-vexriscv examples
Copyright (c) 2021 [Antmicro](https://www.antmicro.com)

This repository, developed in collaboration between Antmicro and Google's TF Lite Micro team, is a work in progress but is ultimately meant to contain sources, tests, Google colabs and other material which use TF Lite Micro and Renode to enable easily running TF Lite Micro demos.

### Repo structure

* `.github/workflows` - GH actions files
  * `generate_ipynb_files.yml` - generating `ipynb` files from `py` sources
  * `test_examples.yml` - building and testing examples
* `examples` - scripts and tests for specific TensorFlow Lite examples
  * `hello-world` - hello world demo running in Zephyr on Litex/VexRiscv SoC [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/antmicro/tensorflow-zephyr-vexriscv-examples/blob/master/examples/hello-world/hello_world.ipynb)
  * `magic-wand` - magic wand demo running in Zephyr on Litex/VexRiscv SoC [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/antmicro/tensorflow-zephyr-vexriscv-examples/blob/master/examples/magic-wand/magic_wand.ipynb)