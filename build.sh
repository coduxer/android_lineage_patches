#!/usr/bin/env bash

set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR/../lineageos/"

source build/envsetup.sh
breakfast spes
mka target-files-package otatools

croot
sign_target_files_apks -o -d ~/.android-certs \
    $OUT/obj/PACKAGING/target_files_intermediates/*-target_files-*.zip \
    signed-target_files.zip

ZIP_NAME="lineage-19.1-`date -u +%Y%m%d`-UNOFFICIAL-spes.zip"
ota_from_target_files -k ~/.android-certs/releasekey \
    --block --backup=true \
    signed-target_files.zip \
    $ZIP_NAME
echo "finished successfuly"
