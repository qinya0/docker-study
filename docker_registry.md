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
 
  # check the config
  sudo docker pull hello-world
  sudo docker tag hello-world 10.0.2.15:5000/hello-world
  sudo docker push 10.0.2.15:5000/hello-world
  sudo docker rmi 10.0.2.15:5000/hello-world
  sudo docker pull 10.0.2.15:5000/hello-world

```

## search images in registry

```bash
  # search all imagers
  curl -X GET http://10.0.2.15:5000/v2/_catalog
  # search all tags of image
  curl -X GET http://10.0.2.15:5000/v2/hello-world/tags/list

```

## use passwd login registry

```
  # a file 
  mkdir -p /home/qy/registry
  cd /home/qy/registry
  # create a passwd 
  mkdir /home/qy/registry/auth
  docker run --rm --entrypoint htpasswd registry:2 -Bbn qy-username qy-passwd > auth/htpasswd
  ...... more passwd
  # create container 
  docker run -d -p 5001:5000 --restart always \
    -e REGISTRY_STORAGE_REDIRECT_DISABLE=true -e REGISTRY_AUTH=htpasswd \
    -e REGISTRY_AUTH_HTPASSWD_REALM="Registry Realm" \
    -e REGISTRY_AUTH_HTPASSWD_PATH=/var/lib/registry/auth/htpasswd \ 
    -v /home/qy/registry/:/var/lib/registry  \ 
    --name qy-registry2 registry:2
    
  # add registry-url to docker's config
  # vim /etc/default/docker: balabala
  service docker restart
  # you can use uaer and passwd to login registry
  docker login localhost:50001
  docker push localhost:5001/hello-world
```

