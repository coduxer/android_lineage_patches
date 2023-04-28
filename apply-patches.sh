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
apply-patch "frameworks/base" "$SCRIPT_DIR/android_frameworks_base-safetynetfix-new.patch"
clean-repo "packages/modules/Permission"
apply-patch "packages/modules/Permission" "$SCRIPT_DIR/packages_modules_Permission-S.patch"
clean-repo "system/core"
apply-patch "system/core" "$SCRIPT_DIR/android_system_core-safetynetfix.patch"

clean-repo "vendor/lineage"
# apply-patch "vendor/lineage" "$SCRIPT_DIR/android_vendor_lineage-custom-display-interface.patch"
apply-patch "vendor/lineage" "$SCRIPT_DIR/android_vendor_lineage--webviews.patch"
apply-patch "vendor/lineage" "$SCRIPT_DIR/android_vendor_lineage--add-more-build-types.patch"

clean-repo "lineage-sdk"
clean-repo "packages/apps/Settings"
apply-patch "packages/apps/Settings" "$SCRIPT_DIR/features_framework/android_packages_apps_Settings--system_setting_switch_preference.patch"
"$SCRIPT_DIR/features/3_fingers_swipe_screenshot/apply-patch.sh"
"$SCRIPT_DIR/features/cutout_force_full_screen/apply-patch.sh"
"$SCRIPT_DIR/features/ripple_effect_toggle/apply-patch.sh"

if [ -f "vendor/partner_gms/products/gms.mk" ]; then
    clean-repo "vendor/partner_gms"
    apply-patch "vendor/partner_gms" "$SCRIPT_DIR/android_vendor_partner_gms--microg-soong-namespace.patch"
fi

clean-repo "packages/apps/Updater"
"$SCRIPT_DIR/ota/apply-ota-address.sh"
