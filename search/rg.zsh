# Exit if ripgrep is not installed
if ! hash rg 2>/dev/null; then; return; fi

function rgf {
  rg --files -g "*$1*"
}

alias todo="rg -i todo"
alias rg='rg --ignore-file $ZSH/search/.ignore'
