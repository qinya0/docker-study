# jenkins in docker

- ubuntu:16.04
- docker 1.13.0

- jenkins镜像不建议使用tls版本
- images: jenkins/jenkins:2.60.2
- [jenkins插件](http://updates.jenkins-ci.org/download/plugins/)

```bash
  docker pull jenkins/jenkins:2.60.2
  # 建一个目录做挂载点
  mkdir -p /home/qy/jenkins/
  docker run -d -ti -p 10080:8080 -p 50000:50000 \
  -v /home/qy/jenkins:/home/paas \
  -v /var/run/docker.sock:/var/run/docker.sock -v /var/run/docker.sock \
  -v /etc/localtime:/etc/localtim:ro -v /etc/timezone:/etc/timezone:ro \
  --name qy-jenkins \
  -u root \
  jenkins/jenkins:2.60.2
  # 8080 端口是访问端口，50000是和子节点通信端口
  # 初始化密码
  cat /home/qy/jenkins/secrets/initialAdminPassword
  
  # 我自己用不需要安全控制等等，关闭这些。进入jenkins，配置-安全设置： 关闭启用安全，关闭防止垮站点请求，开启CLT
  
  # 插件，将需要的插件拷贝到目录：/home/qy/jenkins/plugins,然后进入容器，重启jenkins
  docker exec -ti qy-jenkins bash
  java -jar /var/jenkins_home/war/WEB-INF/jenkins-cli.jar -s http://localhost:8080 restart
```
