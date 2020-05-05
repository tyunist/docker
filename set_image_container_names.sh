DOCKER_IMG_NAME="coral_tpu_detector_docker:latest"
CONTAINER_NAME="tynguyen_coral_tpu_detector_docker"

if [ -n "$1" ]
  then 
  echo "Given image + tagname: $1"
  DOCKER_IMG_NAME=$1
  else
  echo "Not given an image + tagname!"
  echo "By default, image name = $DOCKER_IMG_NAME"
fi 

if [ -n "$2" ]
  then 
  echo "Given container name: $2"
  CONTAINER_NAME=$2
  else
  echo "Not given a container name!"
  echo "By default, container name = $CONTAINER_NAME"
fi 

export DOCKER_IMG_NAME=$DOCKER_IMG_NAME
export CONTAINER_NAME=$CONTAINER_NAME

exec $SHELL -i

