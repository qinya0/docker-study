# docker-study
- create at 2017.10.06

the log for docker-study

## install docker 
- os: ubuntu:16.04

[install-docker.sh](https://github.com/qinya0/docker-study/blob/master/install-docker.sh)
```
  use: bash install-docker.sh
```

## docker in docker
- use docker in container

[Dockerfile](https://github.com/qinya0/docker-study/blob/master/Dockerfiles/docker-in-docker/Dockerfile)
```
  base images: ubuntu:14.04
  build:  docker build -t ubuntu:tag .
  use: docker run -ti -v /var/run/docker.sock:/var/run/docker ubuntu:tag bash
```
