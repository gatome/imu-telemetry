cat > README.md << 'EOF'
# imu-telemetry

> Real-time IMU telemetry: STM32 → Raspberry Pi → MQTT → InfluxDB → Grafana

A production-quality embedded telemetry system streaming orientation data from an
STM32 microcontroller to a live Grafana dashboard, built end-to-end with modern
embedded engineering practices.

**Status:** 🚧 Week 1 — toolchain & foundations

---

## Vision

An MPU6050 IMU sampled at 1 kHz on an STM32, fused into quaternions with a
Madgwick filter, framed in a custom binary protocol over UART, parsed by a
Python gateway on a Raspberry Pi 5, published over MQTT, persisted in InfluxDB,
and visualized live in Grafana — with end-to-end latency under 50 ms.

The full system is built with CMake, version-controlled with conventional Git
workflows, automatically tested and built with GitHub Actions, deployed as
containerized services with Docker Compose, and documented with auto-generated
API docs.

## Architecture
[MPU6050] --I2C 400kHz--> [STM32 Nucleo] --UART 921600--> [Raspberry Pi 5]
1kHz sampling                    Python bridge
Madgwick fusion                       |
binary framing                        v
[Mosquitto MQTT]
|
v
[InfluxDB] -> [Grafana]

(Mermaid version coming in Week 6.)

## Tech Stack

| Layer | Technology |
|-------|------------|
| MCU | STM32 Nucleo |
| Sensor | MPU6050 (I2C) |
| Firmware | C11 + C++17, CMake, arm-none-eabi-gcc |
| Fusion | Madgwick filter |
| Gateway | Python 3.11+ |
| Messaging | MQTT (Mosquitto) |
| Storage | InfluxDB 2.x |
| Dashboard | Grafana |
| CI/CD | GitHub Actions |

## Repository Layout

firmware/   STM32 application (C/C++, CMake)
gateway/    Python service (MQTT bridge)
infra/      Docker Compose stack
docs/       Architecture, protocol spec, ADRs
scripts/    Helper scripts (flash, debug, measure)

## Getting Started

> **Coming in Week 6.** For now, see [docs/dev-environment.md](docs/dev-environment.md)
> (also coming — Week 1 Day 4).

## Roadmap

- [ ] Week 1 — Toolchain & foundations
- [ ] Week 2 — I2C driver, sample loop, binary protocol
- [ ] Week 3 — Sensor fusion (Madgwick)
- [ ] Week 4 — Linux pipeline, MQTT, dashboard
- [ ] Week 5 — CI/CD, static analysis, auto-published docs
- [ ] Week 6 — Performance, polish, demo
- [ ] Week 7 — Buffer
- [ ] Week 8 — Stretch goal
- [ ] Week 9 — Visibility & job search integration

## License

MIT — see [LICENSE](LICENSE).
EOF
