#!/bin/bash
set -ex

# OS: ubuntu:16.04

# update 
#sudo apt-get update
#sudo apt-get install -y apt-transport-https ca-certificates

# ready for install
#sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

sudo rm -rf /etc/apt/sources.list.d/dokcer.list
sudo touch /etc/apt/sources.list.d/docker.list
sudo chmod 777 /etc/apt/sources.list.d/docker.list
sudo echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" > /etc/apt/sources.list.d/docker.list

sudo apt-get update

# delete the old 
sudo apt-get purge lxc-docker

# search all version of docker-engine
sudo apt-cache policy docker-engine

# instal docker(you can install the other version for your system)
sudo apt-get install -y docker-engine=1.13.0-0~ubuntu-trusty

# delete useless package
sudo rm -rf /var/lib/apt/lists/*

# check docker
sudo docker version
