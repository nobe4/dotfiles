# Check if docker exist before adding the env and aliases
if ! hash docker 2>/dev/null; then
  alias dk="echo 'Please install docker first'"
  return
fi

eval "$(docker-machine env default)"

alias dk="docker"
alias dc="docker-compose"

alias dkip="docker-machine ip default | /usr/bin/tr -d '\n' | tee >(pbcopy) | xargs echo copied$1"

alias dkrmxt="docker rm $(docker ps -q -f status=exited)"
alias dkrmidg="docker images --quiet --filter=dangling=true | xargs docker rmi"

alias dkenv="eval \"$(docker-machine env default)\""

dksh(){
  docker exec -it $1 bash
}

