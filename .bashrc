#!/usr/bin/env bash

echo "Loading .bashrc"
echo "Use zsh please."

export DOTFILE_FOLDER="${XDG_CONFIG_HOME:-${HOME:?}/.config}/dotfiles"
export PATH="$DOTFILE_FOLDER/functions:$DOTFILE_FOLDER/private_functions:/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
