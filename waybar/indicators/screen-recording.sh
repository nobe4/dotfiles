#!/usr/bin/env bash

set -e

if pgrep -f "gpu-screen-recorder" >/dev/null; then
  echo '{"text": "", "tooltip": "Stop recording", "class": "active"}'
else
  echo '{"text": ""}'
fi
