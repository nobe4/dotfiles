alias dk="docker"
alias dc="docker-compose"

alias dkip="docker-machine ip default | /usr/bin/tr -d '\n' | tee >(pbcopy) | xargs echo copied$1"

alias dkrmxt="docker rm \$(docker ps -q -f status=exited)"
alias dkrmidg="docker images --all | awk '/^<none>/ {print $3}' | xargs docker rmi"

dksh(){
  docker exec -it $1 bash
}

alias bbox="docker run -it --rm busybox"
