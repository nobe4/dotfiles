#!/usr/bin/env zsh

set -xe

git submodule update --init
chsh -s $(which zsh)
.yada/install
