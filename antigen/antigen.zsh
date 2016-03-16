# Antigen handles the zsh plugins and theme
source ~/.antigen/antigen.zsh

antigen use oh-my-zsh

# Syntax highlighting bundle.
antigen bundles <<EOBUNDLES
git
z
vagrant
extract
tmux
zsh-users/zsh-syntax-highlighting
EOBUNDLES

antigen theme $ZSH/prompt nope.zsh-theme

antigen apply

