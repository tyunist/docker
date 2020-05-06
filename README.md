# docker
My repo for managing dockers

# Structure 
## Base image: tynguyen_base_ubuntu1804_cuda10.0_docker:latest 
- [x] cuda10.0
- [x] nvidia 440
- [x] python3.7
- [x] Opencv3 python3.7 via pip :-( 

## Coral_tpu image
From tynguyen_base_ubuntu1804_cuda10.0_docker:latest 

- [] cocoapi 
- [x] proto3 

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

### tynguyen_caffe_pytorch_tf_base_docker
From caffe2ai/caffe2:c2v0.8.1.cuda8.cudnn7.ubuntu16.04 
- [] python3.7
- [x] python2.7, caffe
- []

To install pytorch cuda8.0
```
Install miniconda within the container
```
```
conda install pytorch==1.0.0 torchvision==0.2.1 cuda80 -c pytorch 
```

## Create a new image from a base image
Create a folder whose name is the name of the image to create 
i.e. DOCKER_IMG_NAME=coral_tpu_detector_docker, then 
```
cd $DOCKER_IMG_NAME
touch Dockerfile
```
Include the following line to the Dockerfile
```
FROM <name + tag of the base image>
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
## Choose the docker image and the name of the container by setting in 
```
DOCKER_IMG_NAME="tynguyen_base_ubuntu1804_cuda10.0_docker:latest"
CONTAINER_NAME="tynguyen_base"
```
in constants_for_create_container.sh 

## Before buidling the image, make sure the base image is already there 
if not, 
```
bash build_img.sh <directory to the base image dockerfile>
```
i.e 
```
bash build_img.sh tynguyen_base_ubuntu1804_cuda_10.0_docker 
```

and then build the image 
```
bash build_img.sh <directory to the image>
```
i.e 
```
bash build_img.sh coral_tpu_detector_docker
```

## Create the container 
Name of the image and container should be already set in constants_for_create_container.sh file
```
bash create_container.sh
```



## 
