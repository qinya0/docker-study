# build private docker-registry

## build container for registry

```bash
  # a file for registry
  mkdir /home/qy/registry
  # the file(/var/lib/registry) is images_save_file
  docker run -d -ti --restart always -v /home/qy/registry:/var/lib/registry \
  -v /etc/localtime:/etc/localtime:ro -p 5000:5000 --name qy-registry registry:2

  # test the container
  docker pull hello-world
  docker tag hello-world localhost:5000/hello-world
  docker push localhost:5000/hello-world
  docker rmi localhost:5000/hello-world
  docker pull localhost:5000/hello-world
  # over
```

## config docker 

```bash
  # config docker-insecure-registry
  sudo vim /etc/default/docker
  # set the ip:port to config:
  DOCKER_OPTS="--insecure-registry 10.0.2.15:5000"
  # if you config the proxy for docker(export http_proxy="xxxxxxxx")
  # you should set that: export no_proxy="127.0.0.1,10.0.2.15:5000"
  # finally restart docker
  sudo sertvice docker restart
 
  # check the registry
  sudo docker pull hello-world
  sudo docker tag hello-world 10.0.2.15:5000/hello-world
  sudo docker push 10.0.2.15:5000/hello-world
  sudo docker rmi 10.0.2.15:5000/hello-world
  sudo docker pull 10.0.2.15:5000/hello-world
  # over
```


