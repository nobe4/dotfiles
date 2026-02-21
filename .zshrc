#!/usr/bin/env zsh
# shellcheck shell=bash

# Colors {
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad
autoload -U colors && colors
# }

source "${DOTFILE_FOLDER}/shell/prompt.sh"

# Functions {
# Load compinit and check the cache only once a day
autoload -Uz compinit && compinit -u
is_macos && {
	if [ "$(find "$HOME/.zcompdump" -mtime +1)" ]; then
		rm -f "$HOME/.zcompdump"
		compinit -i
	else
		compinit -C
	fi
}
is_linux && {
	# compinit -u
	# On nix, this seems to break the FPATH
	# TODO: read about it
	# if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
	# 	rm -f "$HOME/.zcompdump"
	# 	compinit -i
	# else
	# 	compinit -C
	# fi
}
zmodload -i zsh/complist

# shellcheck disable=SC2086 # doesn't find the functions if quoted
autoload -U $DOTFILE_FOLDER/functions/*(:t)
# }

# Completion {
# Enable completion from partial words
# e.g. ~/men<TAB> => ~/Documents
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors
zstyle ':completion:*' menu select
# }

# Key Binding {
zle -N fancy-ctrl-z
bindkey -v   # Use vi bindings
bindkey "^Z" fancy-ctrl-z
bindkey "^R" history-incremental-search-backward
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
# }

export FZF_DEFAULT_COMMAND="rg --files --follow"

# Limit how many files can be used by the current session
ulimit -S -n 10240

# Private {
source "${DOTFILE_FOLDER}/private/.zshrc"
# }
