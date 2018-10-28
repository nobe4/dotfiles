alias dk="docker"
alias dc="docker-compose"
alias dcr="docker-compose run"

alias dkrmxt="docker rm \$(docker ps -q -f status=exited)"
alias dkrmidg="docker images --all | awk '/^<none>/ {print $3}' | xargs docker rmi"

alias bbox="docker run -it --rm busybox"
