# Import image name and container name from 
source my_docker_env.sh
docker start $CONTAINER_NAME 
docker exec -it $CONTAINER_NAME bash
