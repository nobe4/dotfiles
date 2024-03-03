#!/usr/bin/env zsh
# shellcheck shell=bash
# vim: foldmarker={,} foldmethod=marker
# This file contains all the configuration necessary for running a zsh shell.

# Setup {
export DOTFILE_FOLDER="${XDG_CONFIG_HOME:-${HOME:?}/.config}/dotfiles"
source "$DOTFILE_FOLDER/utils.zsh"
is_macos && { BREW_PREFIX="/usr/local/" }
is_linux && { BREW_PREFIX="/home/linuxbrew/.linuxbrew" }
# }

# zshoptions {
setopt ALWAYS_TO_END
setopt INTERACTIVE_COMMENTS
setopt APPEND_HISTORY
setopt AUTO_CD
setopt AUTO_LIST
setopt AUTO_MENU
setopt AUTO_PUSHD
setopt COMPLETE_IN_WORD
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt NO_BEEP
setopt PROMPT_SUBST
setopt PUSHD_IGNORE_DUPS
# }

# Lang {
export LANG="en_US.UTF-8"
export LC_ALL="$LANG"
export LC_CTYPE="$LANG"
# }

# Colors {
is_macos && {
  export TERM=xterm-kitty
}
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad
autoload -U colors && colors
# }

# Functions {
# Load compinit and check the cache only once a day
autoload -Uz compinit
is_macos && {
	if [ "$(find "$HOME/.zcompdump" -mtime +1)" ]; then
		rm -f "$HOME/.zcompdump"
		compinit -i
	else
		compinit -C
	fi
}
is_linux && {
	if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
		rm -f "$HOME/.zcompdump"
		compinit -i
	else
		compinit -C
	fi
}
zmodload -i zsh/complist

# shellcheck disable=SC2086 # doesn't find the functions if quoted
autoload -U $DOTFILE_FOLDER/functions/*(:t)
# }
# Prompt {
# Default prompt is just current dir
# shellcheck disable=SC2154 # colors are loaded somewhere else
PROMPT="%{${fg[green]}%}%c%{${reset_color}%} "

# Add functions/prompt_precmd to the list of precmd_functions
typeset -a precmd_functions
precmd_functions+=(prompt_precmd)
# }
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

# Tmux {
# Start tmux with unicode support (prevent trailing witespace for the prompt)
alias tmux='tmux -u'
alias ta='tmux attach -t'
alias ts='tmux new-session -s'
alias tw='tmux switch -t'
# }

# Neovim {
alias vi="nvim"
alias vim="nvim"
alias vst='nvim +Git now' # Run Gstatus at vim startup
alias vih='nvim +help\ ' # Jump to vim help
alias vin='nvim -Nu NONE' # Vim without config
alias vit='nvim +tj\ ' # Jump to tag
# }

# Git {
alias ga='git add'
alias gb='git branch'
alias gbm='git branch -M'
alias gc='git commit'
alias gl='git pull'
alias glo='git lg'
alias grhh='git reset --hard HEAD'
alias gs='git switch'
alias gpf='git push --force-with-lease'
alias gcb='echo "stop using git checkout: use git switch for that (alias is gsc)"'
alias gco='echo "stop using git checkout: use git switch or git reset for that"'
alias gsc='git switch -c'
alias gsm='git switch "$(git main)"'
alias gss='git status'
alias gs-='git status -'
alias gst='git stash'
# }

# Docker {
alias dk="docker"
alias dkclean="docker system prune --force --all --volumes"
alias bbox="docker run -it --rm busybox"
alias dkclean="docker system prune --all --force --volumes"
alias dksh="docker-ssh"

alias dc="docker compose"
alias dcr="docker compose run"
alias dcsh="docker compose-ssh"
# }

# copy/paste{
is_linux && {
	alias pbcopy='xsel --clipboard --input'
	alias pbpaste='xsel --clipboard --output'
}
# }

# misc {
alias tags="ctags -R --exclude=@$DOTFILE_FOLDER/.ctagsignore -o tags"
alias l="sling"
alias fex='$(fzf)'
# }

# linuxbrew {
is_linux && {
  eval "${BREW_PREFIX}/bin/brew shellenv"
}
# }
# Kitty {
is_macos && {
  export KITTY_CONFIG_DIRECTORY="$DOTFILE_FOLDER/"
  alias kitty='/Applications/kitty.app/Contents/MacOS/kitty'
}
# }

# Python {
unset PYTHONHOME
unset PYTHONPATH
export PYTHONDONTWRITEBYTECODE=1
# }

# Search {
alias todo="rg -i todo"
alias rg='rg --ignore-file $HOME/.gitignore_global'

# shellcheck disable=SC1094 # this file is fine
[[ $- == *i* ]] && source "${BREW_PREFIX}/opt/fzf/shell/completion.zsh" 2> /dev/null

# shellcheck disable=SC1094 # this file is fine
source "${BREW_PREFIX}/opt/fzf/shell/key-bindings.zsh"

export FZF_DEFAULT_COMMAND="rg --files --follow --ignore-file $HOME/.gitignore_global"

# Trigger fzf-completion with **
export FZF_COMPLETION_TRIGGER='**'
# }

# Alias {
alias x509='openssl x509 -text -noout'               # That's what I use all the time
alias re='exec zsh'                                  # Reload .zshrc
alias als='alias | grep'                             # Search through aliases
alias reverse-link='find -L /dir/to/start -samefile' # Find what is linked to a file
alias ll='ls -la'
alias p8='ping -v 8.8.8.8'                           # Ping 8.8.8.8
alias pg='ps aux | grep'                             # ps and grep easily
alias kk='killall'                                   # Quicker kill all
alias hmac='openssl rand -hex 32'
alias tmp='tmux new-window "cd `mktemp -d` && zsh"'

# GDB {
alias gdb='gdb -q' # Silent GDB

# ref: http://thexploit.com/secdev/turning-off-buffer-overflow-protections-in-gcc/
alias gccunsafe='gcc -fno-stack-protector -D_FORTIFY_SOURCE=0'
# }

alias rm='echo "use /bin/rm or trash"' # Don't use rm unless you know what you're doing.

is_macos && {
  # Mac Catalina is breaking everything, thanks Tim Apple.
  # from https://www.kvraudio.com/forum/viewtopic.php?t=530824&start=15
  alias unlockvst='xattr -d com.apple.quarantine'
}
# }

# Misc {
alias gpg='GPG_TTY="$(tty)" gpg'

# Limit how many files can be used by the current session
ulimit -S -n 10240

eval "$(direnv hook zsh)"
alias direnv_rbenv='echo "use rbenv" >> .envrc && direnv allow'
export DIRENV_LOG_FORMAT=$'\033[2mdirenv: %s\033[0m'

# Restart espanso
(&>/dev/null espanso restart &)
# }

# Private {
source "$DOTFILE_FOLDER/private/.zshrc"
# }
