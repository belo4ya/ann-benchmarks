#!/usr/bin/env bash

set -xeuo pipefail

sudo apt-get update -y && sudo apt-get upgrade -y

# Python

sudo apt-get install -y \
    build-essential \
    python3-dev python3-pip python3-venv \
    libssl-dev libbz2-dev liblzma-dev zlib1g-dev \
    libffi-dev libncurses5-dev libncursesw5-dev \
    libreadline-dev libsqlite3-dev libgdbm-dev libdb5.3-dev \
    libexpat1-dev libpcap-dev \
    libatlas-base-dev gfortran pkg-config libfreetype6-dev

sudo apt-get install -y libhdf5-dev python3-numpy python3-scipy python3-matplotlib python3-sklearn

# Docker

# Remove old versions
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# Add Docker's official GPG key:
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Env

python3 -m venv .venv
source .venv/bin/activate
pip install --upgrade pip setuptools wheel ansicolors

pip install -r requirements.txt

#python install.py --proc=4
#python run.py --timeout=-1
