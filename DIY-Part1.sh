#!/bin/bash
# 清空其他目标配置
sed -i '/CONFIG_TARGET_/d' .config
# 设置 Amlogic Meson8b 目标
echo 'CONFIG_TARGET_amlogic=y' >> .config
echo 'CONFIG_TARGET_amlogic_meson8b=y' >> .config
echo 'CONFIG_TARGET_MULTI_PROFILE=n' >> .config
# 确保生成 sysupgrade 固件
echo 'CONFIG_TARGET_ROOTFS_SQUASHFS=y' >> .config
# 可选：添加常用插件（根据需要调整）
echo 'CONFIG_PACKAGE_luci=y' >> .config
echo 'CONFIG_PACKAGE_luci-ssl=y' >> .config
# echo 'CONFIG_PACKAGE_luci-app-ssr-plus=y' >> .config  # 示例：SSR Plus
# echo '# CONFIG_PACKAGE_luci-app-adblock is not set' >> .config  # 示例：移除 Adblock
