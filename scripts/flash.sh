#!/usr/bin/env bash
# Flash the firmware to the STM32F446RE via OpenOCD + ST-Link
set -e
cd "$(dirname "$0")/../firmware"
openocd -f interface/stlink.cfg -f target/stm32f4x.cfg \
  -c "program build/Debug/firmware.elf verify reset exit"
