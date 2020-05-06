# Import image name and container name from 
source constants_for_create_container.sh
docker stop $CONTAINER_NAME 
docker rm $CONTAINER_NAME 
