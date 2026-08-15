#!/usr/bin/env zsh
# shellcheck shell=bash

autoload -U colors && colors

# Functions {
# Load compinit fast from the cached dump on every shell (-C skips the security
# audit). When the dump is stale (>7d) or missing, rebuild it in the background
# so the interactive shell never blocks on the slow compinit rebuild.
autoload -Uz compinit
if [[ -f $HOME/.zcompdump ]]; then
	compinit -C
else
	compinit -i
fi
if [[ -n $HOME/.zcompdump(#qN.mh+168) ]]; then
	{ compinit -i && zcompile "$HOME/.zcompdump" } &!
fi
zmodload -i zsh/complist

# shellcheck disable=SC2086 # doesn't find the functions if quoted
autoload -U $DOTFILE_FOLDER/functions/*(:t)
# }

# TODO: rework the prompt between prompt.sh, prompt_precmd, and dotfiles_prompt.
source "${DOTFILE_FOLDER}/shell/prompt.sh"

# # Add functions/prompt_precmd to the list of precmd_functions
# typeset -a precmd_functions
# precmd_functions+=(prompt_precmd)
#
# # Set tab title on dir change and prompt
# TODO: make sure this is ported
# precmd_functions+=(set_tab_title)
# chpwd_functions+=(set_tab_title)
# preexec_functions+=(set_tab_title)
# # }
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

# Limit how many files can be used by the current session
ulimit -S -n 10240

[[ -f "${DOTFILE_FOLDER}/private/.zshrc" ]] && source "$DOTFILE_FOLDER/private/.zshrc"
