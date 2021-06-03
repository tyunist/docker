#!/usr/bin/env bash

# Runs a docker container with the image created by build.bash
# Requires:
#   docker
#   nvidia-docker
#   an X server

# Import image name and container name from 
if [ -n "${DOCKER_IMG_NAME}" ]
then 
  echo "Create a docker container '${CONTAINER_NAME}' given by CONTAINER_NAME!"  
else 
  echo "Sourcing my_docker_env.sh to activate '${CONTAINER_NAME}' which is empty now"  
  source my_docker_evn.sh
fi

DOCKER_USER=$(whoami)

# Port mapping 
PORT_OPTS=0.0.0.0:7008:7008


if [ $# -lt 1 ]
then
    echo "Usage: $0 <docker image> [-ws <list of directories separated by a space to share with the container> ]"
    echo "I.e: $0 nvidia/ubuntu:latest ~/github_ws ~/bags"
    echo "By default, use $DOCKER_IMG_NAME:$DOCKER_IMG_TAG"
    #exit 1
else
	$DOCKER_IMG_NAME=$1
	$DOCKER_IMG_TAG=$2
	echo "Given docker image: $DOCKER_IMG_NAME:$DOCKER_IMG_TAG"
fi

#IMG=$(basename $DOCKER_IMG_NAME)
IMG=$DOCKER_IMG_NAME:$DOCKER_IMG_TAG

ARGS=("$@")
WORKSPACES=("${ARGS[@]:1}")

# Make sure processes in the container can connect to the x server
# Necessary so gazebo can create a context for OpenGL rendering (even headless)
XAUTH=/tmp/.docker.xauth
if [ ! -f $XAUTH ]
then
    xauth_list=$(xauth nlist :0 | sed -e 's/^..../ffff/')
    if [ ! -z "$xauth_list" ]
    then
        echo $xauth_list | xauth -f $XAUTH nmerge -
    else
        touch $XAUTH
    fi
    chmod a+r $XAUTH
fi

# Share your vim settings.
#VIMRC=$HOME/.vim
#DOCKER_OPTS="$DOCKER_OPTS -v $VIMRC:/home/$DOCKER_USER/.vim:rw"


## Share your bash file
#BASH_FILE=$HOME/.bashrc
#if [ -f $BASH_FILE ]
#then
#  DOCKER_OPTS="$DOCKER_OPTS -v $BASH_FILE:/home/$DOCKER_USER/.bashrc:rw"
#fi


# Share the github workspace 
#GITHUB_WS=$HOME/github_ws
#DOCKER_OPTS="$DOCKER_OPTS -v $GITHUB_WS:/home/$DOCKER_USER/github_ws:rw"


echo "Workspaces: ${WORKSPACES}"
# Share other workspaces from the command argument
for WS_DIR in ${WORKSPACES[@]}
do
  WS_DIRNAME=$(basename $WS_DIR)
  echo "Sharing Workspace! $WS_DIR"
  DOCKER_OPTS="$DOCKER_OPTS -v $WS_DIR:/home/$DOCKER_USER/$WS_DIRNAME:rw"
done

echo ">>> Options for this container: $DOCKER_OPTS"

# Mount extra volumes if needed.
# E.g.:
# -v "/opt/sublime_text:/opt/sublime_text" \

#--rm will remove the container after exitting
docker run -it \
  --name=$CONTAINER_NAME \
  -p $PORT_OPTS \
  -e DISPLAY \
  -e QT_X11_NO_MITSHM=1 \
  -e XAUTHORITY=$XAUTH \
  -v "$XAUTH:$XAUTH" \
  -v "/tmp/.X11-unix:/tmp/.X11-unix" \
  -v "/etc/localtime:/etc/localtime:ro" \
  -v "/dev/input:/dev/input" \
  --privileged \
  --security-opt seccomp=unconfined \
  $DOCKER_OPTS \
  $IMG	\
  bash
