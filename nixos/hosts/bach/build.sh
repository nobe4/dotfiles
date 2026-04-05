#!/usr/bin/env bash

DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

nix-build \
  '<nixpkgs/nixos>' \
  -A config.system.build.sdImage \
  --argstr system aarch64-linux \
  -I nixos-config="$DIR/configuration.nix"

# `sd-image-aarch64` doesn't support setting filenames.
printf "=> "
find "$(pwd)/result/sd-image/" -type f

echo "Find the device name of your SD card (not the partition!) in:"
lsblk

echo "Run the following command to write the image to your SD card:"
echo "sudo dd if=./result/sd-image/<NAME>.img of=/dev/<DEVTOCHANGE> bs=4M status=progress conv=fsync"
