#!/usr/bin/env bash
#
# Setup:
# 1. create an automator workflow that runs a bash script
#
#  source "${HOME}/.zprofile" && \
#  kitty --config "${DOTFILE_FOLDER}/launch/kitty.conf" "${DOTFILE_FOLDER}/launch/run.sh"
#
# 2. Settings > Keyboard > Shortcuts > Services > General > Set the service
#
# TODO:
#   - have the commands also be runable from the shell
#     maybe using ./bin would be easier? That would enforce consistency but
#     migth lead up to a lot of noise as well.
#     maybe using a link to ./bin ?
#   - store logs somewhere for easier debugging

set -e

PREVIEW_COMMAND="grep ^#/ <${DOTFILE_FOLDER}/launch/commands/{} | cut -c4- | envsubst"
COMMANDS_PATH="${DOTFILE_FOLDER}/launch/commands"

find "${COMMANDS_PATH}" -type f -exec basename {} \; \
  | fzf \
    --preview="${PREVIEW_COMMAND}" \
    --bind="enter:become(${COMMANDS_PATH}/{})"

