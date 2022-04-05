# hadoop 安装





## 配置各节点的免密登陆



## 配置 JDK 环境 



## 下载安装包



 https://mirrors.tuna.tsinghua.edu.cn/apache/hadoop/common/hadoop-3.3.1/hadoop-3.3.1.tar.gz





## 创建相应的安装目录



```sh
mkdir -p /usr/local/hadoop
cd /usr/local/hadoop
tar -vxzf /usr/local/download/hadoop/hadoop-3.3.1.tar.gz -C ./
```



## 修改环境变量

```sh
# 修改 用户 配置文件 ~/.bashrc
######################   Hadoop    #####################
HADOOP_HOME=/usr/local/hadoop/hadoop-3.3.1
PATH=$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$PATH
```



详细的安装步骤

https://codingnote.cc/zh-tw/p/279781/







如果是使用 root 用户安装 需要 

https://blog.csdn.net/UZDW_/article/details/107380367



需要修改 环境变量文件







# hive

安装镜像

https://mirrors.tuna.tsinghua.edu.cn/apache/hive/hive-3.1.2/



介绍

https://blog.csdn.net/qq_35440040/article/details/103198542

参考

http://dblab.xmu.edu.cn/blog/2440-2/

https://cloud.tencent.com/developer/article/1697496





win10 

https://codingnote.cc/p/251292/







# spark





安装 

https://cdmana.com/2021/02/20210219135918048g.htm





https://cloud.tencent.com/developer/article/1624245





启动集群与ODBC

https://blog.csdn.net/qq_21918145/article/details/89736272
