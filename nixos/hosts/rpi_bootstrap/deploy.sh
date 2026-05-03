#!/usr/bin/env bash

set -e

ROOT=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && cd ../.. && pwd )

hostname="${1:-}"
if [[ -z "$hostname" ]]; then
  read -r -p "hostname: " hostname
fi

config="$ROOT/hosts/${hostname}/configuration.nix"

if [[ ! -f "$config" ]]; then
	  echo "Error: $config does not exist" >&2
	  exit 1
fi

target="root@${hostname}.local"

echo "Building NixOS for ${hostname} (aarch64-linux)..."
nix-build '<nixpkgs/nixos>' \
	-A system \
	-I "nixos-config=${config}" \
	--argstr system aarch64-linux \
	--option sandbox false \
	--option filter-syscalls false

echo ""
echo "Copying closure to ${target}..."
nix-copy-closure --to "${target}" ./result

echo ""
echo "Switching configuration..."
# shellcheck disable=SC2029
ssh "${target}" \
	"nix-env -p /nix/var/nix/profiles/system --set $(readlink ./result) && \
	 $(readlink ./result)/bin/switch-to-configuration switch"

sleep 5

echo ""
echo "Verifying wifi..."
# shellcheck disable=SC2029
ssh "${target}" "iw wlan0 link" || echo "Warning: wifi check failed"

echo ""
read -r -p "Reboot ${hostname}? [y/N] " reboot
if [[ "$reboot" =~ ^[Yy]$ ]]; then
	# shellcheck disable=SC2029
	ssh "${target}" reboot || true
	sleep 2

	echo "Waiting for ${hostname} to come back..."
	until avahi-resolve -n4 "${hostname}.local" | grep -q .; do
		sleep 2
	done

	echo "${hostname} is back."
fi

notify "Deploy complete" "${hostname} has been deployed."
