######################################
# INSTALL OPENCV ON UBUNTU OR DEBIAN #
######################################

# -------------------------------------------------------------------- |
#                       SCRIPT OPTIONS                                 |
# ---------------------------------------------------------------------|
OPENCV_VERSION='4.2.0'       # Version to be installed
OPENCV_CONTRIB='NO'          # Install OpenCV's extra modules (YES/NO)
PYTHON_BIN='/usr/bin/python3.7'
PYTHON_LIB='/usr/lib/python3.7'
PYTHON_INCLUDE='/usr/include/python3.7'
PYTHON_PKG_PATH='/usr/local/lib/python3.7/dist-packages/'
PYTHON_NUMPY_INCLUDE='/usr/local/lib/python3.7/dist-packages/numpy/core/include'
# Make sure python3.7 is default (instead of  python3.6)
#update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1
# -------------------------------------------------------------------- |

# |          THIS SCRIPT IS TESTED CORRECTLY ON          |
# |------------------------------------------------------|
# | OS               | OpenCV       | Test | Last test   |
# |------------------|--------------|------|-------------|
# | Ubuntu 20.04 LTS | OpenCV 4.2.0 | OK   | 25 Apr 2020 |
# |----------------------------------------------------- |
# | Debian 10.2      | OpenCV 4.2.0 | OK   | 26 Dec 2019 |
# |----------------------------------------------------- |
# | Debian 10.1      | OpenCV 4.1.1 | OK   | 28 Sep 2019 |
# |----------------------------------------------------- |
# | Ubuntu 18.04 LTS | OpenCV 4.1.0 | OK   | 22 Jun 2019 |
# | Debian 9.9       | OpenCV 4.1.0 | OK   | 22 Jun 2019 |
# |----------------------------------------------------- |
# | Ubuntu 18.04 LTS | OpenCV 3.4.2 | OK   | 18 Jul 2018 |
# | Debian 9.5       | OpenCV 3.4.2 | OK   | 18 Jul 2018 |



# 1. KEEP UBUNTU OR DEBIAN UP TO DATE

apt-get -y update
# apt-get -y upgrade       # Uncomment to install new versions of packages currently installed
# apt-get -y dist-upgrade  # Uncomment to handle changing dependencies with new vers. of pack.
# apt-get -y autoremove    # Uncomment to remove packages that are now no longer needed


# 2. INSTALL THE DEPENDENCIES

# Build tools:
apt-get install -y build-essential cmake

# GUI (if you want GTK, change 'qt5-default' to 'libgtkglext1-dev' and remove '-DWITH_QT=ON'):
apt-get install -y qt5-default libvtk6-dev

# Media I/O:
apt-get install -y zlib1g-dev libjpeg-dev libwebp-dev libpng-dev libtiff5-dev libjasper-dev \
                        libopenexr-dev libgdal-dev

# Video I/O:
apt-get install -y libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev \
                        libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev yasm \
                        libopencore-amrnb-dev libopencore-amrwb-dev libv4l-dev libxine2-dev

# Parallelism and linear algebra libraries:
apt-get install -y libtbb-dev libeigen3-dev

# Python:
apt-get install -y python-dev  python-tk  pylint  python-numpy  \
                        python3-dev python3-tk pylint3 python3-numpy flake8

# Java:
apt-get install -y ant default-jdk

# Documentation and other:
apt-get install -y doxygen unzip wget


# 3. INSTALL THE LIBRARY

wget https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.zip
unzip ${OPENCV_VERSION}.zip && rm ${OPENCV_VERSION}.zip
mv opencv-${OPENCV_VERSION} OpenCV

if [ $OPENCV_CONTRIB = 'YES' ]; then
  wget https://github.com/opencv/opencv_contrib/archive/${OPENCV_VERSION}.zip
  unzip ${OPENCV_VERSION}.zip && rm ${OPENCV_VERSION}.zip
  mv opencv_contrib-${OPENCV_VERSION} opencv_contrib
  mv opencv_contrib OpenCV
fi

cd OpenCV && mkdir build && cd build

if [ $OPENCV_CONTRIB = 'NO' ]; then
cmake -DWITH_QT=ON -DWITH_OPENGL=ON -DFORCE_VTK=ON -DWITH_TBB=ON -DWITH_GDAL=ON -DPYTHON_DEFAULT_EXECUTABLE=$PYTHON_BIN -DPYTHON_INCLUDE=$PYTHON_INCLUDE -DPYTHON_LIBRARY=$PYTHON_LIB -DPYTHON_PACKAGES_PATH=$PYTHON_PKG_PATH -DPYTHON_NUMPY_INCLUDE_DIR=$PYTHON_NUMPY_INCLUDE \
      -DCMAKE_BUILD_TYPE=RELEASE \
      -DCMAKE_INSTALL_PREFIX=/usr/local \
      -DWITH_XINE=ON -DENABLE_PRECOMPILED_HEADERS=OFF ..
fi

if [ $OPENCV_CONTRIB = 'YES' ]; then
cmake -DWITH_QT=ON -DWITH_OPENGL=ON -DFORCE_VTK=ON -DWITH_TBB=ON -DWITH_GDAL=ON \
      -DWITH_XINE=ON -DENABLE_PRECOMPILED_HEADERS=OFF \
      -DWITH_CUDA=ON \
      -DPYTHON_DEFAULT_EXECUTABLE=$PYTHON_BIN \
      -DPYTHON_INCLUDE=$PYTHON_INCLUDE \
      -DPYTHON_LIBRARY=$PYTHON_LIB \
      -DPYTHON_PACKAGES_PATH=$PYTHON_PKG_PATH \
      -DPYTHON_NUMPY_INCLUDE_DIR=$PYTHON_NUMPY_INCLUDE \
      -DCMAKE_BUILD_TYPE=RELEASE \
      -DCMAKE_INSTALL_PREFIX=/usr/local \
      -DOPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules ..
fi

make -j8
make install
ldconfig


# 4. EXECUTE SOME OPENCV EXAMPLES AND COMPILE A DEMONSTRATION

# To complete this step, please visit 'http://milq.github.io/install-opencv-ubuntu-debian'.
