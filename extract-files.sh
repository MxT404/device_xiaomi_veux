#!/bin/bash
# SPDX-License-Identifier: Apache-2.0

set -e

DEVICE=veux
VENDOR=xiaomi

# Extract proprietary files from the device
if [ -z "$ANDROID_ROOT" ]; then
    ANDROID_ROOT=$PWD/../../..
fi

# Extract files using the stock firmware
if [ -d "$ANDROID_ROOT/vendor/xiaomi/$DEVICE" ]; then
    echo "Extracting proprietary files for $DEVICE..."
    ./setup-makefiles.sh $@
else
    echo "Vendor blobs not found. Please clone vendor/xiaomi/$DEVICE first."
    exit 1
fi