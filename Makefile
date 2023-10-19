PROJECT_NAME     := sidflc-fw-bootloader
TARGETS          := sidflc_fw_bootloader
OUTPUT_DIRECTORY := build

PROJ_DIR := ./
LINKER_DIR := $(PROJ_DIR)/linker
SDK_ROOT := ../$(PROJ_DIR)/nRF5_SDK_17.1.0_ddde560
SOFT_DEVICE := s112
SOFT_DEVICE_VERSION := 7.2.0

$(OUTPUT_DIRECTORY)/$(TARGETS).out: \
  LINKER_SCRIPT  := $(LINKER_DIR)/Prod/secure_bootloader_gcc_nrf52.ld

# Source files common to all targets
SRC_FILES += \
	$(PROJ_DIR)/src/main.c \
	$(PROJ_DIR)/src/nrf_bootloader.c \
	$(PROJ_DIR)/src/nrf_bootloader_dfu_timers.c \
	$(PROJ_DIR)/src/nrf_dfu_ble.c \
	$(PROJ_DIR)/src/nrf_dfu_settings_svci.c \
	$(PROJ_DIR)/src/nrf_dfu_svci_handler.c \
	$(PROJ_DIR)/src/public_key.c \
	$(SDK_ROOT)/components/ble/common/ble_srv_common.c \
	$(SDK_ROOT)/components/boards/boards.c \
	$(SDK_ROOT)/components/libraries/atomic/nrf_atomic.c \
	$(SDK_ROOT)/components/libraries/atomic_fifo/nrf_atfifo.c \
	$(SDK_ROOT)/components/libraries/balloc/nrf_balloc.c \
	$(SDK_ROOT)/components/libraries/bootloader/nrf_bootloader_app_start.c \
	$(SDK_ROOT)/components/libraries/bootloader/nrf_bootloader_app_start_final.c \
	$(SDK_ROOT)/components/libraries/bootloader/nrf_bootloader_fw_activation.c \
	$(SDK_ROOT)/components/libraries/bootloader/nrf_bootloader_info.c \
	$(SDK_ROOT)/components/libraries/bootloader/nrf_bootloader_wdt.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/dfu-cc.pb.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_flash.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_handling_error.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_mbr.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_req_handler.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_settings.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_svci.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_transport.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_utils.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_validation.c \
	$(SDK_ROOT)/components/libraries/bootloader/dfu/nrf_dfu_ver_validation.c \
	$(SDK_ROOT)/components/libraries/crc32/crc32.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/micro_ecc/micro_ecc_backend_ecc.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/micro_ecc/micro_ecc_backend_ecdh.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/micro_ecc/micro_ecc_backend_ecdsa.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/nrf_sw/nrf_sw_backend_hash.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_chacha_poly_aead.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_ecc.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_ecdh.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_ecdsa.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_eddsa.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_hash.c \
	$(SDK_ROOT)/components/libraries/crypto/backend/oberon/oberon_backend_hmac.c \
	$(SDK_ROOT)/components/libraries/crypto/nrf_crypto_ecc.c \
	$(SDK_ROOT)/components/libraries/crypto/nrf_crypto_ecdsa.c \
	$(SDK_ROOT)/components/libraries/crypto/nrf_crypto_hash.c \
	$(SDK_ROOT)/components/libraries/crypto/nrf_crypto_init.c \
	$(SDK_ROOT)/components/libraries/crypto/nrf_crypto_shared.c \
	$(SDK_ROOT)/components/libraries/experimental_section_vars/nrf_section_iter.c \
	$(SDK_ROOT)/components/libraries/fstorage/nrf_fstorage_nvmc.c \
	$(SDK_ROOT)/components/libraries/fstorage/nrf_fstorage_sd.c \
	$(SDK_ROOT)/components/libraries/fstorage/nrf_fstorage.c \
	$(SDK_ROOT)/components/libraries/log/src/nrf_log_backend_flash.c \
	$(SDK_ROOT)/components/libraries/log/src/nrf_log_backend_rtt.c \
	$(SDK_ROOT)/components/libraries/log/src/nrf_log_backend_serial.c \
	$(SDK_ROOT)/components/libraries/log/src/nrf_log_default_backends.c \
	$(SDK_ROOT)/components/libraries/log/src/nrf_log_frontend.c \
	$(SDK_ROOT)/components/libraries/log/src/nrf_log_str_formatter.c \
	$(SDK_ROOT)/components/libraries/mem_manager/mem_manager.c \
	$(SDK_ROOT)/components/libraries/memobj/nrf_memobj.c \
	$(SDK_ROOT)/components/libraries/queue/nrf_queue.c \
	$(SDK_ROOT)/components/libraries/ringbuf/nrf_ringbuf.c \
	$(SDK_ROOT)/components/libraries/scheduler/app_scheduler.c \
	$(SDK_ROOT)/components/libraries/sha256/sha256.c \
	$(SDK_ROOT)/components/libraries/strerror/nrf_strerror.c \
	$(SDK_ROOT)/components/libraries/svc/nrf_svc_handler.c \
	$(SDK_ROOT)/components/libraries/util/app_error_weak.c \
	$(SDK_ROOT)/components/libraries/util/app_util_platform.c \
	$(SDK_ROOT)/components/libraries/util/nrf_assert.c \
	$(SDK_ROOT)/components/softdevice/common/nrf_sdh.c \
	$(SDK_ROOT)/components/softdevice/common/nrf_sdh_ble.c \
	$(SDK_ROOT)/components/softdevice/common/nrf_sdh_soc.c \
	$(SDK_ROOT)/external/fprintf/nrf_fprintf.c \
	$(SDK_ROOT)/external/fprintf/nrf_fprintf_format.c \
	$(SDK_ROOT)/external/nano-pb/pb_common.c \
	$(SDK_ROOT)/external/nano-pb/pb_decode.c \
	$(SDK_ROOT)/external/segger_rtt/SEGGER_RTT.c \
	$(SDK_ROOT)/external/segger_rtt/SEGGER_RTT_Syscalls_GCC.c \
	$(SDK_ROOT)/external/segger_rtt/SEGGER_RTT_printf.c \
	$(SDK_ROOT)/modules/nrfx/hal/nrf_nvmc.c \
	$(SDK_ROOT)/modules/nrfx/mdk/gcc_startup_nrf52.S \
	$(SDK_ROOT)/modules/nrfx/mdk/system_nrf52.c \
	$(SDK_ROOT)/modules/nrfx/soc/nrfx_atomic.c \

