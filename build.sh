# /bin/sh!

set -e

cd frontend
flutterpi_tool build --arch=arm64 --release
cd ..
cp -rf frontend/build/flutter_assets firmware/rootfs_overlay/var/
cd firmware
mix firmware

