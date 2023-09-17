/*******************************************************************************
 *   SIDFLC (Smartphone Interfaced Device For Launching Coins)
 *   Copyright (C) 2021-present Andrew Green
 *
 *   This program is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program.  If not, see <https://www.gnu.org/licenses/>.
 *
 *******************************************************************************/

/* Linker script to configure memory regions. */

SEARCH_DIR(.)
GROUP(-lgcc -lc -lnosys)

/* 
 * SD  = Softdevice
 * 1kB = 1024 bytes
 * 
 * SoC: nRF52832-CIAA
 * ---------------------------------
 * TOTAL_FLASH_SIZE = 512kB (0x80000)
 * TOTAL_RAM_SIZE = 64kB (0x10000)
 * 
 * Flash Layout:
 * bootloader_settings_page   0x0007F000 (4kb)
 * mbr_params_page            0x0007E000 (4kb)
 
 * booloader                 (mbr_params_page (0x0007E000) - Size of bootloader (0xE000)) = 0x70000
 * 
 * FLASH layout when bootloader has a size of (0xC000): 

 * 0x7F000 - 0x80000  (4   kB) Bootloader settings
 * 0x7E000 - 0x7F000  (4   kB) MBR parameter storage
 * 0x68000 - 0x7E000  (--  kB) Bootloader area (Bigger for debug data)
 * 0x19000 - 0x68000  (--- kB) Application area
 * 0x01000 - 0x19000  (96  kB) SoftDevice
 * 0x00000 - 0x01000  (4   kB) Master Boot Record (MBR)
 *
 */

MEMORY
{
  FLASH (rx) : ORIGIN = 0x68000, LENGTH = 0x16000
  RAM (rwx) : ORIGIN = 0x20001000, LENGTH = 0xF000  /* The debugger will tell how much to use if this is wrong */
  bootloader_settings_page (r) : ORIGIN = 0x0007F000, LENGTH = 0x1000
  mbr_params_page (r) : ORIGIN = 0x0007E000, LENGTH = 0x1000
  uicr_mbr_params_page (r) : ORIGIN = 0x10001018, LENGTH = 0x4
  uicr_bootloader_start_address (r) : ORIGIN = 0x10001014, LENGTH = 0x4
}

SECTIONS
{
  . = ALIGN(4);
  .uicr_bootloader_start_address :
  {
    PROVIDE(__start_uicr_bootloader_start_address = .);
    KEEP(*(SORT(.uicr_bootloader_start_address*)))
    PROVIDE(__stop_uicr_bootloader_start_address = .);
  } > uicr_bootloader_start_address
  . = ALIGN(4);
  .bootloader_settings_page(NOLOAD) :
  {
    PROVIDE(__start_bootloader_settings_page = .);
    KEEP(*(SORT(.bootloader_settings_page*)))
    PROVIDE(__stop_bootloader_settings_page = .);
  } > bootloader_settings_page
  . = ALIGN(4);
  .uicr_mbr_params_page :
  {
    PROVIDE(__start_uicr_mbr_params_page = .);
    KEEP(*(SORT(.uicr_mbr_params_page*)))
    PROVIDE(__stop_uicr_mbr_params_page = .);
  } > uicr_mbr_params_page
  . = ALIGN(4);
  .mbr_params_page(NOLOAD) :
  {
    PROVIDE(__start_mbr_params_page = .);
    KEEP(*(SORT(.mbr_params_page*)))
    PROVIDE(__stop_mbr_params_page = .);
  } > mbr_params_page
}

SECTIONS
{
  . = ALIGN(4);
  .mem_section_dummy_ram :
  {
  }
  .log_dynamic_data :
  {
    PROVIDE(__start_log_dynamic_data = .);
    KEEP(*(SORT(.log_dynamic_data*)))
    PROVIDE(__stop_log_dynamic_data = .);
  } > RAM
  .log_filter_data :
  {
    PROVIDE(__start_log_filter_data = .);
    KEEP(*(SORT(.log_filter_data*)))
    PROVIDE(__stop_log_filter_data = .);
  } > RAM
  .fs_data :
  {
    PROVIDE(__start_fs_data = .);
    KEEP(*(.fs_data))
    PROVIDE(__stop_fs_data = .);
  } > RAM

} INSERT AFTER .data;

SECTIONS
{
  .mem_section_dummy_rom :
  {
  }
  .crypto_data :
  {
    PROVIDE(__start_crypto_data = .);
    KEEP(*(SORT(.crypto_data*)))
    PROVIDE(__stop_crypto_data = .);
  } > FLASH
    .nrf_queue :
  {
    PROVIDE(__start_nrf_queue = .);
    KEEP(*(.nrf_queue))
    PROVIDE(__stop_nrf_queue = .);
  } > FLASH
  .dfu_trans :
  {
    PROVIDE(__start_dfu_trans = .);
    KEEP(*(SORT(.dfu_trans*)))
    PROVIDE(__stop_dfu_trans = .);
  } > FLASH
    .svc_data :
  {
    PROVIDE(__start_svc_data = .);
    KEEP(*(.svc_data))
    PROVIDE(__stop_svc_data = .);
  } > FLASH
  .log_const_data :
  {
    PROVIDE(__start_log_const_data = .);
    KEEP(*(SORT(.log_const_data*)))
    PROVIDE(__stop_log_const_data = .);
  } > FLASH
    .nrf_balloc :
  {
    PROVIDE(__start_nrf_balloc = .);
    KEEP(*(.nrf_balloc))
    PROVIDE(__stop_nrf_balloc = .);
  } > FLASH
  .sdh_ble_observers :
  {
    PROVIDE(__start_sdh_ble_observers = .);
    KEEP(*(SORT(.sdh_ble_observers*)))
    PROVIDE(__stop_sdh_ble_observers = .);
  } > FLASH
  .log_backends :
  {
    PROVIDE(__start_log_backends = .);
    KEEP(*(SORT(.log_backends*)))
    PROVIDE(__stop_log_backends = .);
  } > FLASH
  .sdh_req_observers :
  {
    PROVIDE(__start_sdh_req_observers = .);
    KEEP(*(SORT(.sdh_req_observers*)))
    PROVIDE(__stop_sdh_req_observers = .);
  } > FLASH
  .sdh_state_observers :
  {
    PROVIDE(__start_sdh_state_observers = .);
    KEEP(*(SORT(.sdh_state_observers*)))
    PROVIDE(__stop_sdh_state_observers = .);
  } > FLASH
  .sdh_stack_observers :
  {
    PROVIDE(__start_sdh_stack_observers = .);
    KEEP(*(SORT(.sdh_stack_observers*)))
    PROVIDE(__stop_sdh_stack_observers = .);
  } > FLASH
  .sdh_soc_observers :
  {
    PROVIDE(__start_sdh_soc_observers = .);
    KEEP(*(SORT(.sdh_soc_observers*)))
    PROVIDE(__stop_sdh_soc_observers = .);
  } > FLASH

} INSERT AFTER .text


INCLUDE "nrf_common.ld"
