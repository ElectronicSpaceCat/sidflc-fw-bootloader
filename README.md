# Bootloader

The bootloader for the device is a separate application that sits in its own secition of flash memory. Its job is to manage firmware updates to the device. This one in particular uses the nRF softdevice bluetooth stack to allow firmware updates wirelessly, either through nRF Connect BLE or a mobile application.

I modified the bootloader to handle both dfu unboded and bonded scenarios. The bonded lets the bootloader auto connect to the device if the firmware had previously created and stored bonding information. The unbonded requires the bootloader to be independently connected. The unbonded scenario is only used as a backup if the firmware encountered a serious error and could not run.

The difference between the two linkers in this project (Debug/Prod) is that Debug is compiled without optimization for better debugging.

#### For project structure and required dependencies refer to:
* https://github.com/ElectronicSpaceCat/sidflc-fw-app
