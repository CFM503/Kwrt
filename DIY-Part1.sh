# 清空其他目标配置
sed -i '/CONFIG_TARGET_/d' .config
# 设置 Amlogic Meson8b 目标
echo 'CONFIG_TARGET_amlogic=y' >> .config
echo 'CONFIG_TARGET_amlogic_meson8b=y' >> .config
echo 'CONFIG_TARGET_MULTI_PROFILE=n' >> .config
# 确保生成 sysupgrade 固件
echo 'CONFIG_TARGET_ROOTFS_SQUASHFS=y' >> .config
