# ftp
```bashmkdir -p /home/E_xvde1/ftp/cd /home/E_xvde1/ftp/mkdir log data pw# start ftp serverdocker run -d -ti --restart always \-p 21:21 -p 30000-30009:30000-30009 \-v /home/E_xvde1/ftp/log/:/var/log \-v /home/E_xvde1/ftp/data/:/home/ftpusers/ \-v /home/E_xvde1/ftp/pw:/etc/pure-ftpd/passwd \     # 可以直接弄/etc/pure-ftpd 整个配置文件-e PUBLICHOST=localhost \-e "ADDED_FLAGS=-d -d" stilliard/pure-ftpd:hardened
# 在容器中运行pure-pw useradd qy \ # 添加用户-f /etc/pure-ftpd/passwd/pureftpd.passwd \ # 密码文件-m -u ftpuser -d /home/ftpusers/qy  # 目录    # 要求输入密码
    # 用户：可以用这个容器创建一些用户和密码         docker run -d -ti --rm -v /home/pw:/etc/pure-ftpd/passwd /bin/bash            #!/bin/bash            pure-pw useradd qy -f /etc/pure-ftpd/passwd/pureftpd.passwd -m -u ftpuser -d /home/ftpusers/qy    # 然后拷贝出来
# 使用ftp命令登陆ftp-open-get-put-ls-pwd
# 使用curl# 下载curl ftp://10.186.61.52/qy123/a.sh -u qy:Huawei@123 -o a.sh#下载的是文件的内容， -o保存,不保存会打印出来 # 上传curl ftp://10.186.61.52/qy123/ -u qy:Huawei@123 -T b.sh# 上传会有名字```
---- 配置
```bash# configClientCharset=gbk   #必设，防止Windows登录出现中文乱码 DontResolve=yes     #不解析域名，可以节省登录时间 BrokenClientsCompatibility=yes #兼容IE等非标准FTP client ChrootEveryone=yes  #把所有用户限制在其homedir下 KeepAllFiles=yes    #禁止用户删除文件，TrustedGID组中的除外 TrustedGID=1001     #管理员组ftpadmins的GID，允许管理员删除文件 CreateHomeDir=yes   #当虚拟用户第一次登录时，自动创建homedir MaxClientsPerIP=2   #每个IP限制2个连接 MaxClientsNumber=20 #最大并发连接数，默认值是50 MaxDiskUsage=90     #分区已使用空间超过90%时不再接受上传 NoAnonymous=no      #允许匿名登录 Bind=,8821          #改变端口号  # 每次修改服务器设置后都需要重新启动服务
 # 在Debian/Ubuntu下的wrapper比较怪， # 是在/etc/pure-ftpd/conf下以设置项作为文件名。 # 该项的设置值作为文件的内容，如需要设置ClientCharset=gbk，就建立一个名为“ClientCharset”的文件，内容为“GBK”.```
---```bashsudo groupadd ftpadmins  密码组sudo groupadd ftpusers  匿名组sudo useradd -g ftpadmins -d /dev/null -s /bin/false ftpadmin # -s 是shellsudo useradd -g ftpadmins -d /dev/null -s /bin/false ftpuser sudo useradd -g ftpusers -d /var/ftp/public -s /bin/false ftp sudo mkdir /var/ftp sudo mkdir /var/ftp/public sudo mkdir /var/ftp/public/incoming sudo mkdir /var/ftp/users sudo chown -R ftpadmin:ftpadmins /var/ftp sudo chmod -R 755 /var/ftp sudo chmod 777 /var/ftp/public/incoming sudo chmod 775 /var/ftp/users 
 # 添加到ftp数据库中sudo pure-pw useradd admin -u ftpadmin -d /var/ftp sudo pure-pw useradd test1 -u ftpuser -d /var/ftp/user/test1 sudo pure-pw useradd test2 -u ftpuser -d /var/ftp/user/test2   # 更新ftp数据库，每次修改用户后需要设置，不用重启（-m参数会自动刷新）pure-pw mkdb 
 # 设置puredb数据库（没试过）cd /etc/pure-ftpd/auth sudo ln -s ../conf/PureDB 60puredb 
```
