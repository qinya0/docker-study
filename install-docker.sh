#!/bin/bash

# OS: ubuntu:14.04

# update the OS
apt-get update
apt-get install -y apt-transport-https ca-certificates

# ready
apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
echo "deb https://apt.dockerproject.org/repo ubuntu-trusty main" >> /etc/apt/sources.list
apt-get update

# show all version for the docker-engine
apt-cache policy docker-engine

# instal docker(you can install the other version for your OS)
apt-get install -y docker-engine=1.13.0-0~ubuntu-trusty

# delete useless package
rm -rf /var/lib/apt/lists/*

# check docker
docker version
