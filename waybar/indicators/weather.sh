#!/usr/bin/env bash

set -e

cache="$HOME/.local/state/waybar/weather_cache"

if [ ! -f "${cache}" ] || ! find "${cache}" -mmin 60; then
	mkdir -p "$(dirname "$cache")"
	touch "${cache}"

	text=$(curl -s wttr.in/berlin?format=%f%20%c)
	tooltip=$(curl -s wttr.in/berlin?format=v2d)

	if [ -n "${text}" ] && [ -n "${tooltip}" ]; then
		echo "${text}" > "${cache}"
		echo "${tooltip}" >> "${cache}"
	fi
fi

if [ "$*" == "--full" ]; then
	tail -n +2 "${cache}"
	exit 0
fi

head -n1 "${cache}"
