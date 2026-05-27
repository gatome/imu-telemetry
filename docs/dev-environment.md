# Development Environment

_Generated 2026-05-25T12:26Z on Debian GNU/Linux 13 (trixie), kernel 6.12.86+deb13-amd64._

Host setup for building, flashing, and debugging the STM32 firmware and running the gateway tooling.

---

## Toolchain Versions

```text
arm-none-eabi-gcc : 14.2.1
arm-none-eabi-g++ : 14.2.1
openocd           : 0.12.0
st-info            : v1.8.0
cmake              : 3.31.6
ninja              : 1.12.1
gdb-multiarch      : GNU gdb (Debian 16.3-1) 16.3
```

---

## Install

```bash
sudo apt install gcc-arm-none-eabi \
  binutils-arm-none-eabi \
  libnewlib-arm-none-eabi \
  libstdc++-arm-none-eabi-newlib \
  openocd \
  stlink-tools \
  cmake \
  ninja-build \
  gdb-multiarch
```

---

## Target Board

- **Board:** NUCLEO-F446RE (Nucleo-64)
- **MCU:** STM32F446RET6 — Cortex-M4F, 512 KB Flash, 128 KB SRAM, hardware FPU
- **Debugger:** on-board ST-Link/V2-1
- **Debug interface:** SWD
- **Verify connection:**

```bash
st-info --probe
```

Expected chip ID:

```text
0x421
```

---

## OpenOCD

Launch OpenOCD manually:

```bash
openocd -f interface/stlink.cfg -f target/stm32f4x.cfg
```

---

## Build System

The firmware project uses:
- CMake
- Ninja
- STM32CubeMX-generated HAL code
- GCC ARM Embedded toolchain

Project root:

```text
firmware/
```

---

## Build Workflow

Configure the project:

```bash
cmake -S firmware -B firmware/build -G Ninja
```

Build firmware:

```bash
cmake --build firmware/build
```

STM32CubeMX-generated Debug build:

```bash
cd firmware
cmake --build build/Debug
```

Expected output artifact:

```text
build/Debug/firmware.elf
```

---

## Flashing Firmware

Manual flashing with OpenOCD:

```bash
openocd -f interface/stlink.cfg -f target/stm32f4x.cfg \
  -c "program build/Debug/firmware.elf verify reset exit"
```

---

## VS Code Setup

Recommended VS Code extensions:

- Cortex-Debug
- CMake Tools
- C/C++
- STM32 VS Code Extension (optional)

Workspace configuration files:

```text
.vscode/launch.json
.vscode/tasks.json
```

---

## Debugging Workflow

Debugging uses:
- Cortex-Debug
- OpenOCD
- arm-none-eabi-gdb
- ST-Link SWD interface

To start debugging:

1. Connect the Nucleo board via USB
2. Open the repository in VS Code
3. Press `F5`
4. VS Code automatically:
   - builds firmware
   - launches OpenOCD
   - flashes firmware
   - attaches GDB
5. Execution halts at `main()`

Supported debugging features:
- Breakpoints
- Step over / step into
- Variable inspection
- Register inspection
- Peripheral register view
- Call stack inspection

---

## GitHub Authentication

- Auth method: SSH with an ed25519 key
- Remote:

```text
git@github.com:gatome/imu-telemetry.git
```

Verify authentication:

```bash
ssh -T git@github.com
```

Expected behavior:
- GitHub greets the user
- shell access is denied (normal)

---

## ST-Link Permissions

If `st-info --probe` cannot detect the board:

```bash
sudo udevadm control --reload-rules
sudo udevadm trigger
```

Then:
1. unplug the board
2. reconnect the board
3. rerun:

```bash
st-info --probe
```

---

## Repository Structure

```text
imu-telemetry/
├── firmware/        # STM32 firmware
├── gateway/         # Raspberry Pi / Python gateway
├── docs/            # Documentation
├── scripts/         # Helper scripts
├── .vscode/         # VS Code debug/build config
└── infra/           # Docker Compose infrastructure
```