# Include folders common to all targets
INC_FOLDERS += \
	src \
	config \
	$(SDK_ROOT)/components/ble/common \
	$(SDK_ROOT)/components/boards \
	$(SDK_ROOT)/components/libraries/atomic \
	$(SDK_ROOT)/components/libraries/atomic_fifo \
	$(SDK_ROOT)/components/libraries/balloc \
	$(SDK_ROOT)/components/libraries/bootloader \
	$(SDK_ROOT)/components/libraries/bootloader/ble_dfu \
	$(SDK_ROOT)/components/libraries/bootloader/dfu \
	$(SDK_ROOT)/components/libraries/crc32 \
	$(SDK_ROOT)/components/libraries/crypto \
	$(SDK_ROOT)/components/libraries/crypto/backend/cc310 \
	$(SDK_ROOT)/components/libraries/crypto/backend/cc310_bl \
	$(SDK_ROOT)/components/libraries/crypto/backend/cifra \
	$(SDK_ROOT)/components/libraries/crypto/backend/mbedtls \
	$(SDK_ROOT)/components/libraries/crypto/backend/micro_ecc \
	$(SDK_ROOT)/components/libraries/crypto/backend/nrf_hw \
	$(SDK_ROOT)/components/libraries/crypto/backend/nrf_sw \
	$(SDK_ROOT)/components/libraries/crypto/backend/oberon \
	$(SDK_ROOT)/components/libraries/crypto/backend/optiga \
	$(SDK_ROOT)/components/libraries/delay \
	$(SDK_ROOT)/components/libraries/experimental_section_vars \
	$(SDK_ROOT)/components/libraries/fstorage \
	$(SDK_ROOT)/components/libraries/log \
	$(SDK_ROOT)/components/libraries/log/src \
	$(SDK_ROOT)/components/libraries/mem_manager \
	$(SDK_ROOT)/components/libraries/memobj \
	$(SDK_ROOT)/components/libraries/queue \
	$(SDK_ROOT)/components/libraries/ringbuf \
	$(SDK_ROOT)/components/libraries/scheduler \
	$(SDK_ROOT)/components/libraries/sha256 \
	$(SDK_ROOT)/components/libraries/stack_info \
	$(SDK_ROOT)/components/libraries/strerror \
	$(SDK_ROOT)/components/libraries/svc \
	$(SDK_ROOT)/components/libraries/util \
	$(SDK_ROOT)/components/softdevice/common \
	$(SDK_ROOT)/components/softdevice/$(SOFT_DEVICE)/headers \
	$(SDK_ROOT)/components/softdevice/$(SOFT_DEVICE)/headers/nrf52 \
	$(SDK_ROOT)/components/toolchain/cmsis/include \
	$(SDK_ROOT)/external/fprintf \
	$(SDK_ROOT)/external/micro-ecc \
	$(SDK_ROOT)/external/nano-pb \
	$(SDK_ROOT)/external/nrf_oberon/include \
	$(SDK_ROOT)/external/segger_rtt \
	$(SDK_ROOT)/integration/nrfx \
	$(SDK_ROOT)/modules/nrfx \
	$(SDK_ROOT)/modules/nrfx/hal \
	$(SDK_ROOT)/modules/nrfx/mdk \

# Include folders common to all targets
LINKER_INC_FOLDERS += $(SDK_ROOT)/external/nrf_oberon/lib/cortex-m4/hard-float \

# Libraries common to all targets
LIB_FILES += -loberon_3.0.8

# Optimization flags
OPT = -Os -g3
# Uncomment the line below to enable link time optimization
#OPT += -flto

