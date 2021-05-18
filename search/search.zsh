# RG
function rgf {
  rg --files -L -g "*$1*"
}

alias todo="rg -i todo"
alias rg='rg --ignore-file $ZSH/search/.ignore'

if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/usr/local/opt/fzf/bin"
fi

# FZF
# Auto-completion
[[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
source "/usr/local/opt/fzf/shell/key-bindings.zsh"

export FZF_DEFAULT_COMMAND='rg --files --follow --ignore-file $ZSH/search/.ignore'
