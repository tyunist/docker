apt-get install -y python2.7 python2.7-tk
alias python=python2.7

apt-get install -y python-pip
pip install --upgrade pip

pip install Cython && \
pip install contextlib2 && \
pip install pillow && \
pip install lxml && \
pip install jupyter && \
pip install matplotlib
