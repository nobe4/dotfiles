# Check if docker exist before adding the env
if hash docker 2>/dev/null; then
  eval "$(docker-machine env default)"
fi

alias dk="docker"
alias dc="docker-compose"
alias dkip="docker-machine ip default | /usr/bin/tr -d '\n' | tee >(pbcopy) | xargs echo copied$1"
