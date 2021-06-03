# Base docker container to build ours
export BASE_DOCKER_IMG_NAME="nvidia/cuda"            
export BASE_DOCKER_IMG_TAG="10.2-devel-ubuntu18.04"
export CUDA_VERSION="cuda10.2"
export CUDNN_VERSION="8.2.0.53"

# Container we want to build 
export DOCKER_IMG_NAME="tynguyen_ubuntu18.04_cuda10.2"
export DOCKER_IMG_TAG="cudnn8"
export CONTAINER_NAME="tynguyen_docker"  
