apt-get install -y python3.7 python3.7-tk

apt-get install -y python3-pip
alias pip="python3.7 -m pip"
pip install --upgrade pip

python3.7 -m pip install Cython && \
python3.7 -m pip install contextlib2 && \
python3.7 -m pip install pillow && \
python3.7 -m pip install lxml && \
python3.7 -m pip install jupyter && \
python3.7 -m pip install matplotlib && \
python3.7 -m pip install numpy 

# Make sure python3.7 is the default python3
update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 1
