#!/usr/bin/env bash

set -e

tooltip=$(
	pw-dump -N \
	| jq -r '.[] | select(.info.state == "running") | .info.props | select(."media.class" == "Stream/Output/Audio") | ["\(."application.name"): \(."media.name")"] | join(",")'
)

if [ -z "${tooltip}" ]; then
  echo '{"text": ""}'
else
  echo '{"text": "", "tooltip": "'"${tooltip//$'\n'/\\n}"'", "class": "active"}'
fi
