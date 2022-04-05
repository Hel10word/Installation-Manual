# Python



## 安装包准备


[官网介绍][官网介绍]

[官方下载地址][官方下载地址]

[华为镜像下载地址][华为镜像下载地址]


## 简单安装

### Centos7 + Python 

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
# 下载相关版本的 Python
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



# 更多安装配置信息
#./configure --prefix=/usr/local/python/python-37-11 --enable-optimizations --with-ssl
# --prefix :指定安装的路径,不指定的话,安装过程中可能软件所需要的文件复制到其他不同目录,删除软件很不方便,复制软件也不方便。
# --enable-optimizations :可以提高python10%-20%代码运行速度。
# --with-ssl :为了安装pip需要用到ssl。
```



#### 修改环境变量以及

-   修改环境变量，我当前修改的是用户环境变量，若要修改全局环境变量，请修改 `/etc/profile` 文件

```sh
# 编辑当前用户环境变量
vi ~/.bashrc

# 将一下信息 追加到末尾 

    ######################   Python    #####################
    PYTHON_HOME=/usr/local/python/python-37-11
    export PATH=$PATH:$PYTHON_HOME/bin

# 使用source 命令刷新环境变量
source ~/.bashrc
# 验证 Python 是否配置成功
python3 --version
# 验证 pip 是否安装成功
pip --version
```



#### 自定义 pip install 安装路径

1.  创建文件夹

```sh
# 创建一个文件夹 存储 pip install 的包
mkdir -p /usr/local/python/PythonRepository/Python37/site-packages
```



2.  编辑 Python 相关的配置文件

```sh
# 编辑 python 加载的配置文件信息
vi /usr/local/python/python-37-11/lib/python3.7/site.py
# 修改 86、87 行
# Python 默认会去该目录 加载 库文件。
USER_SITE = "/usr/local/python/PythonRepository/Python37/site-packages"
# 初始化中 getuserbase() 函数获取的目录
USER_BASE = "/usr/local/python/PythonRepository"

# 退出后，使用 命令查看修改是否应用上，可以看到输出的信息已被更改
python3 -m site
```


3.  编辑 pip 相关配置文件

```sh
# 可以使用如下命令 设置 pip 下载镜像的源
pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
# 也可以通过配置文件的方式来设置
vi ~/.config/pip/pip.conf

# 输入一下信息， # 为注释信息，不需要输入

# 定义为全局配置
[global]
# 配置下载源路径
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
# 设置下载的网络等待时间
timeout = 6000
# 设置 https 信任域名
trusted-host = pypi.tuna.tsinghua.edu.cn
# 是否每次检查 pip 版本
disable-pip-version-check = true
# 指定 pip install 文件的路径
target=/usr/local/python/PythonRepository/Python37/site-packages
```

接下来便配置了 pip install 的默认安装路径。



## 在一台 Linux 上安装不同版本

在一台电脑上安装不同的版本的python，只需要下载不同版本的python包，然后重新配置一遍环境变量，以及需改相应的配置文件即可。







---

[官网介绍]:https://www.python.org/

[官方下载地址]:https://www.python.org/downloads/

[华为镜像下载地址]:https://repo.huaweicloud.com/python/

