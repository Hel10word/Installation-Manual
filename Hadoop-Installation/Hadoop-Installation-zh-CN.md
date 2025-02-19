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
# 删除压缩包
rm -rf ./hadoop-3.3.2.tar.gz

# 创建 Hadoop 临时文件夹
mkdir -p /usr/local/extend/hadoop-3.3.2/temp/data/
```



#### 修改系统环境变量

-   修改环境变量，我当前修改的是用户环境变量，若要修改全局环境变量，请修改 `/etc/profile` 文件

```sh
# 编辑当前用户环境变量
# vi ~/.bashrc
# 将一下信息 追加到末尾 
######################   Hadoop    #####################
# HADOOP_HOME=/usr/local/hadoop/hadoop-3.3.2
# PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin


# 修改 用户 配置文件 ~/.bashrc
cat >> ~/.bashrc << EOF

######################   Hadoop    #####################
export HADOOP_HOME=/usr/local/hadoop/hadoop-3.3.2
export PATH=\$PATH:\$HADOOP_HOME/sbin:\$HADOOP_HOME/bin

EOF

source ~/.bashrc
```



#### 修改 core-setting.xml

```xml
// 修改 /usr/local/hadoop/hadoop-3.3.2/etc/hadoop/core-setting.xml 文件
// 在 configuration 标签内添加如下信息
// fs.defaultFS为NameNode的地址。
// hadoop.tmp.dir为hadoop临时目录的地址，默认情况下，NameNode和DataNode的数据文件都会存在这个目录下的对应子目录下

  <property>   
    <name>fs.defaultFS</name>   
    <value>hdfs://192.168.30.145:8020</value> 
  </property> 
  <property>   
    <name>hadoop.tmp.dir</name>   
    <value>/usr/local/extend/hadoop-3.3.2/temp/data/</value> 
  </property>

```



#### 修改 hdfs-site.xml

```xml
// 修改 /usr/local/hadoop/hadoop-3.3.2/etc/hadoop/core-setting.xml 文件
// 在 configuration 标签内添加如下信息



```











---

[官网介绍]:https://hadoop.apache.org/
[官方下载地址]:https://hadoop.apache.org/releases.html
[清华镜像源]:https://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/

