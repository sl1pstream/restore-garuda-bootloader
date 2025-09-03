# Garuda Linux Bootloader Fix Script

> **⚠️ WARNING:** This script is **UNTESTED** and **AI-generated**. The code being being run is based on commands I have manually run in terminal in the past. That being said, use at your own risk. If you have no idea what you're doing, READ UP ON THE TROUBLESHOOTING STEPS FIRST.

Starting points:
- https://forum.garudalinux.org/t/reinstalling-grub/22047/7
- https://forum.garudalinux.org/t/how-to-chroot-garuda-linux/4004


A bash script to automatically restore the Garuda Linux bootloader if/when a Windows update break it.

*This script has a fairly specific use case. Please read the entire ReadMe first if you intend to run it on your own system.*

## Problem

Windows 11 updates frequently overwrite (corrupt? idfk) the Linux bootloader, preventing Garuda Linux from booting. This script automates the manual repair process to quickly restore GRUB.

## Requirements

- **Garuda Linux only** - This script is specifically designed for Garuda Linux and will not work on other distributions
- Garuda Linux live USB/ISO environment
- UEFI system with EFI System Partition

## Usage

1. Boot from Garuda Linux live USB/ISO
2. Run the script:
   ```bash
   ./fix_garuda_bootloader.sh
   ```
3. Reboot and test

## What It Does

1. Lists all partitions
2. Creates mount directory `/mnt/broken`
3. Automatically finds and mounts the Linux filesystem partition
4. Chroots into the broken Garuda system using `garuda-chroot`
5. Detects the EFI System Partition
6. Mounts the EFI partition to `/boot/efi`
7. Reinstalls GRUB with Garuda-specific settings
8. Updates GRUB configuration

## Important Notes

- **UNTESTED**: This script has not been thoroughly tested in real scenarios
- **AI-generated**: Based on manual commands but this bash script was made by AI
- **Garuda-specific**: Uses `garuda-chroot` and Garuda bootloader ID
- **Single partition assumption**: Assumes one Linux filesystem and one EFI partition
- **No error recovery**: Script will exit on first error (I mean, let's be real... would you really want this thing to keep going after an error and risk breaking more things?)

## Disclaimer

This script is provided as-is with no warranty. The author is not responsible for any damage to your system. Always have backups and recovery media available.

---

*This script was generated using AI assistance based on manual bootloader repair procedures.*
