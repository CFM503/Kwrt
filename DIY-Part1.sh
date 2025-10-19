#!/bin/bash
# Clear existing config
rm -rf .config
# Configure for amlogic/meson8b
cat > .config << EOF
CONFIG_TARGET_amlogic=y
CONFIG_TARGET_amlogic_meson8b=y
CONFIG_TARGET_MULTI_PROFILE=n
CONFIG_TARGET_ROOTFS_SQUASHFS=y
CONFIG_TARGET_IMAGES_ALL=y
CONFIG_PACKAGE_luci=y
CONFIG_PACKAGE_luci-ssl=y
# Optional plugins (add if needed, but keep small for 8MB flash)
# CONFIG_PACKAGE_luci-app-ssr-plus=y
EOF
# Generate default config
make defconfig
