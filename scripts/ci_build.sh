#!/usr/bin/env bash
set -euo pipefail
target="${1:-amlogic}"
subtarget="${2:-meson8b}"
profile="${3:-}"

echo "CI build: TARGET=${target}, SUBTARGET=${subtarget}, PROFILE=${profile}"
echo "PWD: $(pwd)"

# Ensure feeds and basic config prepared
if [ ! -x "./scripts/feeds" ]; then
  echo "No OpenWrt build system detected: make sure you are in the root of Kwrt/OpenWrt repo."
  exit 2
fi

# Clean minimal to avoid conflicts
# (不强制全清理以便利用缓存，但如遇问题可开启下面的行)
# make distclean || true

# Make sure feeds are updated (idempotent)
./scripts/feeds update -a || true
./scripts/feeds install -a || true

# Create a minimal .config if none exists:
if [ ! -f .config ]; then
  echo "No .config found — generating a default config for target"
  # generate default config for the target/subtarget; this will set target and subtarget
  # NOTE: 具体选项可能需要你根据仓库的 targets/ 下的名字做调整
  cat > .config <<EOF
# Auto-generated minimal config for CI
CONFIG_TARGET_$target=y
CONFIG_TARGET_${target}_${subtarget}=y
# Leave profile empty: build system will create all images for the target/subtarget
EOF
fi

# If profile is provided, we will pass it to make image
if [ -n "$profile" ]; then
  echo "Building image for PROFILE=$profile"
  make image PROFILE="$profile" V=s
else
  echo "Building default images for target/subtarget; this may take a while"
  # Build everything for the target/subtarget (images include sysupgrade if supported)
  make -j$(nproc) V=s
fi

echo "Build finished; searching for generated sysupgrade images..."
ls -l bin/targets/${target}/${subtarget} || true

# Exit success
exit 0
