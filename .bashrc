#!/usr/bin/env bash

export DOTFILE_FOLDER="${HOME:?}/dev/nobe4/dotfiles"

# export PATH="$DOTFILE_FOLDER/functions:$DOTFILE_FOLDER/private_functions:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

source "${DOTFILE_FOLDER}/utils/setup_prompt.sh"
