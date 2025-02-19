# PHP 8



## 安装包准备



[官方下载地址][官方下载地址]  

[官网介绍][官网介绍]

-   `php-8.1.1.tar.gz`

## 编译安装

### Centos7 + **PHP 8**

```sh
# 创建目录
mkdir -p /usr/local/php/php-8.1.1
cd /usr/local/download
wget https://www.php.net/distributions/php-8.1.1.tar.gz

# 解压文件
tar -vxzf php-8.1.1.tar.gz -C ./
cd /usr/local/download/php-8.1.1/

# 这一步会提示缺少的环境，可以通过yum进行下载， e.g. : yum install libxml2-devel sqlite-devel
./configure --prefix=/usr/local/php/php-8.1.1
make
make install

# 将 php.ini 文件拷贝一份
cd /usr/local/download/php-8.1.1/
cp php.ini-development /usr/local/php/php-8.1.1/lib/php.ini
```



#### 配置环境变量

```sh
vim /etc/profile
# 在下面添加如下信息，如果仅修改当前用户的环境变量，请使用 vim ~/.bashrc

######################   PHP 8.1    #####################
export PHP_HOME=/usr/local/php/php-8.1.1
export PATH=$PATH:$PHP_HOME/bin


# 最后使用 source 命令刷新我们的环境变量
source /etc/profile

# 验证，如果能输出版本信息，那么我们便大功告成了。
php-v
```





## 相关配置文件设置

默认位置：phphome/lib/php.ini

也可以使用该方法查看路径： **php -r "phpinfo();"|grep 'php.ini'** 或 **php --ini**





## 模块安装

可以使用如下命令查看PHP安装的模块：**php -m**

除了编译的时一起安装相关模块，还能独立安装模块。

1.  基于系统安装

    如果PHP是通过 apt 或者 yum 命令安装的，则扩展也可以通过 apt 或者 yum 安装

    debian/ubuntu等系统apt安装PHP扩展方法（非root用户需要加sudo命令）

2.  使用 PECL 安装

    -   使用 **pecl install** 命令安装扩展：pecl install memcached
    -   然后配置 php.ini ，在配置文件中添加 extension=memcached.so

3.  **源码编译安装**，适合安装 PHP 自带的扩展。

需要通过 **php -v** 查看当前的 PHP 版本，然后去 [官方下载地址][官方下载地址] 下载相应版本的源码包。

解压源码包后，进入 ext 目录。

```sh
# 可以通过 ll 查看有哪些拓展可以安装，当前在解压后的 PHP 包的 ext 目录下。
ll
# 进入我们需要额外安装的 ftp 模块
cd ftp
# 使用 php 自带的 phpize 脚本，在当前扩展生成可执行文件 configure
phpize
# [root@node1 ftp]# phpize
# Configuring for:
# PHP Api Version:         20210902
# Zend Module Api No:      20210902
# Zend Extension Api No:   420210902
# [root@node1 ftp]#

# 编译安装该模块
./configure --with-php-config=/usr/local/php/php-8.1.1/bin/php-config
make
make install
# Installing shared extensions:     /usr/local/php/php-8.1.1/lib/php/extensions/no-debug-non-zts-20210902/

# 配置 ini 文件，在 php.ini 文件中添加 extension=ftp.so
vim /usr/local/php/php-8.1.1/lib/php.ini
```



4.   使用 phpize 安装

如果需要安装的扩展 PHP 源码目录中没有，那么需要在这儿搜索下载 [pecl扩展下载][pecl扩展下载]

下载相关的扩展并解压进入后，与第三步一样，使用 phpize 命令生成相应文件，并编译安装，然后更新 ini 文件。







---

[官方下载地址]:https://www.php.net/releases/
[官网介绍]: https://www.php.net/
[pecl扩展下载]:https://pecl.php.net/

