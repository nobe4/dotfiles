autoload -U compinit && compinit
zmodload -i zsh/complist

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Enable completion caching, use rehash to clear
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

# Fallback to built in ls colors
zstyle ':completion:*' list-colors ''

zstyle ':completion:*' menu select

# http://mervine.net/hacks/zsh-known-hosts-completion
# http://unix.stackexchange.com/a/52142
zstyle -s ':completion:*:(ssh|scp|sftp):*' hosts _ssh_config
[[ -r ~/.ssh/config ]] && _ssh_config+=($(cat ~/.ssh/config | sed -ne 's/Host[=\t ]//p'))
zstyle ':completion:*:(ssh|scp|sftp):*' hosts $_ssh_config