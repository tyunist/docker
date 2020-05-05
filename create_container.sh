#!/usr/bin/env bash

# Runs a docker container with the image created by build.bash
# Requires:
#   docker
#   nvidia-docker
#   an X server


DOCKER_IMG_NAME=$DOCKER_IMG_NAME
CONTAINER_NAME=$CONTAINER_NAME
DOCKER_USER=$(whoami)

# Port mapping 
PORT_OPTS=0.0.0.0:7007:7007


if [ $# -lt 1 ]
then
    echo "Usage: $0 <docker image> [<dir with workspace> ...]"
	echo "By default, use $DOCKER_IMG_NAME"
    #exit 1
else
	$DOCKER_IMG_NAME=$1
	echo "Given docker image: $DOCKER_IMG_NAME"
fi

#IMG=$(basename $DOCKER_IMG_NAME)
IMG=$DOCKER_IMG_NAME

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

DOCKER_OPTS=

# Share your vim settings.
VIMRC=$HOME/.vim
DOCKER_OPTS="$DOCKER_OPTS -v $VIMRC:/home/$DOCKER_USER/.vim:rw"


# Share your bash file
BASH_FILE=$HOME/.bashrc
if [ -f $BASH_FILE ]
then
  DOCKER_OPTS="$DOCKER_OPTS -v $BASH_FILE:/home/$DOCKER_USER/.bashrc:rw"
fi


# Share the github workspace 
GITHUB_WS=$HOME/github_workspaces
DOCKER_OPTS="$DOCKER_OPTS -v $GITHUB_WS:/home/$DOCKER_USER/github_workspaces:rw"

echo "Docker options: $DOCKER_OPTS"

# Share other workspaces from the command argument
#for WS_DIR in ${WORKSPACES[@]}
#do
#  WS_DIRNAME=$(basename $WS_DIR)
#  if [ ! -d $WS_DIR/src ]
#  then
#    echo "Other! $WS_DIR"
#    DOCKER_OPTS="$DOCKER_OPTS -v $WS_DIR:/home/developer/other/$WS_DIRNAME"
#  else
#    echo "Workspace! $WS_DIR"
#    DOCKER_OPTS="$DOCKER_OPTS -v $WS_DIR:/home/developer/workspaces/$WS_DIRNAME"
#  fi
#done



# Mount extra volumes if needed.
# E.g.:
# -v "/opt/sublime_text:/opt/sublime_text" \

#--rm will remove the container after exitting
nvidia-docker run -it \
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
  --runtime=nvidia \
  --security-opt seccomp=unconfined \
  $DOCKER_OPTS \
  $IMG	\
  bash
