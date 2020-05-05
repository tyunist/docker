# Copyright 2020
# Ty Nguyen 
# tynguyen.tech@gmail.com
# #==========================================================================

FROM nvidia/cuda:10.0-base-ubuntu18.04

# Install essential development packages
ADD install_essential_packages.sh /install_essential_packages.sh
RUN /install_essential_packages.sh


# Install the Tensorflow Object Detection API from here
# https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/installation.md

# Install timezone using script
# NOTE: make sure that file install_timezone.sh is executable
ADD install_timezone.sh /install_timezone.sh
RUN /install_timezone.sh
#RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata

# Install object detection api dependencies
RUN apt-get update 

## Install python3.7 and python3.7 packages
ADD install_python3.7.sh /install_python3.7.sh 
RUN /install_python3.7.sh 

 Install python2.7 and its packages
ADD install_python2.7.sh /install_python2.7.sh 
RUN /install_python2.7.sh 


# Get protoc 3.0.0
RUN curl -OL "https://github.com/google/protobuf/releases/download/v3.0.0/protoc-3.0.0-linux-x86_64.zip" && \
    unzip protoc-3.0.0-linux-x86_64.zip -d proto3 && \
    mv proto3/bin/* /usr/local/bin && \
    mv proto3/include/* /usr/local/include && \
    rm -rf proto3 protoc-3.0.0-linux-x86_64.zip

# Install wget (to make life easier below) and editors (to allow people to edit
# the files inside the container)
RUN apt-get update && \
    apt-get install -y wget vim emacs nano

ARG work_dir=/tensorflow/models/research


# Ty's Username
ARG user_name=tynguyen
ARG user_id=1000
ARG g_id=1000
## Replace 1012 with your user / group id of the machine on which docker is installed
# To find this, use: $id -u  and $id -g 
RUN apt-get install sudo
RUN export uid=$user_id gid=$g_id && \
    mkdir -p /home/$user_name && \
    echo "$user_name:x:${uid}:${gid}:$user_name,,,:/home/$user_name:/bin/bash" >> /etc/passwd && \
    echo "$user_name:x:${uid}:" >> /etc/group && \
    echo "$user_name ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$user_name && \
    chmod 0440 /etc/sudoers.d/$user_name && \
    chown ${uid}:${gid} -R /home/$user_name


WORKDIR ${work_dir}

USER $user_name
ENV HOME /home/$user_name

