# Spawn a bash inside a running container
getin() {
  docker-compose exec $1 bash
}
