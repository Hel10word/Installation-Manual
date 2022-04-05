



[官方下载地址][官方下载地址]   [华为镜像][华为镜像]   [清华镜像][清华镜像]

[官方参考文档][官方参考文档]



## 使用 yum 命令安装：


```shell
cd /usr/local/download
wget https://downloads.mysql.com/archives/get/p/43/file/mysql-shell-8.0.25-1.el7.x86_64.rpm
yum install mysql-shell-8.0.25-1.el7.x86_64.rpm 
# 安装完成后 查看是否安装成功 
mysqlsh --version
```



## 下载源码 解压 安装：

```shell
cd /usr/local/download
wget https://downloads.mysql.com/archives/get/p/43/file/mysql-shell-8.0.27-linux-glibc2.12-x86-64bit.tar.gz 
mkdir -p /usr/local/mysql-shell
cd /usr/local/mysql-shell
tar -vxzf ../download/mysql-shell-8.0.27-linux-glibc2.12-x86-64bit.tar.gz -C ./
cd mysql-shell-8.0.27-linux-glibc2.12-x86-64bit/
```

### 解压成功后 配置环境变量

我这儿配置的是用户环境变量

```sh
# 编辑
vi ~/.bashrc

# 将一下环境变量信息 追加在末尾

######################   MySQL-SHell    #####################
export MYSQL_SHELL=/usr/local/mysqlsh/mysql-shell-8.0.27-linux-glibc2.12-x86-64bit
export PATH=$PATH:$MYSQL_SHELL/bin



# 使用 source 命令 刷新环境变量
source ~/.bashrc

# 测试 mysqlsh 环境是否配置成功
```





---

[官方下载地址]:https://downloads.mysql.com/archives/shell/
[华为镜像]:https://repo.huaweicloud.com/mysql/Downloads/
[清华镜像]:https://mirrors.tuna.tsinghua.edu.cn/mysql/downloads/
[官方参考文档]:https://dev.mysql.com/doc/mysql-shell/8.0/en/
