apt-get install -y python2.7 python2.7-tk

apt-get install -y python-pip
python2.7 -m pip install --upgrade pip
python2.7 -m pip install Cython && \
python2.7 -m pip install contextlib2 && \
python2.7 -m pip install pillow && \
python2.7 -m pip install lxml && \
python2.7 -m pip install jupyter && \
python2.7 -m pip install matplotlib && \
python2.7 -m pip install numpy 
