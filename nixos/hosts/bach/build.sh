#!/usr/bin/env bash

set -e

DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Find the device name of your SD card (not the partition!) in:"
lsblk

read -r -p "Enter the device name of your SD card (e.g. for /dev/sdX: sdX): " dev

if [[ ! -b "/dev/${dev}" ]]; then
    echo "Error: Device /dev/${dev} does not exist or is not a block device!" >&2
    exit 1
fi

sudo -K
sudo -v -p "[sudo] password to authorize 'dd of=/dev/${dev}' " || { echo "Error: sudo required" >&2; exit 1; }

echo "Building SD image with Nix..."
nix-build \
  '<nixpkgs/nixos>' \
  -A config.system.build.sdImage \
  --argstr system aarch64-linux \
  -I nixos-config="$DIR/configuration.nix"

# `sd-image-aarch64` doesn't support setting filenames.
image=$(find "$(pwd)/result/sd-image/" -type f)

echo "Flashing ${image} to /dev/${dev}..."
set -x
sudo dd bs=128k status=progress conv=fsync oflag=sync if="${image}" of="/dev/${dev}"
set +x

notify "Flashing complete" "The SD card has been flashed successfully."
