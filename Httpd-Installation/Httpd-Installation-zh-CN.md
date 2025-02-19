# Httpd

[官网介绍][官网介绍]

## 安装包准备

[官方下载地址][官方下载地址]   [华为镜像源][华为镜像源]

手动安装 apache HTTP 服务，需要具备以下环境（APR、APR-Util、PCRE），因此我们便一起安装了。

[APR下载地址][APR下载地址] [PCRE下载地址][PCRE下载地址]

-   `httpd-2.4.52.tar.gz`
-   `apr-1.7.0.tar.gz`
-   `apr-util-1.6.1.tar.gz`
-   `pcre-8.45.tar.gz`

## 安装前环境的准备

1.  查看系统中是否有相关服务在运行，若有则停掉相关服务。

```sh
rpm -qa|grep httpd

# 使用命令将其卸载 e.g. 
# yum -y remove httpd-tools-2.4-40.el7.centos.x86_64
```

由于后续我们是通过手动安装，还需要确保我们有相关的编译环境

```sh
gcc -v
# 若没有 gcc 或 gcc-c++ 的环境，需要提前准备。
# yum install gcc-c++
```



## 简单安装

[安装参考][安装参考] 

在 Fedora/CentOS/Red Hat 等 Linux上快速安装可使用如下命令：

```sh
sudo yum install httpd
sudo systemctl enable httpd
sudo systemctl start httpd
```

在 Ubuntu/Debian 等Linux上快速安装可使用如下命令：

```sh
sudo apt install apache2
sudo service apache2 start
```

下面我来介绍**手动编译安装**

### Centos7 +Httpd


```sh
# 创建相关目录
mkdir -p /usr/local/apache2/httpd
mkdir -p /usr/local/apache2/apr
mkdir -p /usr/local/apache2/apr-util
mkdir -p /usr/local/apache2/pcre
cd /usr/local/download
# 下载相关安装包 
wget https://repo.huaweicloud.com/apache/httpd/httpd-2.4.52.tar.gz 
wget https://downloads.apache.org//apr/apr-1.7.0.tar.gz
wget https://downloads.apache.org//apr/apr-util-1.6.1.tar.gz
wget https://osdn.net/projects/sfnet_pcre/downloads/pcre/8.45/pcre-8.45.tar.gz

# 解压文件
tar -vxzf httpd-2.4.52.tar.gz -C ./
tar -vxzf apr-1.7.0.tar.gz -C ./
tar -vxzf apr-util-1.6.1.tar.gz -C ./
tar -vxzf pcre-8.45.tar.gz -C ./

# 将apr安装到我们创建的目录
cd /usr/local/download/apr-1.7.0
# 修改 configure 文件，将31279行的 RM='$RM' 修改为 RM='$RM -f'
./configure --prefix=/usr/local/apache2/apr
make
make install


# 将apr-util安装到我们创建的目录
cd /usr/local/download/apr-util-1.6.1
./configure --prefix=/usr/local/apache2/apr-util --with-apr=/usr/local/apache2/apr/bin/apr-1-config
make
make install
# 如果编译出现 如下错误，请安装如下环境。‘yum -y install expat-devel’ 然后重新编译。
# xml/apr_xml.c:35:19: fatal error: expat.h: No such file or directory
# include <expat.h>


# 将pcre安装到我们创建的目录
cd /usr/local/download/pcre-8.45
./configure --prefix=/usr/local/apache2/pcre --with-apr=/usr/local/apache2/apr/bin/apr-1-config
make
make install
# 编译的过程中可能会报这样的错误，但是对后续的内容不影响。
# libtool: warning: relinking 'libpcreposix.la'


# 开始安装为我们的Apache http服务
cd /usr/local/download/httpd-2.4.52
./configure --prefix=/usr/local/apache2/httpd --with-pcre=/usr/local/apache2/pcre --with-apr=/usr/local/apache2/apr --with-apr-util=/usr/local/apache2/apr-util
make
make install


# 当出现如下则说明安装成功了
# Installing CGIs
# mkdir /usr/local/apache2/httpd/cgi-bin
# Installing header files
# mkdir /usr/local/apache2/httpd/include
# Installing build system files
# mkdir /usr/local/apache2/httpd/build
# Installing man pages and online manual
# mkdir /usr/local/apache2/httpd/man
# mkdir /usr/local/apache2/httpd/man/man1
# mkdir /usr/local/apache2/httpd/man/man8
# mkdir /usr/local/apache2/httpd/manual
# make[1]: Leaving directory `/usr/local/download/httpd-2.4.52'
# [root@node1 httpd-2.4.52]# 


