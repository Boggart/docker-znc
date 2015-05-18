#! /usr/bin/env bash
set -e


# Config
ZNC_VERSION="1.6.0"


# Ensure package list is up to date.
apt-get update

# Install runtime dependencies.
apt-get install -y sudo

# Install build dependencies.
apt-get install -y software-properties-common python-software-properties
add-apt-repository "deb http://archive.ubuntu.com/ubuntu $(lsb_release -sc) universe"
apt-get update
apt-get build-dep -y znc
apt-get install -y wget


# Prepare building
mkdir -p /src


# Download, compile and install ZNC.
cd /src
wget "http://znc.in/releases/archive/znc-${ZNC_VERSION}.tar.gz"
tar -zxf "znc-${ZNC_VERSION}.tar.gz"
cd "znc-${ZNC_VERSION}"
./configure --enable-python && make && make install


# Clean up
apt-get remove -y wget
apt-get autoremove -y
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
