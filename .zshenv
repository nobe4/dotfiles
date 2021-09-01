#!/usr/bin/env zsh
# shellcheck shell=bash
# vim: foldmarker={,} foldmethod=marker

# Setup {
export DOTFILE_FOLDER="$HOME/.dot"
source "$DOTFILE_FOLDER/utils.zsh"
# }

# Path Helper {
if [ -n "$IS_MACOS" ]; then
  # Mac OS X uses path_helper and /etc/paths.d to preload PATH, clear it out first
  if [ -x /usr/libexec/path_helper ]; then
    PATH=''
    eval `/usr/libexec/path_helper -s`
  fi
fi
# }

# PATH {
# The export doesn't seem to work, use an alias instead
PATH="/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

PATH="$PATH:$HOME/.local/bin"

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
  ePATH="/Applications/MacVim.app/Contents/bin:$PATH"
}

# Go {
PATH="$PATH:/usr/local/go/bin"

# Same as `which go`
GOBINARY="/usr/local/go/bin/go"

# Cache of $($GOBINARY env GOPATH)
export GOPATH=~/go # Needs to be absolute and without quote
export GOBIN="$GOPATH/bin"

PATH="$PATH:$GOPATH:$GOBIN"
# }

# Shims
PATH="$HOME/.rbenv/shims:${PATH}"
PATH="$HOME/.nodenv/shims:${PATH}"

export PATH
# }
