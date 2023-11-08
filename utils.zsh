#!/usr/bin/env bash

# Check if shell is interactive
case $- in
  *i*) export IS_INTERACTIVE="1";;
  *) export IS_SCRIPT="1";;
esac

function is_interactive {
  if [ -n "$IS_INTERACTIVE" ]; then
    return 0
  fi
  return 1
}

# Which OS is running
unameOut="$(uname -s)"
case "${unameOut}" in
  Linux*) export IS_LINUX="1";;
  Darwin*) export IS_MACOS="1";;
  *) exit 1
esac

function is_macos {
  if [ -n "$IS_MACOS" ]; then
    return 0
  fi
  return 1
}
function is_linux {
  if [ -n "$IS_LINUX" ]; then
    return 0
  fi
  return 1
}

function is_missing {
  if ! type "$1" > /dev/null; then
    return 0
  fi
  return 1
}

function wait_until {
  read -r -s -k "?Press enter when $1..."
}

# link file and backup if needed
link(){
  local src="$1"
  local dst="$2"

  # Backup the existing link
  if [ -f "$dst" ] || [ -d "$dst" ] || [ -L "$dst" ]
  then
    # If the existing destination does not link to the current source, backup it
    if ! [ "$src" = "$(readlink "$dst")" ]
    then
      mv "$dst" "${dst}.backup.$(date +%s)"
    fi
  fi

  # Link the file
  ln -fs "$src" "$dst"
}

# List configuration file
list(){
  find -H "$DOTFILES_ROOT" -type f -name "$1" -not -path '*.yada*'
}
