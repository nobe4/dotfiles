autoload -U compinit && compinit
zmodload -i zsh/complist

# Enable completion from partial words
# e.g. ~/men<TAB> => ~/Documents
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*' list-colors
zstyle ':completion:*' menu select
