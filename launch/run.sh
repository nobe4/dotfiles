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

ls | fzf | pbcopy
