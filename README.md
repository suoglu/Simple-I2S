# I²S

## Contents of Readme

1. About
2. Modules
3. Interface Description
4. I²S Bus (Brief information)
5. Simulation
6. Test
7. Status Information

[![Repo on GitLab](https://img.shields.io/badge/repo-GitLab-6C488A.svg)](https://gitlab.com/suoglu/i2s)
[![Repo on GitHub](https://img.shields.io/badge/repo-GitHub-3D76C2.svg)](LINK)

---

## About

I²S master module to send two channel audio data.

## Modules

**`i2sMaster`:**

Master module for I²S communication. Transmits two channel data, named left and right. When `LRCLK` set, right channel data is transmitted. Data size can be edited via `DATASIZE` parameter. This module requires an external clock to operate. External clock frequency should be equal to *2 \* `DATASIZE` \* bitRate*. Where bitRate is the desired bitrate. This module does not require a system clock, everthing happens synchronous to `BCLK`.

**`bitClkGen`:**

Custom clock generator to generate `BCLK`. Output clock period controlled via parameters. `PERIOD` should be desired output clockperiod in ns and `CLKPERIOD` should be input clock period in ns.

## Interface Description

**`i2sMaster`:**

|   Port   | Type | Width |  Description |
| :------: | :----: | :----: |  ------  |
| `rst` | I | 1 | System Reset |
| `BCLK_o` | O | 1 | Bit / Serial clock Output |
| `LRCLK` | O | 1 | Left-Right Clock / Word Select |
| `SDATA` | O | 1 | Serial Data |
| `BCLK_i` | I | 1 | Bit / Serial clock Input |
| `clk` | I | `DATASIZE` | rightAudio |
| `rst` | I | `DATASIZE` | leftAudio |
| `enable` | I | 1 | Enable module |
| `RightNLeft` | I | 1 | `LRCLK` without shift |

I: Input  O: Output

**`bitClkGen`:**

|   Port   | Type | Width |  Description |
| :------: | :----: | :----: |  ------  |
| `clk` | I | 1 | Input Clock |
| `rst` | I | 1 | System Reset |
| `BCLK` | O | 1 | Output Clock |

I: Input  O: Output

## I²S Bus (Brief information)

From [Wikipedia](https://en.wikipedia.org/wiki/I%C2%B2S):

I²S (Inter-IC Sound) is a serial bus interface standard used for connecting digital audio devices together. I²S is unrelated to the bidirectional I²C bus.

The bus consists of at least three signals:

- Bit clock line: BCLK, or SCK (serial clock)
- Left-right (Word) clock: LRCLK, or WS (word select)
- Data line: SDATA

## Simulation

Master module simulated with [sim.v](Simulation/sim.v). One channel set to *0xFFF* other to *0x000*.

## Test

Master module tested with [i2s_test.v](Test/i2s_test.v). Module tested with `DATASIZE` set to 16 bits. Right channel data is captured from right half of the switches and left channel data is captured from left half of the switches. Data from switches are concatenated to get 16 bits from 8 bits. Upper button is used to choose clock states, shown by left most led. In internal clock state, `bitClkGen` module is used to generate 44.64kHz clock, In external clock state, `BCLK_i` is connected to JB7 pin. From JB7 pin, frequencies between 100kHz and 10MHz applied. I²S signal connected to JB1, JB3 and JB4 pins, `RightNLeft` signal connected to JB2 pin. JB header signals are observed using [Digilent Digital Discovery](https://reference.digilentinc.com/reference/instrumentation/digital-discovery/start). Waveform example can be found in the wiki section.

## Status Information

**Last Simulation:** 23 January 2021, with [Icarus Verilog](http://iverilog.icarus.com).

**Last Test:** 23 January 2021, on [Digilent Basys 3](https://reference.digilentinc.com/reference/programmable-logic/basys-3/reference-manual).
