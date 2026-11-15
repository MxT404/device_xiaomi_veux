# AOSPA Device Tree for Redmi Note 11 Pro+ / Poco X4 Pro (veux)

This is the AOSPA device tree for the Redmi Note 11 Pro+ / Poco X4 Pro (codename: **veux**).

## Device Specifications

| Component | Specification |
|-----------|---------------|
| SoC | Qualcomm SM6375 (Snapdragon 695) |
| CPU | 2x2.2 GHz Kryo 660 Gold (Cortex-A78) & 6x1.7 GHz Kryo 660 Silver (Cortex-A55) |
| GPU | Adreno 619 |
| RAM | 6GB/8GB LPDDR4X |
| Storage | 128GB/256GB UFS 2.2 |
| Display | 6.67", 1080 x 2400 pixels, 120Hz AMOLED |
| Camera | 108 MP + 8 MP + 2 MP |
| Front Camera | 16 MP |
| Battery | 5000 mAh |
| Android | 11 (upgradable to Android 13) |

## Build Instructions

1. Initialize the AOSPA source:
   ```bash
   repo init -u https://github.com/AOSPA/manifest -b uvite
   repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags
   ```

2. Clone this device tree:
   ```bash
   git clone https://github.com/MxT404/device_xiaomi_veux.git -b aospa-veux device/xiaomi/veux
   ```

3. Clone required dependencies:
   ```bash
   # Vendor blobs
   git clone https://github.com/acerhizmq/vendor_xiaomi_veux.git -b 17 vendor/xiaomi/veux
   
   # Kernel (Snapdragon 695 / SM6375)
   git clone https://github.com/acerhizmq/kernel_xiaomi_veux.git -b 17 kernel/xiaomi/veux --depth=1
   
   # Hardware xiaomi
   git clone https://github.com/LineageOS/android_hardware_xiaomi.git hardware/xiaomi
   
   # Dolby
   git clone https://github.com/acerhizmq/hardware_dolby.git hardware/dolby
   
   # Bluetooth
   git clone https://github.com/acerhizmq/hardware_qcom_bt.git -b lineage-23.2-caf hardware/qcom-caf/bt
   ```

4. Setup the device:
   ```bash
   . build/envsetup.sh
   lunch aospa_veux-userdebug
   ```

5. Build:
   ```bash
   mka bacon
   ```

## Credits

- [AOSPA](https://github.com/AOSPA) - ROM
- [LineageOS](https://github.com/LineageOS) - Base device tree reference
- [MxT404](https://github.com/MxT404) - Original device tree