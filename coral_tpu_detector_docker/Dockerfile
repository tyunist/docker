# #==========================================================================

FROM tynguyen_base_ubuntu1804_cuda10.0_docker:latest 


# Install object detection api dependencies
RUN apt-get update 



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



#RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser $user_name sudo

# The base image has already provided python3.7. Install another version if needed
## Install python2.7 and python2.7 packages
#ADD install_python2.7.sh /install_python2.7.sh 
#RUN /install_python2.7.sh 

# Install tensorflow  
ADD install_tf_1.15.sh /install_tf_1.15.sh
RUN /install_tf_1.15.sh

# Get the tensorflow models research directory, and move it into tensorflow
# source folder to match recommendation of installation
RUN git clone https://github.com/tensorflow/models.git && \
    mkdir -p /tensorflow && \
    chown $user_name /tensorflow && \
    mv models /tensorflow/models


# Get protoc 3.0.0
RUN curl -OL "https://github.com/google/protobuf/releases/download/v3.0.0/protoc-3.0.0-linux-x86_64.zip" && \
    unzip protoc-3.0.0-linux-x86_64.zip -d proto3 && \
    mv proto3/bin/* /usr/local/bin && \
    mv proto3/include/* /usr/local/include && \
    rm -rf proto3 protoc-3.0.0-linux-x86_64.zip



# Install pycocoapi. We ignore it and manually install inside the container
#RUN python2.7 -m pip install numpy
#RUN python2.7 -m pip install Cython
#RUN git clone --depth 1 https://github.com/cocodataset/cocoapi.git && \
#    cd cocoapi/PythonAPI && \
#    make -j8 && \
#    cp -r pycocotools /tensorflow/models/research && \
#    cd ../../ && \
#    rm -rf cocoapi


# Run protoc on the object detection repo
RUN cd /tensorflow/models/research && \
    protoc object_detection/protos/*.proto --python_out=.

# Set the PYTHONPATH to finish installing the API
ENV PYTHONPATH $PYTHONPATH:/tensorflow/models/research:/tensorflow/models/research/slim

ARG work_dir=/tensorflow/models/research
# Get object detection transfer learning scripts.
ARG scripts_link="http://storage.googleapis.com/cloud-iot-edge-pretrained-models/docker/obj_det_scripts.tgz"
RUN cd ${work_dir} && \
    wget -O obj_det_scripts.tgz ${scripts_link} && \
    tar zxvf obj_det_scripts.tgz

WORKDIR ${work_dir}


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


