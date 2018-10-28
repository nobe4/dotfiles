# Spawn a bash inside a running container
dcsh() {
  docker-compose exec $1 bash
}

dksh(){
  docker exec -it $1 bash
}

