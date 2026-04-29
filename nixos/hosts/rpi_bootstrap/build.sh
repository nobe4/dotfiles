#!/usr/bin/env bash

set -e

DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

read -r -p "hostname: " hostname

iwctl known-networks list

read -r -p "ssid: " ssid

echo "Find the device name of your SD card (not the partition!) in:"
lsblk

read -r -p "Enter the device name of your SD card (e.g. for /dev/sdX: sdX): " dev

if [[ ! -b "/dev/${dev}" ]]; then
    echo "Error: Device /dev/${dev} does not exist or is not a block device!" >&2
    exit 1
fi

sudo -K
printf "[sudo] password to authorize\n[sudo] - reading the psk for wifi '%s'\n[sudo] - dd of=/dev/%s\n" "${ssid}" "${dev}"
sudo -v -p "[sudo] > " || { echo "Error: sudo required" >&2; exit 1; }

psk=$(sudo grep PreSharedKey "/var/lib/iwd/${ssid}.psk" | cut -d= -f2)

echo "Building SD image with Nix..."
nix-build \
  --argstr hostName "${hostname}" \
  --argstr ssid "${ssid}" \
  --argstr psk "${psk}" \
  "$DIR/configuration.nix"

echo ""

# `sd-image-aarch64` doesn't support setting filenames.
image=$(find "$(pwd)/result/sd-image/" -type f)

ls -lah "${image}"

echo "Flashing to /dev/${dev}..."
set -x +e
sudo dd bs=128k status=progress conv=fsync oflag=sync if="${image}" of="/dev/${dev}"
status=$?
set +x

if [ $status -ne 0 ]; then
	notify --urgency critical "Flashing failed" "The SD card has failed to flash."
	exit 1
fi
notify "Flashing complete" "The SD card has been flashed successfully."

until avahi-resolve -n4 "${hostname}.local" | grep -q .; do
  sleep 2
done

# To verify the key on the rpi, run
# ssh-keyscan localhost | ssh-keygen -lf -
echo "Fetching the ssh key for ${hostname}, to add to agenix"
ssh "root@${hostname}.local" 'cat /etc/ssh/*.pub'
