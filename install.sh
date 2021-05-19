#!/usr/bin/env zsh

set -xe

git submodule update --init
sudo chsh -s $(which zsh)
.yada/install
