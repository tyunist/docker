# Copyright 2020
# Ty Nguyen 
# tynguyen.tech@gmail.com
# #==========================================================================
# For the following ARG variables, an default value is given to use if not set through --build_arg  i.e. docker build --build_arg base_docker_img_name=nvidia/cuda ....

ARG base_docker_img_name="nvidia/cuda" 
ARG base_docker_img_tag="10.2-devel-ubuntu18.04"

FROM ${base_docker_img_name}:${base_docker_img_tag}
#FROM nvidia/cuda:10.2-devel-ubuntu18.04




# Install cudnn
# NOTE: in order to make the following ENV works, the following lines must be given after FROM ...
ARG cudnn_version="8.2.0.53"
ARG cuda_version="cuda10.2"
ENV CUDA_VERSION=$cuda_version
ENV CUDNN_VERSION=$cudnn_version 
#ENV CUDA_VERSION cuda10.2
#ENV CUDNN_VERSION 8.2.0.53

LABEL com.nvidia.cudnn.version="${CUDNN_VERSION}"

#TODO: change this cuda10.2 according to the CUDA version that you want to use
RUN echo "Cuda version: $CUDA_VERSION"
RUN apt-get update && apt-get install -y --no-install-recommends \
    libcudnn8=$CUDNN_VERSION-1+$CUDA_VERSION \
    libcudnn8-dev=$CUDNN_VERSION-1+$CUDA_VERSION \
    && apt-mark hold libcudnn8 && \
    rm -rf /var/lib/apt/lists/*


ENV DEBIAN_FRONTEND noninteractive

# Install object detection api dependencies
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

# Install essential development packages
ADD install_essential_packages.sh /install_essential_packages.sh
RUN /install_essential_packages.sh

# Install python3.7
ADD install_python3.7.sh /install_python3.7.sh
RUN /install_python3.7.sh

# Install timezone using script
# NOTE: make sure that file install_timezone.sh is executable
ADD install_timezone.sh /install_timezone.sh
RUN /install_timezone.sh
#RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata


# Install wget (to make life easier below) and editors (to allow people to edit
# the files inside the container)
RUN apt-get update && \
    apt-get install -y wget vim emacs nano tmux

# Install opencv3
ADD install_opencv3_from_pip.sh /install_opencv3_from_pip.sh
RUN /install_opencv3_from_pip.sh
