#!/usr/bin/env bash

set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

ROOT_DIR="$SCRIPT_DIR/../.."
source "$ROOT_DIR/utils.sh"


cd "$ROOT_DIR/../lineageos/"

apply-patch "frameworks/base" "$SCRIPT_DIR/android_frameworks_base--cutout-force-full-screen.patch"
apply-patch "packages/apps/Settings" "$SCRIPT_DIR/android_packages_apps_Settings--cutout-force-full-screen.patch"
