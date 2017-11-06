# docker mysql

- run mysql in docker, data in machine

```bash
# ubuntu14.04
# docker 1.12.1
docker pull mysql:5

# a file to save data of mysql
mkdir -p /home/qy/mysql

# create container for mysql
docker run -d -p 13306:3306  -v /home/E_xvde3/mysql:/var/lib/mysql\
  -e MYSQL_ROOT_PASSWORD=passwd -e MYSQL_DATABASE=qytest \
  --name qy-mysql mysql:5
# 13306 is open port
# qytest is a test datatbase

# use mysql
# you can only install mysql-client
apt-get update
apt-get install -y mysql-client

# config mysql-client
sed -i 's/^bind-address/#bind-address/g' /etc/mysql/my.cnf
sed -i 's/^log_error/#log_error/g' /etc/mysql/my.cnf

# last you can use mysql
mysql -h 127.0.0.1 -u root -p qytest
```

- Dockerfiel for mysql-client

```Dockerfile
FROM ubuntu:14.04

# set ENV if you need
RUN apt-get update && apt-get install -y mysql-client \
    && apt-get -y autoremove && apt-get -y clean
```

- build the images for mysql-client

```bash
docker build -t ubuntu:mysql-client .
```

- run mysql in a container to connect a mysql-container

```bash
# run test container
docker run -d -ti --link qy-mysql:mysql \
  --name qy-mysql-client ubuntu:mysql-client /bin/bash

# use mysql in that test container
test_container_id=$(docker ps -a | grep qy-mysql-client | awk '{print $1}')
docker exec -ti $test_container_id bash

# run shell in test container
# get mysql's ip 
mysql_ip=$(env | grep MYSQL_PORT_3306_TCP_ADDR | awk -F'=' '{print $2}')

mysql -h $mysql_ip -u root -p qytest
```



