# NervesFlutterExample

A basic flutter demo using:
- An experimental custom system with flutter running on nerves (https://github.com/Spin42/nerves_system_flutter_rpi4)
- Using a basic flutterpi launcher to start the app at boot (https://github.com/Spin42/nerves_flutterpi)

## About
This is an implementation of the first Codelab you can find on the Flutter documentation, with the twist that all state is fetched from a backend app written in Phoenix.
  * Link to the doc: https://docs.flutter.dev/get-started/codelab

## Notice about fonts
The standard fonts are not included in the nerves system image, meaning that you always have to package your fonts in your flutter app and not rely on the presence of any default fonts on the system. Failure to do so will mean no text will be shown in your flutter app.

## Dependencies
  * Flutter (https://docs.flutter.dev/get-started/install)
  * Flutterpi tool (https://pub.dev/packages/flutterpi_tool)

## Getting Started

To setup the firmware locally:
  * `cd firmware`
  * `export MIX_TARGET=nerves_system_flutter_rpi4`
  * Install dependencies with `mix deps.get`

To launch the backend locally:
  * `cd backend`
  * Install dependencies with `mix deps.get`
  * Create database and run migrations with `mix ecto.create` & `mix ecto.migrate`
  * Launch phoenix with `mix phx.server`

To run the flutter app locally:
  * `cd frontend`
  * Launch app on host with `flutter run`

To build:
  * Simply execute `./build.sh`

To burn on sd card:
  * Go to firmware folder after building with `cd firmware`
  * Run `mix burn`
  * Alternatively, run `mix upload`if you already have a nerves device plugged-in

## Disclaimer

This is very early stage. This is just to provide an example on how to get started with Flutter on Nerves with a Raspberry pi4.
