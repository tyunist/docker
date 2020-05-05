#!/usr/bin/env bash
```
Usage: bash build_img.sh <folder_to_the_Docker_file>

The created docker image will have the name + tag: folder_to_the_Docker_file:latest
```
# Builds a Docker image.

# Define user name for the docker container
# This may not work if an user belongs to multiple groups. If it is the case, manually input
user_name=$(whoami)
user_id=$(id -u)
#g_id=$(id -g)
g_id=$user_id

if [ $# -eq 0 ]
then
    echo "Usage: $0 directory-name"
    exit 1
fi

# get path to current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ ! -d $DIR/$1 ]
then
  echo "image-name must be a directory in the same folder as this script"
  echo "What you've given: $DIR/$1"
  exit 2
fi

image_name=$(basename $1)


echo "Dir: $DIR"
echo "Image name: $image_name"
echo "group id: $g_id"
echo "user_id: $user_id"

#image_plus_tag=$image_name:$(date +%Y_%b_%d_%H%M)
image_plus_tag=$image_name:latest

docker build --rm=true -t $image_plus_tag --build-arg user_id=$user_id \
	     --build-arg user_name=$user_name	\
	     --build-arg g_id=$g_id \
	     $DIR/$image_name 
#docker tag $image_plus_tag $image_name:latest

echo "Built $image_plus_tag and tagged as $image_name:latest"
