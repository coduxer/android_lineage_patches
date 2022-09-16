#!/usr/bin/env bash
# set -x 

set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "$SCRIPT_DIR/utils.sh"

cd "$SCRIPT_DIR/../../"
clean-repo "hardware/google/pixel"
apply-patch "hardware/google/pixel" "$SCRIPT_DIR/android_hardware_google_pixel--delete-kernel-headers.patch"
clean-repo "build/make"
apply-patch "build/make" "$SCRIPT_DIR/android_build-release-keys.patch"
clean-repo "frameworks/base"
apply-patch "frameworks/base" "$SCRIPT_DIR/android_frameworks_base-S.patch"
apply-patch "frameworks/base" "$SCRIPT_DIR/android_frameworks_base-safetynetfix.patch"
clean-repo "packages/modules/Permission"
apply-patch "packages/modules/Permission" "$SCRIPT_DIR/packages_modules_Permission-S.patch"
clean-repo "system/core"
apply-patch "system/core" "$SCRIPT_DIR/android_system_core-safetynetfix.patch"




# clean-repo "device/xiaomi/spes"
# apply-patch "device/xiaomi/spes" "$SCRIPT_DIR/device_xiaomi_spes-mindthegapps.patch"



# clean-repo "device/xiaomi/spes"
# apply-patch "device/xiaomi/spes" "$SCRIPT_DIR/mindthegapps.patch"



# patch -p1 < "$SCRIPT_DIR/android_frameworks_base-S.patch"
#patch -p1 < "$SCRIPT_DIR/packages_modules_Permission-S.patch"

#patch -p1 < "$SCRIPT_DIR/Block_key_attestation_for_SafetyNet2.patch"





