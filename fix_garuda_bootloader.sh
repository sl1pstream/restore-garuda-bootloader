#!/bin/bash

# Fix Garuda Linux bootloader
set -e

echo "=== Garuda Linux Bootloader Fix ==="

# Step 1: List partitions
echo "Step 1: Listing partitions..."
sudo fdisk -l

# Step 2: Create mount directory
echo "Step 2: Creating mount directory..."
sudo mkdir -p /mnt/broken

# Step 3: Find and mount Linux filesystem
echo "Step 3: Finding Linux filesystem partition..."
LINUX_PART=$(sudo fdisk -l | grep "Linux filesystem" | head -1 | awk '{print $1}')
if [ -z "$LINUX_PART" ]; then
    echo "Error: No Linux filesystem partition found"
    exit 1
fi
echo "Found Linux partition: $LINUX_PART"
sudo mount "$LINUX_PART" /mnt/broken

# Step 4: Chroot into broken system
echo "Step 4: Entering chroot..."
sudo garuda-chroot /mnt/broken/@ << 'EOF'

# Step 5: Find EFI system partition
echo "Step 5: Finding EFI system partition..."
EFI_PART=$(parted -l | grep -iE "^Disk|esp" | grep -B1 esp | grep "^/dev" | awk '{print $2}' | sed 's/:$//')
if [ -z "$EFI_PART" ]; then
    echo "Error: No EFI system partition found"
    exit 1
fi
echo "Found EFI partition: $EFI_PART"

# Step 6: Mount EFI partition
echo "Step 6: Mounting EFI partition..."
mount "$EFI_PART" /boot/efi

# Step 7: Reinstall GRUB
echo "Step 7: Reinstalling GRUB..."
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=garuda --recheck

# Step 8: Update GRUB
echo "Step 8: Updating GRUB..."
update-grub

echo "Bootloader fix completed successfully!"
EOF

echo "=== Fix completed. Please reboot to test. ==="