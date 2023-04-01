#!/usr/bin/env zsh
# shellcheck shell=bash
# vim: foldmarker={,} foldmethod=marker
# This file contains all the configuration necessary for running a zsh shell.

# Setup {
export DOTFILE_FOLDER="$HOME/.dot"
source "$DOTFILE_FOLDER/utils.zsh"
# }

# ZSH {
# zshoptions {
# Ref man zshoptions
setopt ALWAYS_TO_END
setopt APPEND_HISTORY
setopt AUTO_CD
setopt AUTO_LIST
setopt AUTO_MENU
setopt AUTO_PUSHD
setopt COMPLETE_IN_WORD
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt NO_BEEP
setopt PUSHD_IGNORE_DUPS
setopt PROMPT_SUBST
# }
# Lang {
export LANG="en_US.UTF-8"
export LC_ALL="$LANG"
export LC_CTYPE="$LANG"
# }
# Colors {
export TERM=xterm-kitty
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad
autoload -U colors && colors
# }
# Misc Exports {
export EDITOR='nvim'
export PUPPET_HOME="$HOME/Documents/dev/puppet"
# }
# Functions {
# Load compinit and check the cache only once a day
autoload -Uz compinit
is_macos && {
  if [ "$(date +'%j')" != "$(/usr/bin/stat -f '%Sm' -t '%j' "$HOME/.zcompdump")" ]; then
    compinit
  else
    compinit -C
  fi
}
is_linux && {
  if [[ -n $HOME/.zcompdump(#qN.mh+24) ]]; then
    compinit
  else
    compinit -C
  fi
}
zmodload -i zsh/complist
FPATH="$DOTFILE_FOLDER/functions:/usr/share/zsh/5.7.1/functions:$FPATH"

# shellcheck disable=SC2086 # doesn't find the functions if quoted
autoload -U $DOTFILE_FOLDER/functions/*(:t)
zmodload zsh/zprof
# }
# Path {
# }
# Prompt {
# Default prompt is just current dir
# shellcheck disable=SC2154 # colors are loaded somewhere else
PROMPT="%{${fg[green]}%}%c%{${reset_color}%} "

# This precmd will run at PROMPT display time.
prompt_precmd() {
  prompt_on_load_callback() {
    # Gets the new prompt value from the "$(prompt)" call.
    # shellcheck disable=SC2034 # no need to export this variable
    PROMPT="$(<&"$1")"

    zle reset-prompt
    zle -F "$1"
  }

  # run the slow prompt method
  exec {FD}< <(
    echo -n "$(prompt)"
  )
  # On result, call the callback
  zle -F $FD prompt_on_load_callback
}

typeset -a precmd_functions
# Add the prompt_precmd to the list of precmd_functions
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
bindkey '^Z' fancy-ctrl-z
bindkey "^R"      history-incremental-search-backward  # ctrl-r
bindkey "^A"      beginning-of-line                    # ctrl-a
bindkey "^E"      end-of-line                          # ctrl-e

# Use hjkl to select the completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v   # Default to standard vi bindings, regardless of editor string
# }
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
alias gc='git commit'
alias gl='git pull'
alias gp='git push -u'
alias gcb='git checkout -b'
alias gco='git checkout'
alias glo='git lg'
alias grhh='git reset --hard HEAD'
alias gst='git stash'
alias grccb=',git-recreate-current-branch'
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

# z {
is_macos && {
  # brew --prefix == /usr/local
  source "/usr/local/etc/profile.d/z.sh"
}
is_linux && {
  unsetopt BG_NICE
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
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
# shellcheck disable=SC1094 # this file is fine
source "/usr/local/opt/fzf/shell/key-bindings.zsh"

export FZF_DEFAULT_COMMAND="rg --files --follow --ignore-file $HOME/.gitignore_global"

# Trigger fzf-completion with **
export FZF_COMPLETION_TRIGGER='**'
# }

# Alias {
alias x509='openssl x509 -text -noout'               # That's what I use all the time
alias re='exec zsh'                                  # Reload .zshrc
alias als='alias | grep'                             # Search through aliases
alias reverse-link='find -L /dir/to/start -samefile' # Find what is linked to a file
alias coffee="caffeinate -d"                         # Keep display on
alias ll='ls -la'
alias p8='ping -v 8.8.8.8'                           # Ping 8.8.8.8
alias pg='ps aux | grep'                             # ps and grep easily
alias kk='killall'                                   # Quicker kill all
alias tel=',telegram-send'                            # Send a message to a telegram channel
alias hmac='openssl rand -hex 32'
alias tmp='cd "$(mktemp -d)"'
alias dotvi='cd $DOTFILE_FOLDER && vi'

# GDB {
alias gdb='gdb -q' # Silent GDB
# ref: http://thexploit.com/secdev/turning-off-buffer-overflow-protections-in-gcc/
alias gccunsafe='gcc -fno-stack-protector -D_FORTIFY_SOURCE=0'
# }

is_macos && {
  alias rm='echo "use /bin/rm or trash"' # Don't use rm unless you know what you're doing.

  # Mac Catalina is breaking everything, thanks Tim Apple.
  # from https://www.kvraudio.com/forum/viewtopic.php?t=530824&start=15
  alias unlockvst='xattr -d com.apple.quarantine'
}
# }

# Misc {
export LYNX_CFG=$HOME/.lynx.cfg

alias gpg='GPG_TTY="$(tty)" gpg'

# Limit how many files can be used by the current session
ulimit -S -n 10240

# env init {
# paths are setup in .zprofile
# Do manually what eval $(rbenv init -) does.
# export RBENV_SHELL="$SHELL"
# rbenv rehash 2>/dev/null
# # Replace nodenv with the custom function.
# # Ref: https://github.com/rbenv/rbenv#how-rbenv-hooks-into-your-shell
# alias rbenv=rbenv-function

# # Do manually what eval $(nodenv init -) does.
# export NODENV_SHELL="$SHELL"
# nodenv rehash 2>/dev/null
# # Ref: https://github.com/nodenv/nodenv#how-nodenv-hooks-into-your-shell
# alias nodenv=nodenv-function

# # Do manually what eval $(pyenv init -) does.
# export PYENV_SHELL="$SHELL"
# export PYENV_ROOT="$HOME/.pyenv"
# pyenv rehash 2>/dev/null
# }

# Restart espanso
(&>/dev/null espanso restart &)
# }
# Private {
source "$DOTFILE_FOLDER/private/.zshrc"
# }
# 1Password {
eval "$(op completion zsh)"; compdef _op op
# }
