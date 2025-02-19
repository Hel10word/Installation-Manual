# Docker



## 安装包准备

[官网介绍][官网介绍]

[官方下载地址][官方下载地址]


## 简单安装

### Centos7 + Docker

#### 清理当前系统已有的 Docker 环境

```shell
sudo yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine
```



#### 下载安装包进行解压 编译安装

```sh
# 创建相关的文件夹
mkdir -p /usr/local/docker
cd /usr/local/docker

# 下载相关版本的 Docker
wget -c -o docker-20.10.9.tgz --no-check-certificate https://download.docker.com/linux/static/stable/x86_64/docker-20.10.9.tgz

# 解压我们的安装包
tar -vxzf ./docker-20.10.9.tgz -C ./

# 给解压包重新命名
mv ./docker ./docker-20-10

# 删除下载文件
rm -f ./docker-20.10.9.tgz
```



#### 修改环境变量以及

-   修改环境变量，我当前修改的是用户环境变量，若要修改全局环境变量，请修改 `/etc/profile` 文件

```sh
# 编辑当前用户环境变量
vi ~/.bashrc

# 将一下信息 追加到末尾 

    ######################   Docker 20.10.9    #####################
    export DOCKER_HOME=/usr/local/docker/docker-20-10
    export PATH=$PATH:$DOCKER_HOME

# 使用 source 命令刷新环境变量
source ~/.bashrc
# 验证 Docker 是否配置成功
docker -v
```



#### 注册 Docker 服务与开机启动

1.  创建 Docker 服务配置文件

```sh
# 给我们当前安装的 Docker 创建一个服务配置文件
vi /etc/systemd/system/docker2010.service

# 将一下内容写入 并保存退出
```


2.  编辑 XXXX 相关的配置文件

```sh

```





## 在一台 Linux 上安装不同版本









---

[官网介绍]:https://download.docker.com/linux/static/stable/x86_64/
[官方下载地址]:https://download.docker.com/linux/static/stable/x86_64/

