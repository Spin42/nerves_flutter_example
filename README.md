# NervesFlutterExample

A basic flutter demo using:
- An experimental custom system with flutter running on nerves (https://github.com/Spin42/nerves_system_flutter_rpi4)
- Using experimental nerves_flutterpi launcher so flutter app runs at boot (https://github.com/Spin42/nerves_flutterpi)


## Dependencies
  * Flutterpi tool (https://github.com/ardera/flutterpi_tool)
  * Flutter (https://docs.flutter.dev/get-started/install)

## Getting Started

To setup the firmware:
  * `cd firmware`
  * `export MIX_TARGET=nerves_system_flutter_rpi4`
  * Install dependencies with `mix deps.get`

To make changes to the flutter app:
  * `cd frontend`
  * Launch app on host with `flutter run`

To build:
  * Simply execute `./build.sh`

## Disclaimer

This is very early stage and not ready for production yet.
