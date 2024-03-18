#!/usr/bin/env bash

set -ex

DOTFILES_SOURCE="${HOME}/dev/nobe4/dotfiles"
CONFIG_DIR="${HOME}/.config"
DOTFILES_DIR="${CONFIG_DIR}/dotfiles"

mkdir -p "${DOTFILES_SOURCE}" "${CONFIG_DIR}"

git clone --recurse-submodules git@github.com:nobe4/dotfiles.git "${DOTFILES_SOURCE}"
ln -fs "${DOTFILES_SOURCE}" "${DOTFILES_DIR}"

echo "Now run"
echo "cd ${DOTFILES_SOURCE}"
echo "./install.sh"
