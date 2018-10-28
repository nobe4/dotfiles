# Exit if ripgrep is not installed
if ! hash rg 2>/dev/null; then; return; fi

function rgf {
  exec rg --files -g "$1"
}
