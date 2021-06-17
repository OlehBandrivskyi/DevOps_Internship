#!/bin/bash
#install DockerEngine on Ubuntu

#uninstall old versions
apt-get -y remove docker docker-engine docker.io containerd runc

#install using the repository
apt-get -y update

apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null


#install Docker Engine, CLI, and Containerd packages 
apt-get -y update
apt-get -y install docker-ce docker-ce-cli containerd.io