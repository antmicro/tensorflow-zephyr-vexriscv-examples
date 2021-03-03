# Tensorflow zephyr-vexriscv examples
Copyright (c) 2021 [Antmicro](https://www.antmicro.com)

This repository, developed in collaboration between Antmicro and Google's TF Lite Micro team, is a work in progress but is ultimately meant to contain sources, tests, Google colabs and other material which use TF Lite Micro and Renode to enable easily running TF Lite Micro demos.

### Repo structure

* `.github/workflows` - GH actions files
  * `test_examples.yml` - building and testing examples
* `examples` - scripts and tests for specific TensorFlow Lite examples
  * `magic-wand` - magic wand demo running in Zephyr on Litex/VexRiscv SoC