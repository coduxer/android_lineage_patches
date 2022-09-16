#!/usr/bin/env bash
set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "$SCRIPT_DIR/utils.sh"

# mind_the_gapps_patch=""
mind_the_gapps_patch="$SCRIPT_DIR/device_xiaomi_spes-mindthegapps.patch"
microg_patch="$SCRIPT_DIR/device_xiaomi_spes-microg.patch"

set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR/../lineageos/" > "/dev/null" 2>&1

echo "MindGapps: `patch-status "device/xiaomi/spes" "$mind_the_gapps_patch"`"
echo "MicroG: `patch-status "device/xiaomi/spes" "$microg_patch"`"