#  修改默认的配置文件
cd /usr/local/apache2/httpd/conf/
vim httpd.conf
# 52行可以设置监听的端口号
# 如果给你当前主机设置了主机名，那么请取消掉193行的注释


# 可以启动服务来验证一下
cd /usr/local/apache2/httpd/bin
# 下面便是 启动、关闭、重启 的命令
./apachectl start
./apachectl stop
./apachectl restart
```

最开始是准备使用PCRE2来安装的，但是在编译 Apache Httpd 的过程中有多处文件报错需要修改，过于繁琐，因此后来改用了 PCRE。



## 设置开机启动

```shell
# 复制相关文件到Linux服务列表
cp /usr/local/apache2/httpd/bin/apachectl /etc/rc.d/init.d/httpd
# 编辑脚本文件
vim /etc/rc.d/init.d/httpd
# 在头部添加{}内的两行信息
# {# chkconfig:345 85 15}
# {# description:Activates/Deactivates Apache Web Server}
# 第一行的三个数字分别表示 缺省启动的运行级，也就是哪些Linux等级可以启动httpd（3、4、5）、启动的优先级、关闭的优先级
# 当注册该服务时候，如果没有指定相关的参数，便会来注释中取值。
#--------------------------------------------------------------------
#      等级0表示：表示关机
#      等级1表示：单用户模式
#      等级2表示：无网络连接的多用户命令行模式
#      等级3表示：有网络连接的多用户命令行模式
#      等级4表示：不可用
#      等级5表示：带图形界面的多用户模式
#      等级6表示：重新启动
#--------------------------------------------------------------------

# 注册该服务
chkconfig --add httpd

# 查看配置是否生效
chkconfig --list httpd
```

到此 Apache httpd 服务便安装结束了。

可以通过如下命令来启动并关闭服务

```sh
service httpd start
service httpd stop
service httpd restart
```







## httpd.conf 配置文件

配置文件默认路径：**httpd/conf/httpd,conf**

-   检查配置文件语法是否正确

    ```sh
    httpd/bin/apachectl -t
    ```

-   重新加载配置文件

    ```sh
    httpd/bin/apachectl graceful
    ```

-   检查加载的模块

    ```sh
    httpd/bin/apachectl -M
    ```








-   DocumentRoot 网站更目录

```sh
# 修改这儿得路径，httpd 服务便会去加载该路径下的文件
DocumentRoot "/usr/local/apache2/httpd/htdocs"
```

-   RequireAll 请求权限相关

```xml
<RequireAll>
    <!-- 拒绝所有访问请求  这是默认设置 -->
    Require all denied
    
    <!-- 允许所有访问请求 -->
    Require all granted
    
    <!-- 只允许特定主机的访问请求 -->
    Require host google.com
    
    <!-- 只允许特定IP的访问请求 -->
    Require ip 192.120 192.168.100 192.168.1.1
    
    <!-- 允许所有访问请求，但拒绝来自特定IP或IP段的访问请求 -->
    Require all granted
    Require not ip 192.168.1.1
    Require not ip 192.120 192.168.100
</RequireAll>
```

-   AddType 将给定的文件扩展名映射到指定的内容类型

```sh
# 使 .php 后缀的文件可以执行 PHP
AddType application/x-httpd-php .php .phtml
AddType application/x-httpd-php-source .phps
```

-   DirectoryIndex 添加索引页面

```xml
<!-- 添加 index.php 为索引页 -->
<IfModule dir_module>
    DirectoryIndex index.html index.php
</IfModule>
```









---

[官网介绍]: https://httpd.apache.org/
[官方下载地址]:https://httpd.apache.org/download.cgi
[华为镜像源]: https://repo.huaweicloud.com/apache/httpd/
[APR下载地址]:https://apr.apache.org/download.cgi
[PCRE下载地址]:https://osdn.net/projects/sfnet_pcre/
[安装参考]:https://httpd.apache.org/docs/current/install.html



