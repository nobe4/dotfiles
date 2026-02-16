#!/usr/bin/env bash

set -e

pid="$(lsof -Q -t /dev/video*)"
if [ -z "${pid}" ]; then
	echo '{"text": ""}'
else
	title=$(hyprctl clients -j | jq -r '.[] | select(.pid == '"${pid}"') | .initialTitle')
	echo '{"text": "", "tooltip": "'"${title}"'", "class": "active"}'
fi
