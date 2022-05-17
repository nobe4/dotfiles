#!/usr/bin/env zsh
# shellcheck shell=bash

# Setup {
export DOTFILE_FOLDER="$HOME/.dot"
source "$DOTFILE_FOLDER/utils.zsh"
# }

# PATH {
# The export doesn't seem to work, use an alias instead
PATH="$DOTFILE_FOLDER/bin:$HOME/.local/bin:$PATH"

# macos Applications
is_macos && {
  PATH="$PATH:/Applications:$HOME/Applications"
}

# FZF
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi
# }

# Macvim
is_macos && {
  PATH="/Applications/MacVim.app/Contents/bin:$PATH"
}

# Go {
PATH="$PATH:/usr/local/go/bin"

# Same as `which go`
# GOBINARY="/usr/local/go/bin/go"

# Cache of $($GOBINARY env GOPATH)
export GOPATH=~/go # Needs to be absolute and without quote
export GOBIN="$GOPATH/bin"

PATH="$PATH:$GOPATH:$GOBIN"
# }

# Shims
PATH="$HOME/.rbenv/shims:$PATH"
PATH="$HOME/.nodenv/shims:$PATH"
PATH="$HOME/.pyenv/shims:$PATH"

export PATH
# }
