# MySQL



## 安装包准备

安装包名 **mysql-VERSION-OS.tar.gz**  glibc 为通用版本（Generic） 

[官方下载地址][官方下载地址]   [华为镜像][华为镜像]   [清华镜像][清华镜像]

[官网 5.7 安装介绍][官网 5.7 安装介绍]

[官网 8.0 安装介绍][官网 8.0 安装介绍]

-   `mysql-5.7.35-linux-glibc2.12-x86_64.tar.gz`

## 安装前环境的准备

-   若在 Linux 上安装，请确保系统有 `libaio` 环境，参考 [官网环境介绍][官网环境介绍].

-   安装前请先清理系统之前⾃带的 `mariadb` ，参考 [安装mysql为什么卸载 mariadb][安装mysql为什么卸载 mariadb].

```sh
# 在 Centos 中查看系统自带的 mariadb 
rpm -qa|grep mariadb
# 使用命令将其卸载 e.g. 
# yum -y remove mariadb-libs-5.5.68-1.el7.x86_64
```



## 简单安装

### Centos7 + MySQL 5.7

-   创建一个 用户 来安装与使用MySQL，参考 [Create a mysql User and Group][Create a mysql User and Group]，下面的操作我为了简单直接用 **root** 用户安装.

我们先下载好所需要的安装文件，这儿我以 `mysql-5.7.35-linux-glibc2.12-x86_64.tar.gz` 为例。

```sh
# 创建安装目录
mkdir /usr/local/mysql
cd /usr/local/mysql
# 下载 安装包
wget https://repo.huaweicloud.com/mysql/Downloads/MySQL-5.7/mysql-5.7.35-linux-glibc2.12-x86_64.tar.gz
# 解压我们下载的 安装文件
tar -zvxf ./mysql-5.7.35-linux-glibc2.12-x86_64.tar.gz -C ./

# 如果 准备使用 mysql 用户来安装，需要给当前目录的文件添加 mysql 用户的执行权限。
# groupadd mysql
# useradd -g mysql mysql
# chown -R mysql:mysql ./


# 删除下载的文件 
rm -f ./mysql-5.7.35-linux-glibc2.12-x86_64.tar.gz
# 进入解压的目录
cd ./mysql-5.7.35-linux-glibc2.12-x86_64

```

创建 MySQL 启动配置文件，MySQL 在不同的平台默认会去加载配置文件的路径，当然在安装的时候，我们也可以指定加载路径，参考 [Option File Processing Order][Option File Processing Order].

当你并不知道当前机器的 MySQL 启动加载的配置文件在哪时，可以通过如下方式查看。

```shell
# 进入目录后 我们可以通过一下命令 查看 默认配置文件
./bin/mysqld --verbose --help | grep -A 1 'Default options'
# Default options are read from the following files in the given order:
# /etc/my.cnf /etc/mysql/my.cnf /usr/local/mysql/etc/my.cnf ~/.my.cnf


# 创建数据目录
mkdir -p /usr/local/expand/mysql57/data
# 创建临时 目录
mkdir -p /usr/local/expand/mysql57/temp
# 进入我们刚刚 解压目录 
cd /usr/local/mysql/mysql-5.7.35-linux-glibc2.12-x86_64
# 在当前目录下创建 配置文件 
touch my.cnf

# 填写以下信息
#######################################################################################
[mysql]
# 设置mysql客户端默认字符集
default-character-set                     = utf8

[mysqld]
port                                      = 3306
# 设置mysql的安装目录
basedir                                   = /usr/local/mysql/mysql-5.7.35-linux-glibc2.12-x86_64
# 设置mysql数据库的数据的存放目录
datadir                                   = /usr/local/expand/mysql57/data
tmpdir                                    = /usr/local/expand/mysql57/temp
socket                                    = /usr/local/expand/mysql57/mysql.sock
pid-file                                  = /usr/local/expand/mysql57/mysql.pid
user                                      = root
server-id                                 = 100
default-storage-engine                    = InnoDB

# INNODB
innodb_autoinc_lock_mode                  = 2
# innodb_buffer_pool_size                 = 1G
innodb_log_file_size                      = 100M
# innodb_log_buffer_size                  = 64M
# innodb_write_io_threads                 = 8
# innodb_read_io_threads                  = 8
innodb_flush_log_at_trx_commit            = 2
innodb_file_per_table                     = 1
innodb_io_capacity                        = 8000
innodb_flush_method                       = O_DIRECT

# MyISAM
key_buffer_size                           = 32M

# LOGGING
log-error                                 = /usr/local/expand/mysql57/mysql_error.log
slow_query_log                            = /usr/local/expand/mysql57/mysql_slow.log

# OTHER
# 禁用 DNS 反查
skip_name_resolve                         = 0
flush_time                                = 300
# 允许最大连接数
max_connections                           = 200
# 服务端使用的字符集默认为8比特编码的latin1字符集
character-set-server                      = utf8
# 修改安全文件权限 为不限制目录
secure_file_priv                          = ''
open_files_limit                          = 65535
tmp_table_size                            = 32M
max_heap_table_size                       = 32M
query_cache_type                          = 0
query_cache_size                          = 0


[client]
port                                      = 3306
socket                                    = /usr/local/expand/mysql57/mysql.sock
```

运行安装命令，指定配置文件路径，初始化数据库，[初始数据库携带的参数][初始数据库携带的参数]。

