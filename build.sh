# /bin/sh!

set -e

export MIX_TARGET=nerves_system_flutter_rpi4
cd frontend
flutterpi_tool build --arch=arm64 --release
cd ..
cp -rf frontend/build/flutter_assets firmware/rootfs_overlay/var/
cd firmware
mix firmware

