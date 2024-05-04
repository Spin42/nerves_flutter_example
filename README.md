# NervesFlutterExample

A basic flutter demo using:
- An experimental custom system with flutter running on nerves (https://github.com/Spin42/nerves_system_flutter_rpi4)
- Using experimental nerves_flutterpi launcher so flutter app runs at boot (https://github.com/Spin42/nerves_flutterpi)

## Getting Started

To use this demo:
  * `export MIX_TARGET=nerves_system_flutter_rpi4`
  * Install dependencies with `mix deps.get`
  * Create firmware with `mix firmware`
  * Burn to an SD card with `mix burn` or upload to existing nerves instance with `mix upload`

## Disclaimer

This is very early stage and not ready for production yet.