```sh
./bin/mysqld \
--defaults-file=/usr/local/mysql/mysql-5.7.35-linux-glibc2.12-x86_64/my.cnf \
--initialize \
--user=root \
--basedir=/usr/local/mysql/mysql-5.7.35-linux-glibc2.12-x86_64 \
--datadir=/usr/local/expand/mysql57/data

# 以安全模式启动 MySQL 服务，并登录修改我们的密码 
./bin/mysqld_safe \
--defaults-file=/usr/local/mysql/mysql-5.7.35-linux-glibc2.12-x86_64/my.cnf \
--user=root &

# 等待控制太输出 不变后 我们可以按回车退出，可以通过如下命令查看 MySQL 是否已经启动。
# ps -ef|grep mysql
# netstat -ntpl|grep 3306

# 我们现在准备登陆 MySQL 修改相依的配置
# 查看初始化的随机密码
cat /usr/local/expand/mysql57/mysql_error.log |grep root@localhost

# 登陆 MySQL 服务
./bin/mysql -uroot -p
# 如果这一步报错，多半是 Linux 系统 默认去 /tmp 目录下寻找对应的 Socket 链接文件
# 我们这儿创建软连接到该目录下
ln -s /usr/local/expand/mysql57/mysql.sock /tmp/mysql.sock
# 如果上一步报错 则使用下面的方法启动
# ./bin/mysql -u root -p -S /usr/local/expand/mysql57/mysql.sock

```

进入 MySQL 服务后，修改相应的开发配置。

```sql
-- 修改初始密码，我这儿是改为 root
SET PASSWORD FOR 'root'@'localhost' = PASSWORD('root');
-- mysql 5.7.6 版本后需要这样修改密码
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
-- 设置是否启用密码修改策略
SET GLOBAL validate_password_policy=0;
-- 设置密码长度
SET GLOBAL validate_password_length=1;
-- 禁用 用户密码过期功能
ALTER USER 'root'@'localhost' PASSWORD EXPIRE NEVER;
-- 设置远程登陆
grant all privileges on *.* to 'root'@'%' identified by 'root';
-- 刷新权限设置
flush privileges;
-- 退出
quit;
```

手动关闭 MySQL 服务

```sh
./bin/mysqladmin shutdown -uroot -p
```



复制启动脚本到Linux服务列表。

```sh
cp ./support-files/mysql.server /etc/init.d/mysql57
# 进入 资源目录 修改文件
cd /etc/init.d/
vi mysql57


#############################################################################
# 修改为实际安装的目录
basedir=/usr/local/mysql/mysql-5.7.35-linux-glibc2.12-x86_64
datadir=/usr/local/expand/mysql57/data


# 查看该脚本 可以发现默认是使用 mysqld_safe 来启动 MySQL。
# 由于我们是使用 root 用户安装的，需要在启动时候 指定用户，不指定就用默认的 mysql 用户
# 大约在脚本 266 行左右  $bindir/mysqld_safe 这儿添加 --user=root 参数
      $bindir/mysqld_safe --user=root --datadir="$datadir" --pid-file="$mysqld_pid_file_path" $other_args >/dev/null &

#############################################################################
# 给脚本添加控制权限
chmod +x mysql57
# 将 mysql57 服务注册到系统服务
chkconfig --add mysql57
# 查看 mysql57 服务是否生效 2、3、4、5 运行级别表示随系统启动而启动
chkconfig --list mysql57
```

服务的启动

```sh
service mysql57 start
```

修改环境变量，我当前修改的是用户环境变量，若要修改全局环境变量，请修改 `/etc/profile` 文件。

```sh
# 编辑当前用户环境变量
vi ~/.bashrc

# 将一下信息 追加到末尾 

    ######################   MySQL 5.7.35    #####################
    export PATH=$PATH:/usr/local/mysql/mysql-5.7.35-linux-glibc2.12-x86_64/bin

# 使用source 命令刷新环境变量
source ~/.bashrc
```



接下来我们便安装好了 MySQL 5.7

```sh
安装目录 			/usr/local/mysql/mysql-5.7.35-linux-glibc2.12-x86_64
数据目录 			/usr/local/expand/mysql57
配置环境 			root 用户环境变量 ~/.bashrc
启动服务 			service mysql57 start/status/stop
账户/密码 			root root
使用 socket 链接    mysql -u root -p root
使用 TCP 链接 		mysql -h 127.0.0.1 -uroot -proot
```





## 在一台 Linux 上安装不同版本











## 仅安装客户端

https://www.cnblogs.com/ipoke/p/11387724.html

```
yum -y install http://dev.mysql.com/get/mysql57-community-release-el7-10.noarch.rpm
```







---



[官方下载地址]:https://downloads.mysql.com/archives/community/
[华为镜像]:https://repo.huaweicloud.com/mysql/Downloads/

[清华镜像]:https://mirrors.tuna.tsinghua.edu.cn/mysql/downloads/
[官网 5.7 安装介绍]:https://dev.mysql.com/doc/refman/5.7/en/binary-installation.html

[官网 8.0 安装介绍]:https://dev.mysql.com/doc/refman/8.0/en/binary-installation.html
[官网环境介绍]:https://dev.mysql.com/doc/refman/8.0/en/binary-installation.html
[安装mysql为什么卸载 mariadb]:https://blog.csdn.net/u012026446/article/details/79397953
[Create a mysql User and Group]:https://dev.mysql.com/doc/refman/5.7/en/binary-installation.html#:~:text=Create%20a%20mysql%20User%20and%20Group

[Option File Processing Order]:https://dev.mysql.com/doc/refman/5.7/en/option-files.html

[初始化数据库目录]:https://dev.mysql.com/doc/refman/5.7/en/data-directory-initialization.html
[初始数据库携带的参数]:https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html

