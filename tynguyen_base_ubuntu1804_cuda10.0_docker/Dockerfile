# Copyright 2020
# Ty Nguyen 
# tynguyen.tech@gmail.com
# #==========================================================================
FROM nvidia/cuda:10.0-devel-ubuntu18.04

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
