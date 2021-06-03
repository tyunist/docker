# Docker
My repo for docker management
tynguyen@seas.upenn.edu 

# Updates
- [ ] [updated June 1st 2021] more flexible on cudnn version and cuda version. New build_img.sh script enables to select cuda version as well as cudnn version. 
- [ ] [updated June 2st 2021] move away .bashrc, .tmux.conf, my_docker_env.sh from the host machine by giving them directly 

# Structure 
## Base image: tynguyen_ubuntu1804_cuda12.0_docker:latest 
Based on nvidia/cuda:10.2-devel-ubuntu18.04
- [x] ubuntu18.04
- [x] cuda10.2
- [x] nvidia 440
- [x] python3.7
- [x] Opencv3 python3.7 via pip :-( 

## Dev images
### Coral_tpu image
Based on tynguyen_base_ubuntu1804_cuda10.0_docker:latest 
- [ ] cocoapi 
- [x] proto3 
- [x] vim 
- [x] .tmux.conf 

Install cocoAPI as follows 
```
git clone --depth 1 https://github.com/cocodataset/cocoapi.git 
cd cocoapi/PythonAPI 
```
Revise 'python ...' in  Makefile to 'python3.7'
```
make -j8 
cp -r pycocotools /tensorflow/models/research && \
    cd ../../ && \
    rm -rf cocoapi
```

### Pytorch tensorflow ROS image
Based on tynguyen_base_ubuntu1804_cuda10.0_docker:latest 
- [ ] cocoapi 
- [ ] proto3 
- [ ] vim 
- [ ] .tmux.conf 
- [ ] pytorch python3.7
- [ ] tensorflow2.0 python3.7
- [ ] ROS Melodic python3.7

### tynguyen_caffe_pytorch_tf_base_docker
From caffe2ai/caffe2:c2v0.8.1.cuda8.cudnn7.ubuntu16.04 
- [ ] python3.7
- [x] Caffe python2.7
- [ ] pytorch cuda8.0 python2.7

To manually install pytorch cuda8.0
```
Install miniconda within the container
```
```
conda install pytorch==1.0.0 torchvision==0.2.1 cuda80 -c pytorch 
```

## Create a new image from a base image
Create a folder that contains our Dockefile
i.e. DOCKER_FILE_FOLDER=dockerfile_path, then 
```
source my_docker_env.sh
cd $DOCKER_FILE_PATH
touch Dockerfile
```
To make it easier to manage which packages installed in the image, for each package supposed to be intalled in the image, one should create a script
i.e
```
touch install_pytorch.sh
chmod +x install_pytorch.sh
``` 
Remove all "sudo" in the install_pytorch.sh. Then, in the Dockerfile, include

```
ADD install_pytorch.sh /install_pytorch.sh
RUN /install_pytorch.sh
```

### Note
Make sure to set every scripts "install....sh" runable
i.e.
```
chmod +x install_python3.7.sh
```


# Create a container 
## Set the docker image and the name of the container by modifying: 
```
DOCKER_IMG_NAME="tynguyen_base_ubuntu1804_cuda10.0_docker:latest"
CONTAINER_NAME="tynguyen_base"
```
in my_docker_env.sh 
Then, run this shell script
```
bash my_docker_env.sh
```

## Build the Image if Not Exist Yet
```
bash build_img.sh <directory to the image dockerfile>
```
i.e 
```
bash build_img.sh tynguyen_base_ubuntu1804_cuda_10.0_docker 
```

## Create the container 
Name of the image and container should be already set in my_docker_env.sh file
```
bash create_container.sh <docker image> [-ws <List of folders that want to share with the container> ]
```
For example: 
```
bash create_container nvidia/ubuntu:latest ~/github_ws ~/bags

```
In this example, the created container will share two folders: ~/github_ws and ~/bags with the host machine. 

# Use a container
Once a container is created, the following scripts are used to easily manage the container.
```
run_container.sh: start the container (different from creating the container). This is used in case the  container is already there (check by $docker container ls -a)
stop_container.sh: stop the container 
rm_container.sh : remove the container
```
These scripts refer to $CONTAINER_NAME set in my_docker_env.sh 

---
