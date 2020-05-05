# docker
My repo for managing dockers

# Structure 
## Base image: tynguyen_base_ubuntu1804_cuda10.0_docker:latest 
- [x] cuda10.0
- [x] nvidia 440
- [x] python3.7
- [] Opencv3

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

# Note
Make sure to set every scripts "install....sh" runable
i.e.
```
chmod +x install_python3.7.sh


## 
