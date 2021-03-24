# %% [markdown]
"""
![Renode](https://antmicro.com/OpenSource/assets/images/projects/renode.png)
"""

# %% [markdown]
"""
## Install requirements
"""

# %%
!pip install -q git+https://github.com/antmicro/pyrenode.git git+https://github.com/antmicro/renode-colab-tools.git
!mkdir -p renode && cd renode && wget https://dl.antmicro.com/projects/renode/builds/renode-latest.linux-portable.tar.gz && tar -xzf renode-latest.linux-portable.tar.gz --strip 1
!pip install -q -r renode/tests/requirements.txt
!git clone --quiet https://github.com/antmicro/tensorflow-zephyr-vexriscv-examples.git

import os
from renode_colab_tools import metrics
os.environ['PATH'] = os.getcwd()+"/renode:"+os.environ['PATH']
# %%
!mkdir -p binaries/magic_wand && cd binaries/magic_wand && wget https://github.com/antmicro/tensorflow-zephyr-vexriscv-examples-binaries/raw/master/magic_wand/magic_wand_zephyr.elf # fetch prebuilt binaries

# %% [markdown]
"""## Run a magic-wand example in Renode"""

# %%
import time
from pyrenode import *
shutdown_renode()
connect_renode() # this sets up a log file, and clears the simulation (just in case)
tell_renode('using sysbus')
tell_renode('mach create')
tell_renode('machine LoadPlatformDescription @tensorflow-zephyr-vexriscv-examples/examples/litex-vexriscv-tflite.repl')
tell_renode('sysbus LoadELF @binaries/magic_wand/magic_wand_zephyr.elf')

tell_renode('uart CreateFileBackend @uart.dump true')
tell_renode('logLevel 3')
tell_renode('machine EnableProfiler "metrics.dump"')
tell_renode('i2c.adxl345 MaxFifoDepth 1')
tell_renode('i2c.adxl345 FeedSample @tensorflow-zephyr-vexriscv-examples/examples/magic-wand/angle.data')
tell_renode('s')
time.sleep(5) #waits for creating uart.dump
!timeout 60 tail -c+2 -f renode/uart.dump | sed '/\* \* \* \* \* \* \* \*/ q'
tell_renode('q')
expect_cli('Renode is quitting')
time.sleep(1) #wait not to kill Renode forcefully
shutdown_renode()

# %% [markdown]
"""## Renode metrics analysis"""

# %%
from renode.tools.metrics_analyzer.metrics_parser import MetricsParser
metrics.init_notebook_mode(connected=False)
parser = MetricsParser('renode/metrics.dump')

# %%
metrics.configure_plotly_browser_state()
metrics.show_executed_instructions(parser)

# %%
metrics.configure_plotly_browser_state()
metrics.show_memory_access(parser)

# %%
metrics.configure_plotly_browser_state()
metrics.show_exceptions(parser)

# %%
metrics.configure_plotly_browser_state()
metrics.show_peripheral_access(parser)