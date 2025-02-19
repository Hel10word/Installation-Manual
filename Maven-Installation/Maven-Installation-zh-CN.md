# Maven



## 安装包准备



[官方下载地址][官方下载地址]  [华为镜像源][华为镜像源]

[官网介绍][官网介绍]

-   `apache-maven-3.8.4-bin.tar`

## 简单安装

### Centos7 + Maven 3.8.4

#### 下载解压

```sh
# 创建目录
mkdir -p /usr/local/Maven/Repository
cd /usr/local/Maven
wget https://repo.huaweicloud.com/apache/maven/maven-3/3.8.4/binaries/apache-maven-3.8.4-bin.tar.gz

# 解压文件
tar -vxzf apache-maven-3.8.4-bin.tar.gz -C ./
cd apache-maven-3.8.4

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# [root@192 Maven]# ll
# total 8836
# drwxr-xr-x. 6 root root      99 Nov 30 11:06 apache-maven-3.8.4
# -rw-r--r--. 1 root root 9046177 Nov 14 21:25 apache-maven-3.8.4-bin.tar.gz
# drwxr-xr-x. 2 root root       6 Nov 30 11:03 Repository
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
```



#### 修改配置文件

1.  修改 `settings.xml` 文件

```xml
# 修改相关的配置文件
vi ./conf/settings.xml

# 56 行添加 仓库地址
<localRepository>/usr/local/Maven/Repository</localRepository>
# 161 行添加相相关的镜像
    <!-- 阿里云 -->
    <mirror>
        <id>aliyunmaven</id>
        <mirrorOf>*</mirrorOf>
        <name>阿里云公共仓库</name>
        <url>https://maven.aliyun.com/repository/public</url>
    </mirror>
    
    <!-- 华为云 -->
    <mirror>
        <id>huaweicloud</id>
        <mirrorOf>*</mirrorOf>
        <name>华为云公共仓库</name>
        <url>https://repo.huaweicloud.com/repository/maven/</url>
	</mirror>
```



#### 配置环境变量

```sh
# 修改全局环境变量
vi /etc/profile
# 修改当前用户的环境变量
# vi ~/.bashrc

######################   MAVEN    #####################
export MAVEN_HOME=/usr/local/Maven/apache-maven-3.8.4
export PATH=$PATH:$MAVEN_HOME/bin

# 刷新环境变量
source /etc/profile
# source ~/.bashrc
```



#### 验证

-   查看 Maven 版本

    `mvn -version`

```shell
[root@192 Maven]# mvn -version
Apache Maven 3.8.4 (9b656c72d54e5bacbed989b64718c159fe39b537)
Maven home: /usr/local/Maven/apache-maven-3.8.4
Java version: 1.8.0_171, vendor: Oracle Corporation, runtime: /usr/local/java/jdk1.8.0_171/jre
Default locale: en_US, platform encoding: UTF-8
OS name: "linux", version: "3.10.0-1160.15.2.el7.x86_64", arch: "amd64", family: "unix"
```



## 在一台 Linux 上安装不同版本

仅需修改环境变量中的配置即可。







---

[官方下载地址]:https://maven.apache.org/download.cgi
[华为镜像源]:https://repo.huaweicloud.com/apache/maven/maven-3/
[官网介绍]:http://maven.apache.org/index.htmlhttps://dev.mysql.com/doc/refman/5.7/en/binary-installation.html



