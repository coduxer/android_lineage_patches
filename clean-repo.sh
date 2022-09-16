#!/usr/bin/env bash
set -e
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "$SCRIPT_DIR/utils.sh"

cd "$SCRIPT_DIR/../lineageos/"

clean-repo "hardware/google/pixel"
clean-repo "build/make"
clean-repo "frameworks/base"
clean-repo "packages/modules/Permission"
clean-repo "system/core"
clean-repo "vendor/lineage"
clean-repo "lineage-sdk"
clean-repo "packages/apps/Settings"
