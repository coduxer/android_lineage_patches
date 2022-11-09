#!/usr/bin/env bash

set -e
# set -x
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source "$SCRIPT_DIR/../utils.sh"
cd "$SCRIPT_DIR/../../../"

activate-folder "vendor/gapps/" "off"
activate-folder "vendor/partner_gms/" "off"