#!/usr/bin/env bash

export DOTFILE_FOLDER="${HOME:?}/dev/nobe4/dotfiles"

source "${DOTFILE_FOLDER}/shell/utils.sh"
source "${DOTFILE_FOLDER}/shell/aliases.sh"
source "${DOTFILE_FOLDER}/shell/prompt.sh"
eval "$(direnv hook bash)"
