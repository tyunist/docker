apt-get install -y python3.7 python3.7-tk
alias python=python3.7

apt-get install -y python3-pip
alias pip="python3.7 -m pip"
pip install --upgrade pip

pip install Cython && \
pip install contextlib2 && \
pip install pillow && \
pip install lxml && \
pip install jupyter && \
pip install matplotlib
