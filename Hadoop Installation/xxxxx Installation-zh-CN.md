# Hadoop



## 安装包准备

[官网介绍][官网介绍]

[官方下载地址][官方下载地址]

[清华镜像源][清华镜像源]


## 简单安装

### Centos7 + Hadoop 3.3.2



#### 下载安装包进行解压 编译安装

```sh
# 创建相关的文件夹
mkdir -p /usr/local/hadoop
cd /usr/local/hadoop
# 下载相关版本的 hadoop
wget -c -O hadoop-3.3.2.tar.gz --no-check-certificate https://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-3.3.2/hadoop-3.3.2.tar.gz
tar -vxzf ./hadoop-3.3.2.tar.gz -C ./

```



#### 修改环境变量以及

-   修改环境变量，我当前修改的是用户环境变量，若要修改全局环境变量，请修改 `/etc/profile` 文件

```sh
# 编辑当前用户环境变量
# vi ~/.bashrc
# 将一下信息 追加到末尾 
######################   EFAK-web 3.0.1    #####################
# export KE_HOME=/usr/local/kafka/efak/efak-web-3.0.1
# export PATH=$PATH:$KE_HOME/bin


cat >> ~/.bashrc << EOF

######################   EFAK-web 3.0.1    #####################
export KE_HOME=/usr/local/kafka/efak/efak-web-3.0.1
export PATH=\$PATH:\$KE_HOME/bin

EOF

source ~/.bashrc
```



接下来我们便安装好了 EFAK

```sh
#####################################################  EFAK 3.0.1
安装目录 			/usr/local/kafka/efak/efak-web-3.0.1
启动端口			8048
默认账号密码		   admin 123456
配置				 root 用户 环境变量  root/.bashrc
操作 EFAK			 ke.sh start\status\stop
```









---

[官网介绍]:https://hadoop.apache.org/
[官方下载地址]:https://hadoop.apache.org/releases.html
[清华镜像源]:https://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/

