// SPDX-License-Identifier: Apache-2.0

#include <android-base/properties.h>
#include <libinit_vendor.h>

#include <cstdlib>

using android::base::GetProperty;
using android::base::SetProperty;
using android::init::vendor::LoadVendorProps;

void vendor_load_properties() {
    std::string device = GetProperty("ro.product.device", "");

    if (device.find("veux") != std::string::npos) {
        LoadVendorProps("veux");
    }

    SetProperty("ro.vendor.device.name", device);
}