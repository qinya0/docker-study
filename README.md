# docker-study
- create at 2017.10.06

the log for docker-study

## install docker 
- os: ubuntu:16.04

```
  [install-docker.sh](![install-docker.sh])
  use: bash install-docker.sh
```

## docker in docker
- use docker in container

```
  base images: ubuntu:14.04
  [Dockerfile](![ubuntu_docker/Dockerfile])
  build:  docker build -t ubuntu:tag .
  use: docker run -ti -v /var/run/docker.sock:/var/run/docker ubuntu:docker_base bash
```
