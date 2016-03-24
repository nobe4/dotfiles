# Exit if the silver searcher is not installed
if ! hash ag 2>/dev/null; then; return; fi

alias agf='ag -lg'
