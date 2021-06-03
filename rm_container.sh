# Import image name and container name from 
source my_docker_env.sh
docker stop $CONTAINER_NAME 
docker rm $CONTAINER_NAME 
