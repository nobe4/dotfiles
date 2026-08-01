#!/usr/bin/env bash

set -ex

DOTFILES_REPO="git@github.com:nobe4/dotfiles.git"
DOTFILES_DIR="${HOME}/.config/dotfiles"
DOTFILES_SOURCE="${DOTFILES_DIR}/worktree/main"
CONFIG_DIR="${HOME}/.config"
DOTFILES_DIR="${CONFIG_DIR}/dotfiles"

mkdir -p "${DOTFILES_SOURCE}" "${CONFIG_DIR}"

git clone "${DOTFILES_REPO}" "${DOTFILES_DIR}" --bare --config=remote.origin.fetch='+refs/heads/*:refs/remotes/origin/*'
git -C "${DOTFILES_DIR}" fetch origin
git -C "${DOTFILES_DIR}" worktree add "worktree/main" "main"
git -C "${DOTFILES_SOURCE}" submodule update --recursive --remote

ln -fs "${DOTFILES_SOURCE}" "${DOTFILES_DIR}"

echo "Now run"
echo "cd ${DOTFILES_SOURCE}"
echo "./install.sh"
