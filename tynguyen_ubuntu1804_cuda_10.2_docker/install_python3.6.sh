alias python=python3.6.9

apt-get install -y python3-pip
alias pip="python -m pip"
pip install --upgrade pip

pip install Cython && \
pip install contextlib2 && \
pip install pillow && \
pip install lxml && \
pip install jupyter && \
pip install matplotlib


# Make sure python3.6.9 is the default python3
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6.9 1
