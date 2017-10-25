# docker-study
- create at 2017.10.06
- os: ubuntu:16.04 4.4.0-31-generic 


the log for docker-study

## install docker 

[install-docker.sh](https://github.com/qinya0/docker-study/blob/master/shell/install-docker.sh)
```
  use: bash install-docker.sh
```

## docker in docker
- use docker in container

[Dockerfile](https://github.com/qinya0/docker-study/blob/master/Dockerfiles/docker-in-docker/Dockerfile)
```
  base images: ubuntu:14.04
  build:  docker build -t ubuntu:tag .
  use: docker run -d -ti \
     -v /var/run/docker.sock:/var/run/docker \
     --name qy-test-docker \
     ubuntu:tag bash
```

## build private docker-registry

- 完成文档[docker_registry.md](https://github.com/qinya0/docker-study/blob/master/markdown/docker_registry.md)
- 查看所有镜像和版本[get_images_registry.sh](https://github.com/qinya0/docker-study/blob/master/shell/get_images_registry.sh)

```bash
  mkdir /home/qy/registry
  docker run -d -ti --restart always \
     -v /home/qy/registry:/var/lib/registry \
     -v /etc/localtime:/etc/localtime:ro \
     -p 5000:5000 \
     --name qy-registry \
     registry:2
  # create passwd
  docker run --rm --entrypoint htpasswd registry:2 -Bbn qy-username qy-passwd
  # get all images and it's tags
  
```

## build gitlab in docker

- [docker_gitlab.md](https://github.com/qinya0/docker-study/blob/master/markdown/docker_gitlab.md)


## build jenkins2 in docker

- [docker_jenkins2.md](https://github.com/qinya0/docker-study/blob/master/markdown/docker_jenkins2.md)
