# #==========================================================================

FROM caffe2ai/caffe2:c2v0.8.1.cuda8.cudnn7.ubuntu16.04



RUN pip install --upgrade pip 
ADD install_pytorch_cu80.sh /install_pytorch_cu80.sh
RUN /install_pytorch_cu80.sh

ENV DEBIAN_FRONTEND noninteractive

# Install object detection api dependencies
RUN apt-get update && apt-get install -y --no-install-recommends apt-utils

# Install essential development packages
ADD install_essential_packages.sh /install_essential_packages.sh
RUN /install_essential_packages.sh

# Install timezone using script
# NOTE: make sure that file install_timezone.sh is executable
ADD install_timezone.sh /install_timezone.sh
RUN /install_timezone.sh
#RUN DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata

ARG tf_major=1
ARG tf_minor=15
ARG tf_version=$tf_major.$tf_minor

# Install object detection api dependencies
RUN apt-get update 

# Install opencv
RUN apt install -y python-opencv

# Install tensorflow  
#ADD install_tf_$tf_version.sh /install_tf_$tf_version.sh
#RUN /install_tf_%tf_version.sh


# Install pytorch
#ADD install_pytorch.sh /install_pytorch.sh
#RUN /install_pytorch.sh


# Add username and add to sudoers group to install tensorflow ...
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


# Create a vim directory to share your own vim with the docker
ARG vim_dir=/home/$user_name/.vim
RUN mkdir -p $vim_dir  
# By default, it will copy the default vim from vim_rc included in this base folder
ADD vim_rc $vim_dir 

# Copy over the default .tmuxconfig 
ARG tmux_path=/home/$user_name/.tmux.conf
ADD tmux.conf $tmux_path 
#RUN tmux source-file $tmux_path 

# Github workspace
ARG github_dir=/home/$user_name/github_workspaces


USER $user_name
ENV HOME /home/$user_name


