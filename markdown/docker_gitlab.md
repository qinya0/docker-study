# gitlab in docker

## redis

```bash
    mkdir -p /home/qy/gitlab/redis
    docker run -d -v /home/qy/gitlab/redis:/var/lib/redis \
        --name qy-gitlab-redis  sameersbn/redis:latest
```

## PostgreSQL 

```bash
    mkdir -p /home/qy/gitlab/postgresql
    docker run -d -v /home/qy/gitlab/postgresql:/var/lib/postgresql \
        -e DB_NAME=gitlabhq_production -e DB_USER=gitlab -e DB_PASS=password  \
        -e DB_EXTENSION=pg_trgm \
        --name qy-gitlab-postgresql sameersbn/postgresql:9.6
```

## gitlab 

```bash
    mkdir -p /home/qy/gitlab/gitlab
    # 生成随机数，需要3个
    pwgen -Bsv1 64
    # 例： J33K3tn7kTw4JcRjcXjCHjzscHMgxdRFFCdJTTv7hwPxNfjhPnnr7cKFKK3fXbNM
    docker run -d -v /home/qy/gitlab/gitlab:/home/git/data \
        --link qy-gitlab-postgresql:postgresql --link qy-gitlab-redis:redisio \
        -p 10022:22 -p 10080:80 \
        -e GITLAB_HOST=10.0.2.15 -e GITLAB_PORT=10080 -e GITLAB_SSH_PORT=10022 \
        -e GITLAB_SECRETS_SECRET_KEY_BASE=J33K3tn7kTw4JcRjcXjCHjzscHMgxdRFFCdJTTv7hwPxNfjhPnnr7cKFKK3fXbNM \
        -e GITLAB_SECRETS_DB_KEY_BASE=zprVdxbrtRpccCqmpc9TfChdMdMXhT4TcxPnct3xbsC7T9TfrHd3gfRnHJMb7vdb \
        -e GITLAB_SECRETS_OTP_KEY_BASE=XjKFdJCM7JbcKrRrWWhkfg4cWfjjLPdmVTTLdgLL37xjjVPmXFFC3dMcjFh4p47J \
        --name qy-gitlab sameersbn/gitlab:10.0.0
```

## 查看

- 我用的Oralce VM VirtualBox，还需要在设置-网络中再映射一次端口

```html
    # 可以在浏览器中打开gitlab了，balabala
    http://127.0.0.1:10080
```

###  参考
- https://hub.docker.com/r/sameersbn/gitlab/
