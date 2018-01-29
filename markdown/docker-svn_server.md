# svn-server
```bash # svn-server
 # 下载镜像
docker pull krisdavison/svn-server:v2.0  
 # 生成文件夹
mkdir -p svn/data 
 # 启动容器 
 # 8081 用来查看服务器（apache），3690 是svn通信端口
docker run -d -ti -p 8081:80  -p 3690:3690 \
-v /home/F_xvdf1/svn/data:/home/svn \
--name qy-test-svn \
-v /etc/localtime:/etc/localtime:ro -v \
etc/timezone:/etc/timezone:ro \
krisdavison/svn-server:v2.0 /startup.sh 
 # 页面查看 : user/password。这个密码是固定的，只能查看
http://ip:8081/svn  
 # 创建库： 注意是/home/svn/FILE_NAME
docker exec -d -ti qy-test-svn /usr/bin/svnadmin create /home/svn/test1    
   # QYRepository is my repository'name
 # 设置，配置文件在下面详解 
 # configure svn repository 
cd svn/QYRepository/conf # do some configure
 # 启动svn服务， 启动一次就好了
docker exec -d -ti qy-test-svn /usr/bin/svnserve -d -r /home/svn/

 # checkout in other machinetest: 
svn checkout svn://100.109.192.106/QYRepository
 # configure conf目录中需要3个文件    
  - svnserve.conf: 总配置文件        
    anon-access  = read # 非鉴权用户只读        
    auth-access = write # 认证用户有写权限        
    password-db = passwd # 密码配置文件（配置这个：passwd文件才生效）        
    authz-db = authz  # 权限认证文件 （配置这个：authz文件才生效）        
    # realm = test 认证域（类似登录时的提示）        
    以上配置都是缺省值    
  - passwd： 密码(需要conf文件中设置才行) 是用时读        
    admin=admin # 用户=密码 (明文)        
    paas=Huawei@123         
    root=huawei123        
    qy=Huawei@123     
  - authz： 组和权限 （同上）       
    [groups]        
    g_write=admin,paas,qy        
    g_read=paas        
    [QYRepository:/] # 范围： '', 'r', 'rw'        
    @g_write=rw        
    @g_read=r        
    *=r # * 代表任何用户，设置这个可以不用用户密码直接下载    
  - hooks-env.tmpl 文件没用到
```
- 使用
```bash 
 # 需要svn
which svn || apt-get install subversion
 # 下载 paas/Huawei@123 
 # url=svn://100.109.192.106/QYRepository  
 # path是本地地址  # 下载匿名库不需要用户密码
mkdir svn && cd svnsvn checkout url --username=username--password=password path 
 # 命令
svn status (st) # 查看状态    
    ？ 不在svn控制    
    M  内容被修改    
    C  发生冲突    
    A  加入缓存区    
    K  被锁定    
svn st -v # 查看文件(夹)的最后一个修改人
svn update (up) # 从远程库同步    
svn update -r 100 test.m # 将test.m文件还原到版本100    
  如果update test.m失败，需要解决冲突，清理svn resolvd,再commit
svn add file/path # 添加（缓存区）
svn commit -m "" (ci) # 提交
svn delete -m "" (del rm) # 删除文件    相当于 svn delete test.m && svn commit -m ""
svn log [path] # 显示文件的所有修改记录    
svn info 显示文件的详细信息
svn diff -r m:n [path] (di) # 对版本m和版本n比较差异
svn merge -r m:n path # 将2个版本的差异河滨到当前文件
svn lock [path] # 对一个文件进行锁定    
svn unlock # 解除一个文件的锁定    
  # 锁定：一个用户在一个工作副本中锁定了一个文件，    
    那么只有这个用户在这个工作副本才能解除锁定。    
    其他任何用户任何副本都不能（包括这个用户）    
    如果副本丢失，可以强制获取锁
 # 不常用
svn list # 查看目录
svn switch  url [path]  # 将工作副本映射到新的URL    
svn switch --relocate FROM TO [PATH] # 
```
