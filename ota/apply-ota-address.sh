#!/usr/bin/env bash
set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


ROOT_DIR="$SCRIPT_DIR/../"
source "$ROOT_DIR/utils.sh"


cd "$ROOT_DIR/../../"

if [ -f "$SCRIPT_DIR/ota-address.txt" ]; then
    OTA_ADDRESS=`cat "$SCRIPT_DIR/ota-address.txt"`
fi
if [[ -n "${OTA_ADDRESS}" ]]; then
    TEMP_FILE=`mktemp --suffix ".patch"`
    sed "s#OTA_ADDRESS#$OTA_ADDRESS#" "$SCRIPT_DIR/android_packages_apps_Updater--change-ota-address.patch" > "$TEMP_FILE"
    apply-patch "packages/apps/Updater" "$TEMP_FILE"
fi




