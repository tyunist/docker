######################################
# INSTALL OPENCV ON UBUNTU OR DEBIAN #
######################################

# -------------------------------------------------------------------- |
#                       SCRIPT OPTIONS                                 |
# ---------------------------------------------------------------------|
OPENCV_VERSION='4.2.0.34'       # Version to be installed
OPENCV_CONTRIB='NO'          # Install OpenCV's extra modules (YES/NO)
PYTHON_BIN='python3.7'

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

if [ $OPENCV_CONTRIB = 'NO' ]; then
  $PYTHON_BIN -m pip install opencv-python==$OPENCV_VERSION
fi
if [ $OPENCV_CONTRIB = 'YES' ]; then
  $PYTHON_BIN -m pip install opencv-contrib-python==$OPENCV_VERSION
fi

