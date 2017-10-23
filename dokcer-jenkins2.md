# jenkins2 in docker

- 建议不要用tls，版本会改变
- images: jenkins/jenkins2:2.60.2


```bash
  docker pull jenkins/jenkins2:2.60.2
  # 建一个目录做挂载点
  mkdir -p /home/qy/jenkins2/
  docker run -d -ti -p 10080:8080 -p 50000:50000 \
  -v /home/qy/jenkins2:/home/paas \
  -v /var/run/docker.sock:/var/run/docker.sock -v /var/run/docker.sock \
  -v /etc/localtime:/etc/localtim:ro -v /etc/timezone:/etc/timezone:ro \
  --name qy-jenkins2 \
  -u root \
  jenkins/jenkins2:2.60.2
  # 8080 端口是访问端口，50000是和子节点通信端口
  # 初始化密码
  cat /home/qy/jenkins2/secrets/initialAdminPassword
  
  # 我自己用不需要安全控制等等，关闭这些。进入jenkins，配置-安全设置： 关闭启用安全，关闭防止垮站点请求，开启CLT
  
  # 插件，将需要的插件拷贝到目录：/home/qy/jenkins2/plugins,然后进入容器，重启jenkins
  docker exec -ti qy-jenkins2 bash
  java -jar /var/jenkins_home/war/WEB-INF/jenkins-cli.jar -s http://localhost:8080 restart
```
