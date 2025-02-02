#!/usr/bin/env zsh
# shellcheck shell=bash
# vim: foldmarker={,} foldmethod=marker
# This file contains all the configuration necessary for running a zsh shell.

# Setup {
source "$DOTFILE_FOLDER/utils.zsh"

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
setopt SHARE_HISTORY
# }

# Lang {
export LANG="en_US.UTF-8"
export LC_ALL="$LANG"
export LC_CTYPE="$LANG"
# }

# Colors {
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

# Important {
is macos && {
	# Don't use rm unless you know what you're doing.
	alias rm='echo "use /bin/rm or trash"'
}
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
alias vi="nvim"
alias vim="nvim"
alias vst='nvim +Git now' # Run Gstatus at vim startup
alias vih='nvim +help\ ' # Jump to vim help
alias vin='nvim -Nu NONE' # Vim without config
alias vit='nvim +tj\ ' # Jump to tag
alias vidir='nvim +":normal -"'
# }

# Git {
alias gd='git difftool'
alias ga='git add'
alias gb='git branch'
alias gbm='git branch -M'
alias gc='git commit'
alias gl='git pull'
alias glo='git lg'
alias grhh='git reset --hard HEAD'
alias gs='git switch'
alias gpf='git push --force-with-lease'
alias gsc='git switch -c'
alias gsm='git switch "$(git main)" && git pull && git sweep'
alias gss='git status'
alias gs-='git status -'
alias gst='git stash'
alias gcb='echo "DEPRECATED stop using git checkout for creating branch: use git switch for that (alias is gsc)"'
# }

# Docker {
alias dk="docker"
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
alias n="gh not"
alias nr="gh not --repl"
alias ns="gh not sync --verbosity 4"
alias tags="ctags -R --exclude=@$DOTFILE_FOLDER/.ctagsignore -o tags"
alias l="sling"
alias fex='$(fzf)'
alias wspec="find . -name '*.rb' | entr sh -c 'clear && bundle exec rspec'"
# }

# }
# Kitty {
is_macos && {
  alias kitty='${HOME}/Applications/kitty.app/Contents/MacOS/kitty'
}
# }

# Search {
alias todo="rg -i todo"

export FZF_DEFAULT_COMMAND="rg --files --follow"
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
alias tmp='(cd `mktemp -d` && $SHELL)'

# GDB {
alias gdb='gdb -q' # Silent GDB

# ref: http://thexploit.com/secdev/turning-off-buffer-overflow-protections-in-gcc/
alias gccunsafe='gcc -fno-stack-protector -D_FORTIFY_SOURCE=0'
# }


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

eval "$(mise activate zsh)"

# Restart espanso
(&>/dev/null espanso restart &)
# }

# Private {
source "$DOTFILE_FOLDER/private/.zshrc"
# }
