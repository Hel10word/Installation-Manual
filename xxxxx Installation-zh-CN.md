# XXXX



## 安装包准备


[官网介绍][官网介绍]

[官方下载地址][官方下载地址]


## 简单安装

### Centos7 + XXXX 

#### 清理当前系统已有的 xxxxx 环境

删除系统自带的 Python 以及相关的依赖包。

-   rpm -qa|grep python|xargs rpm -ev --allmatches --nodeps

删除所有的 残余文件。

-   whereis python |xargs rm -frv



#### 下载安装包进行解压 编译安装

```sh
# 创建相关的文件夹
mkdir -p /usr/local/python
cd /usr/local/python
# 下载相关版本的 XXXX
wget -c -O Python-3.7.10.tgz --no-check-certificate https://www.python.org/ftp/python/3.7.10/Python-3.7.10.tgz
tar -vxzf ./Python-3.7.11.tgz -C ./
# 创建 当前版本的 Python 安装文件夹
mkdir ./python-37-11
# 进入解压文件夹
cd Python-3.7.11/
# 修改配置 指定安装位置
./configure --prefix=/usr/local/python/python-37-11
# 编译安装
make -j 8 && make install
# 删除解压包等信息
cd ..
rm -rf Python-3.7.11

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

[官网介绍]:

[官方下载地址]:

