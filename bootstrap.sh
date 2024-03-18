#!/usr/bin/env bash

set -ex

DOTFILES_DIR="${HOME}/dev/nobe4/dotfiles"

mkdir -p "${DOTFILES_DIR}"

git clone --recurse-submodules git@github.com:nobe4/dotfiles.git "${DOTFILES_DIR}"
ln -fs "${DOTFILES_DIR}" "${HOME}/.config/dotfiles"

echo "Now run"
echo "cd ${DOTFILES_DIR}"
echo "./install.sh"
