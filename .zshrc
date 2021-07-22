#!/usr/bin/env zsh
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
export TERM=xterm-256color
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxegedabagacad
autoload -U colors && colors
# }
# Misc Exports {
export EDITOR='vim'
export PUPPET_HOME="$HOME/Documents/dev/puppet"
# }
# Functions {
# Loaf compinit and check the cash only once a day
autoload -Uz compinit
if [ $(date +'%j') != $(/usr/bin/stat -f '%Sm' -t '%j' "$HOME/.zcompdump") ]; then
  compinit
else
  compinit -C
fi
zmodload -i zsh/complist
FPATH="$DOTFILE_FOLDER/functions:/usr/share/zsh/5.7.1/functions:$FPATH"

autoload -U $DOTFILE_FOLDER/functions/*(:t)
zmodload zsh/zprof
# }
# Path {
PATH="/usr/local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
is_macos && {
  PATH="$PATH:/Applications:~/Applications"
}

MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"
export PATH
export MANPATH
# }
# Prompt {
# in functions/git_prompt
PROMPT='%{$fg[yellow]%}n%{$fg[green]%}%c$(prompt_git)%{$reset_color%} '
# }
# Completion {
# Enable completion from partial words
# e.g. ~/men<TAB> => ~/Documents
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*' list-colors
zstyle ':completion:*' menu select
# }
#
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
# Key Binding {
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
alias ettt='tmux switch -t ettt'
# }

# Vim {
# Add MacVim to the path
is_macos && {
  export PATH="/Applications/MacVim.app/Contents/bin:$PATH"
}

alias vi="vim" # Use vim , not vi
alias vst='vim +Git now' # Run Gstatus at vim startup
alias vih='vim +help\' # Jump to vim help
alias vin='vim -Nu NONE' # Vim without config
alias vit='vim +tj\' # Jump to tag
alias n='vim +Notational' # Run Notational
# }

# Git {
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gl='git pull'
alias gp='git push -u'
alias gcb='git checkout -b'
alias gco='git checkout'
alias gla='git lg --all'
alias glo='git lg'
alias grhh='git reset --hard HEAD'
alias grbd='git stash && git checkout develop && git pull origin develop && git checkout - && git rebase develop && git stash pop'
alias grbm='git stash && git checkout master && git pull origin master && git checkout - && git rebase master && git stash pop'
alias gs='git status'
alias gst='git stash'
alias gcpmc='git checkout master && git pull origin master && git checkout'

# Recreate current branch and drop all changes.
alias grccb='current_branch="$(git rev-parse --abbrev-ref HEAD)" && git stash && git checkout master && git branch -D "$current_branch" && git checkout -b "$current_branch"'
# }

# Docker {
alias dk="docker"
alias dkclean="docker system prune --force --all --volumes"
alias bbox="docker run -it --rm busybox"
alias dkclean="docker system prune --all --force --volumes"
alias dksh="docker-ssh"

alias dc="docker-compose"
alias dcr="docker-compose run"
alias dcsh="docker-compose-ssh"
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
# The export doesn't seem to work, use an alias instead
export PATH="$PATH:~/.local/bin"
# }

# Search {
alias todo="rg -i todo"
alias rg='rg --ignore-file $HOME/.gitignore_global'

# FZF
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
	export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null
source "/usr/local/opt/fzf/shell/key-bindings.zsh"

export FZF_DEFAULT_COMMAND='rg --files --follow --ignore-file $HOME/.gitignore_global'

# Trigger fzf-completion with **
export FZF_COMPLETION_TRIGGER='**'
# }

# Go {
export PATH="$PATH:/usr/local/go/bin"
# Same as `which go`
GOBINARY="/usr/local/go/bin/go"
# Cache of $($GOBINARY env GOPATH)
export GOPATH=~/go # Needs to be absolute and without quote
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOPATH:$GOBIN"
# }

# Alias {
alias re='exec zsh'                                  # Reload .zshrc
alias als='alias | grep'                             # Search through aliases
alias reverse-link='find -L /dir/to/start -samefile' # Find what is linked to a file
alias sshr="ssh-root"                                # Root ssh
alias rssh="ssh-root"                                # Root ssh
alias coffee="caffeinate -d"                         # Keep display on
alias ll='ls -la'
alias p8='ping -v 8.8.8.8'                           # Ping 8.8.8.8
alias pg='ps aux | grep'                             # ps and grep easily
alias kk='killall'                                   # Quicker kill all
alias tel="telegram-send"                            # Send a message to a telegram channel

# GDB {
alias gdb='gdb -q' # Silent GDB
# ref: http://thexploit.com/secdev/turning-off-buffer-overflow-protections-in-gcc/
alias gccunsafe='gcc -fno-stack-protector -D_FORTIFY_SOURCE=0'
# }

# AWS {
alias aws_creds="$DOTFILE_FOLDER/aws/aws_creds.sh"
alias ro=routes
# }

is_macos && {
  alias rm='echo "use /bin/rm or trash"' # Don't use rm unless you know what you're doing.

  # Mac Catalina is breaking everything, thanks Tim Apple.
  # from https://www.kvraudio.com/forum/viewtopic.php?t=530824&start=15
  alias unlockvst='xattr -d com.apple.quarantine'
}
# }

# Misc {
export LYNX_CFG=~/.lynx.cfg

alias gpg='GPG_TTY="$(tty)" gpg'

# env init {
# Do manually what eval $(rbenv init -) does.
export PATH="$HOME/.rbenv/shims:${PATH}"
export RBENV_SHELL=$shell
(rbenv rehash &)
# Replace nodenv with the custom function.
# Ref: https://github.com/rbenv/rbenv#how-rbenv-hooks-into-your-shell
alias rbenv=rbenv-function

# Do manually what eval $(nodenv init -) does.
export PATH="$HOME/.nodenv/shims:${PATH}"
export NODENV_SHELL=$shell
(nodenv rehash &)
# Ref: https://github.com/nodenv/nodenv#how-nodenv-hooks-into-your-shell
alias nodenv=nodenv-function
# }

# RingZer0Team easy encrypt/decrypt
alias r0en="openssl enc -aes-256-cbc -in solution.md -out solution.txt"
alias r0de="openssl enc -aes-256-cbc -d -in solution.txt"

# Restart espanso
(&>/dev/null espanso restart &)
# }

# Vagrant {
# vagrant alias
alias vre="vagrant-halt && vagrant-up"
alias vup="vagrant-up"
alias vsh="vup && vagrant ssh"
# }
