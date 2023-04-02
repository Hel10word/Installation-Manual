# Java



## 安装包准备


[官网介绍][官网介绍]

[官方下载地址][官方下载地址]   [华为镜像][华为镜像]


## 简单安装

### Centos7 + Java 1.8

#### 删除系统已有的 Java

1. 查看已经安装的OpenJDK包：


```shell
rpm -qa | grep java
```

2. 如果有相关的包，需要通过 `yum -y remove` 命令来将以 `java`开头的安装包均卸载


```shell
yum -y remove java-1.7.0-openjdk-1.7.0.141-2.6.10.5.el7.x86_64
yum -y remove java-1.8.0-openjdk-1.8.0.131-11.b12.el7.x86_64
······
```

#### 下载解压

```sh
# 创建目录
mkdir /usr/local/java
cd /usr/local/java
# 下载安装包
wget -c -O jdk-8u171-linux-x64.tar.gz --no-check-certificate https://repo.huaweicloud.com/java/jdk/8u171-b11/jdk-8u171-linux-x64.tar.gz

# 解压文件
tar -zxvf ./jdk-8u171-linux-x64.tar.gz -C ./

# 删除源文件 
rm -f ./jdk-8u171-linux-x64.tar.gz
```



#### 配置环境变量

1.  修改环境变量，我当前修改的是用户环境变量，若要修改全局环境变量，请修改 `/etc/profile` 文件。

```sh
# 编辑当前用户环境变量
vi ~/.bashrc

# 将一下信息 追加到末尾 

######################   JAVA    #####################
export JAVA_HOME=/usr/local/java/jdk1.8.0_171
export CLASSPATH=$JAVA_HOME/lib/
export PATH=$PATH:$JAVA_HOME/bin

# 使用source 命令刷新环境变量
source ~/.bashrc
# 验证 Java 是否配置成功
java -version
```



## 在一台 Linux 上安装不同版本







---

[官网介绍]:https://www.oracle.com/java/

[官方下载地址]:https://www.oracle.com/java/technologies/downloads/

[华为镜像]:https://repo.huaweicloud.com/java/jdk/