# Common user defines
CDEFS += -DBOARD_CUSTOM
CDEFS += -DBT_VERSION_5_0
CDEFS += -DBLE_STACK_SUPPORT_REQD
CDEFS += -DCONFIG_GPIO_AS_PINRESET
CDEFS += -DCONFIG_NFCT_PINS_AS_GPIOS
CDEFS += -DFLOAT_ABI_HARD
CDEFS += -DNRF52
CDEFS += -DNRF52832_XXAA
CDEFS += -DNRF52_PAN_74
CDEFS += -DNRF_DFU_SETTINGS_VERSION=2
CDEFS += -DNRF_DFU_SVCI_ENABLED
CDEFS += -DNRF_SD_BLE_API_VERSION=7
CDEFS += -DS112
CDEFS += -DSOFTDEVICE_PRESENT
CDEFS += -DSVC_INTERFACE_CALL_AS_NORMAL_FUNCTION
CDEFS += -DuECC_ENABLE_VLI_API=0
CDEFS += -DuECC_OPTIMIZATION_LEVEL=3
CDEFS += -DuECC_SQUARE_FUNC=0
CDEFS += -DuECC_SUPPORT_COMPRESSED_POINT=0
CDEFS += -DuECC_VLI_NATIVE_LITTLE_ENDIAN=1
CDEFS += -DNRF_LOG_ENABLED=1
CDEFS += -DNRF_LOG_BACKEND_RTT_ENABLED=1
CDEFS += -DNRF_LOG_BUFSIZE=4096

# Common hardware defines
CHDEFS += -mthumb -mabi=aapcs
CHDEFS += -mcpu=cortex-m4
CHDEFS += -mfloat-abi=hard -mfpu=fpv4-sp-d16

# C flags common to all targets
CFLAGS += $(OPT)
CFLAGS += $(CHDEFS)
CFLAGS += -Wall
# keep every function in a separate section, this allows linker to discard unused ones
CFLAGS += -ffunction-sections -fdata-sections -fno-strict-aliasing
CFLAGS += -fno-builtin -fshort-enums
CFLAGS += $(CDEFS)

# C++ flags common to all targets
CXXFLAGS += $(OPT)

# Assembler flags common to all targets
ASMFLAGS += $(OPT)
ASMFLAGS += $(CHDEFS)
ASMFLAGS += $(CDEFS)

# Linker flags
LDFLAGS += $(OPT)
LDFLAGS += $(CHDEFS)
LDFLAGS += -L$(SDK_ROOT)/modules/nrfx/mdk -T$(LINKER_SCRIPT)
# let linker dump unused sections
LDFLAGS += -Wl,--gc-sections
# use newlib in nano version
LDFLAGS += --specs=nano.specs
LDFLAGS += -L$(LINKER_INC_FOLDERS)

$(TARGETS): CFLAGS += -D__HEAP_SIZE=0
$(TARGETS): CFLAGS += -D__STACK_SIZE=8192
$(TARGETS): ASMFLAGS += -D__HEAP_SIZE=0
$(TARGETS): ASMFLAGS += -D__STACK_SIZE=8192

# Add standard libraries at the very end of the linker input, after all objects
# that may need symbols provided by these libraries.
LIB_FILES += -lc -lnosys -lm

.PHONY: default help

# Default target - first one defined
default: $(TARGETS)

# Print all targets that can be built
help:
	@echo following targets are available:
	@echo		$(TARGETS)
	@echo		flash_softdevice
	@echo		sdk_config - starting external tool for editing sdk_config.h
	@echo		flash      - flashing binary


TEMPLATE_PATH := $(PROJ_DIR)/scripts

include $(TEMPLATE_PATH)/Makefile.common

$(foreach target, $(TARGETS), $(call define_target, $(target)))

.PHONY: flash flash_softdevice erase

# Flash the program
flash: default
	@echo Flashing: $(OUTPUT_DIRECTORY)/$(TARGETS).hex
	nrfjprog -f nrf52 --program $(OUTPUT_DIRECTORY)/$(TARGETS).hex --sectorerase
	nrfjprog -f nrf52 --reset

# Flash softdevice
flash_softdevice:
	@echo Flashing: $(SOFT_DEVICE)_nrf52_$(SOFT_DEVICE_VERSION)_softdevice.hex
	nrfjprog -f nrf52 --program $(SDK_ROOT)/components/softdevice/$(SOFT_DEVICE)/hex/$(SOFT_DEVICE)_nrf52_$(SOFT_DEVICE_VERSION)_softdevice.hex --sectorerase
	nrfjprog -f nrf52 --reset

erase:
	nrfjprog -f nrf52 --eraseall

SDK_CONFIG_FILE := ../config/sdk_config.h
CMSIS_CONFIG_TOOL := $(SDK_ROOT)/external_tools/cmsisconfig/CMSIS_Configuration_Wizard.jar
sdk_config:
	java -jar $(CMSIS_CONFIG_TOOL) $(SDK_CONFIG_FILE)
