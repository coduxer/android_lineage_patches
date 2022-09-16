#!/usr/bin/env bash

set -e
# set -x
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "$SCRIPT_DIR/../utils.sh"
cd "$SCRIPT_DIR/../../lineageos/"
apply-patch2 "device/xiaomi/spes" "$SCRIPT_DIR/../device_xiaomi_spes-mindthegapps.patch" "off"
apply-patch2 "device/xiaomi/spes" "$SCRIPT_DIR/../device_xiaomi_spes-microg.patch" "off"
