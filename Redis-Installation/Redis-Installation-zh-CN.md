# Redis



## 安装包准备



[官方下载地址][官方下载地址] [华为镜像源][华为镜像源]

[官网介绍][官网介绍]



## 简单安装

### Centos7 + Redis 6.2.6

#### 下载解压

```sh
# 创建目录
mkdir -p /usr/local/redis
cd /usr/local/redis
wget -c -O redis-6.2.6.tar.gz --no-check-certificate https://download.redis.io/releases/redis-6.2.6.tar.gz

# 解压文件
tar -vxzf redis-6.2.6.tar.gz -C ./
rm -f ./redis-6.2.6.tar.gz
cd redis-6.2.6

# 编译源文件
make
# 可以使用如下命令 测试 是都编译成功
# make test

# 在make成功以后，会在src目录下多出一些可执行文件：redis-server、redis-cli等等。
```



#### 修改配置文件

1.  修改 `redis.conf` 文件

```sh
cd /usr/local/redis/redis-6.2.6
# 创建模板配置 
mkdir 6379
# 创建常用启动文件
mkdir bin

# 复制常用命令到 bin 中
cp ./src/redis-server ./bin/
cp ./src/redis-cli ./bin/
cp ./src/redis-sentinel ./bin/

# 复制一份配置文件到模板中
cp ./redis.conf ./6379/6379.conf

# 创建一些可能会用到的目录
cd 6379
mkdir log run data

# 修改配置文件
vim 6379.conf

	# 75行   允许远程连接  注释该行
	# bind 127.0.0.1 -::1
	# 94行   redis3.2 后的版本新增的功能，目的是禁止公网访问redis cache，增强redis的安全性
	protected-mode no
	# 98行   设置监听端口
	port 6379
    # 257行  设置后台运行 
    daemonize yes
    # 289行  设置 PID 文件，防止系统自动清理
    pidfile /usr/local/redis/redis-6.2.6/6379/run/redis_6379.pid
    # 297行  设置日志等级
    loglevel debug
    # 302行  设置日志记录路径
    logfile /usr/local/redis/redis-6.2.6/6379/log/redis_6379.log
    # 454行  指定数据库写入的目录
    dir /usr/local/redis/redis-6.2.6/6379/data
    
```



#### 启动服务端

```sh
/usr/local/redis/redis-6.2.6/bin/redis-server /usr/local/redis/redis-6.2.6/6379/6379.conf
```

#### 启动客户端

```sh
/usr/local/redis/redis-6.2.6/bin/redis-cli
# 访问其他服务端
/usr/local/redis/redis-6.2.6/bin/redis-cli -h localhost -p 6379
```

#### 关闭服务

```sh
/usr/local/redis/redis-6.2.6/bin/redis-cli shutdown
```



接下来我们便安装好了 Redis

```sh
#####################################################  Redis 6.2.6
安装目录 			/usr/local/redis/redis-6.2.6/
默认端口号          6379
当前服务相关配置     /usr/local/redis/redis-6.2.6/6379/
启动服务端		   /usr/local/redis/redis-6.2.6/bin/redis-server /usr/local/redis/redis-6.2.6/6379/6379.conf
启动客户端		   /usr/local/redis/redis-6.2.6/bin/redis-cli
访问服务端          /usr/local/redis/redis-6.2.6/bin/redis-cli -h localhost -p 6379
关闭服务端          /usr/local/redis/redis-6.2.6/bin/redis-cli shutdown
```





## 其他

如果想使用图形化来访问并操作 Redis ，可以使用 [AnotherRedisDesktopManager][AnotherRedisDesktopManager] 



---

[官方下载地址]:https://redis.io/download
[华为镜像源]:https://repo.huaweicloud.com/redis/
[官网介绍]:https://redis.io/
[AnotherRedisDesktopManager]:https://github.com/qishibo/AnotherRedisDesktopManager/
