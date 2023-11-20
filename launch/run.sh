#!/usr/bin/env bash

# Setup:
# 1. create an automator workflow that runs a bash script
#
#   source /Users/n/dev/nobe4/dotfiles/.zprofile && \
#   /Applications/kitty.app/Contents/MacOS/kitty \
#     --config "${DOTFILE_FOLDER}/launch/kitty.conf" \
#     "${DOTFILE_FOLDER}/launch/run.sh"
#
# 2. Settings > Keyboard > Shortcuts
#    > Services > General > Set the created service

PREVIEW_COMMAND="grep ^#/ <${DOTFILE_FOLDER}/launch/commands/{} | cut -c4- | envsubst"
COMMANDS_PATH="${DOTFILE_FOLDER}/launch/commands"
BECOME_COMMAND="
${PREVIEW_COMMAND}
printf '> '
read -r input
${COMMANDS_PATH}/{} \$input
"

find "${COMMANDS_PATH}" -type f -exec basename {} \; \
  | fzf \
    --preview="${PREVIEW_COMMAND}" \
    --bind="enter:become(${BECOME_COMMAND})"

