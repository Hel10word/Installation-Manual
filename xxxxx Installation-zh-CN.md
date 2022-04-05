# XXXX



## 安装包准备


[官网介绍][官网介绍]

[官方下载地址][官方下载地址]


## 简单安装

### Centos7 + XXXX 

#### 清理当前系统自带的 Python 环境

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
wget https://www.python.org/ftp/python/3.7.10/Python-3.7.10.tgz
tar -vxzf ./Python-3.7.11.tgz -vxzf -C ./
# 创建 当前版本的 Python 安装文件夹
mkdir ./python-37-11
# 进入解压文件夹
cd Python-3.7.11/
# 修改配置 指定安装位置
./configure --prefix=/usr/local/python/python-37-11
# 编译安装
make && make install
# 删除解压包等信息
cd ..
rm -rf Python-3.7.11

```



#### 修改环境变量以及

-   修改环境变量，我当前修改的是用户环境变量，若要修改全局环境变量，请修改 `/etc/profile` 文件

```sh
# 编辑当前用户环境变量
vi ~/.bashrc

# 将一下信息 追加到末尾 

    ######################   XXXXX    #####################
    # export PYTHON_HOME=/usr/local/python/python-37-11
    # export PATH=$PATH:$PYTHON_HOME/bin

# 使用source 命令刷新环境变量
source ~/.bashrc
# 验证 XXXX 是否配置成功
```



#### 自定义 XXX 路径

1.  创建文件夹

```sh
# 创建一个文件夹 存储 XXXX
mkdir -p /usr/local/python/PythonRepository/Python37/site-packages
```


2.  编辑 XXXX 相关的配置文件

```sh

```





## 在一台 Linux 上安装不同版本









---

[官网介绍]:

[官方下载地址]:

