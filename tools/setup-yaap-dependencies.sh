#!/bin/bash
# SPDX-License-Identifier: Apache-2.0

set -euo pipefail

top=$(cd "$(dirname "${BASH_SOURCE[0]}")/../../../.." && pwd)
interfaces="$top/hardware/lineage/interfaces"
if [[ ! -f "$interfaces/Android.bp" ]]; then
    echo 'veux: sync hardware/lineage/interfaces before setting up HALs' >&2
    exit 1
fi

install_missing() (
    destination=$1
    upstream=$2
    revision=$3
    shift 3

    missing=()
    for path in "$@"; do
        if [[ ! -d "$destination/$path" ]]; then
            missing+=("$path")
        fi
    done
    if ((${#missing[@]} == 0)); then
        exit 0
    fi

    checkout=$(mktemp -d)
    trap 'rm -rf -- "$checkout"' EXIT
    git -C "$checkout" init -q
    git -C "$checkout" fetch -q --depth=1 "$upstream" "$revision"
    git -C "$checkout" archive FETCH_HEAD "${missing[@]}" | tar -xf - -C "$checkout"
    for path in "${missing[@]}"; do
        mkdir -p "$destination/$(dirname "$path")"
        mv -nT "$checkout/$path" "$destination/$path"
    done
)

install_missing "$interfaces" https://github.com/LineageOS/android_hardware_lineage_interfaces.git \
    4f6225db0d3c8cda1f59641fe0d7e53bd5e6449a touch/aidl health livedisplay ir
install_missing "$top/hardware/xiaomi" https://github.com/AxionAOSP/android_hardware_xiaomi.git \
    1f166e98a4a12df471a581a588903f9bff2ac91f DSPVolumeSynchronizer

apply_patch() {
    local tree="$top/$1" patch="$top/device/xiaomi/veux/patches/$2"
    if ! git -C "$tree" apply --reverse --check "$patch" 2>/dev/null; then
        git -C "$tree" apply "$patch"
    fi
}

apply_patch hardware/xiaomi hardware-xiaomi-euicc.patch
apply_patch hardware/qcom-caf/bt qcom-bt-property-get.patch
apply_patch kernel/xiaomi/veux veux-kernel-build-metadata.patch
