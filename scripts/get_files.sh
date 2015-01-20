#!/bin/bash
if [ ! -z "$1" ]; then
  LOC=$1
  LOC2=$LOC1
else 
  LOC=/tmp
  LOC2=/opt
fi

# Get setuptools
echo Downloading setuptools
if [ ! -d "$LOC/python" ]; then
  mkdir $LOC/python
fi
wget https://bootstrap.pypa.io/ez_setup.py --no-check-certificate -O $LOC/python/ez_setup.py -nv 

# download pyopenssl
echo Downloading pyOpenSSL
wget --no-check-certificate https://pypi.python.org/packages/source/p/pyOpenSSL/pyOpenSSL-0.14.tar.gz -O $LOC/python/pyOpenSSL.tar.gz -nv 
mkdir /tmp/pyOpenSSL.tar.gz
tar -zxf $LOC/python/pyOpenSSL.tar.gz -C /tmp/pyOpenSSL.tar.gz

echo Cloning headphones repo
if [ -d "$LOC2/headphones" ]; then
  rm -rf $LOC2/headphones
fi
mkdir $LOC2/headphones
git clone https://github.com/rembo10/headphones.git $LOC2/headphones
