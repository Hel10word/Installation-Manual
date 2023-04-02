# PostgreSQL



## 安装包准备

[官网介绍][官网介绍]

[官方下载地址][官方下载地址]


## 简单安装

### Centos7 + PostgreSQL 13.6



#### 下载安装包进行解压 编译安装

```sh
# 创建相关的文件夹
mkdir -p /usr/local/pgsql/13.6/
# 创建数据存放目录
mkdir -p /usr/local/extend/pgsql13/data

cd /usr/local/pgsql
# 下载相关版本的 PostgreSQL ,由于官方提供的是 地址没有相关的认证 需要添加参数才能正常下载
wget -c --no-check-certificate -O postgresql-13.6.tar.gz https://ftp.postgresql.org/pub/source/v13.6/postgresql-13.6.tar.gz
# 也可以使用国内的下载地址
# wget -c --no-check-certificate -O postgresql-13.6.tar.gz https://mirrors.tuna.tsinghua.edu.cn/postgresql/source/v13.6/postgresql-13.6.tar.gz

# 下载完后 解压
tar -vxzf ./postgresql-13.6.tar.gz -C ./

# 安装编译所需的环境以及库
yum install -y cmake  gcc  gcc-c++ perl  readline-devel zlib   zlib-devel   tcl openssl ncurses-devel openldap
# gcc 			及相关 用于编译源代码
# make 			及相关 用来批量编译链接源代码
# readline 		及相关 执行命令后通过方向键获取命令
# zlib			及相关 用于数据压缩

# 进入解压的目录
cd /usr/local/pgsql/postgresql-13.6/
# 配置相关的参数，指定我们PgSQL的安装目录， 生成 Makefile 文件
./configure --prefix=/usr/local/pgsql/13.6/
# 编译安装  -j 8 可以依据CPU核心数，指定多个并行度加快编译速度
make -j 8 && make install
# 进入扩展目录 安装相关的工具集
cd ./contrib
make -j 8 && make install
# 至此我们的安装基本结束，接下来是相关数据的初始化
```

#### 添加 PgSQL 用户，并行初始化

由于的安全机制，默认情况下很多命令是禁止超级管理员来运行的，因此对于我们当前的 root 来说，安装会有很多不便之处，我们创建一个 postgres 用户来执行初始化等命令。

```sh
# 创建用户组
groupadd postgres
# 创建用户 并指定上面的组 默认是没有密码的
useradd -g postgres postgres
# 对 PgSQL 的安装目录授权
chown -R postgres:postgres /usr/local/pgsql/13.6/
# 对 PgSQL 的数据目录授权
chown -R postgres:postgres /usr/local/extend/pgsql13/data/


# 切换用户
su - postgres
# 进入我们的安装目录
cd /usr/local/pgsql/13.6/bin/
# 验证安装是否成功
./pg_ctl -V
# 如果出现 'pg_ctl (PostgreSQL) 13.6' 则证明安装成功


# 初始化
./pg_ctl initdb -D /usr/local/extend/pgsql13/data/
# 初始化成功会出现如下语句
# Success. You can now start the database server using:
#     /usr/local/pgsql/13.6/bin/pg_ctl -D /usr/local/extend/pgsql13/data -l logfile start

# 根据提示运行上述命令
/usr/local/pgsql/13.6/bin/pg_ctl -D /usr/local/extend/pgsql13/data -l logfile start
# 可知道我们的服务启动成功
# waiting for server to start.... done
# server started

# 退出 postgres 用户
exit
# 查看是否启动成功
netstat -nltp|grep 5432
# 将其添加到系统服务
cp /usr/local/pgsql/postgresql-13.6/contrib/start-scripts/linux /etc/init.d/pgsql13
cd /etc/init.d/
# 编辑该文件
vi pgsql13

# 一般情况下我们只需要修改 32~41 行的三个配置信息
	# 修改为我们的安装目录
	# prefix=/usr/local/pgsql/13.6
	# 修改为我们的数据初始化目录
	# PGDATA="/usr/local/extend/pgsql13/data"
	# 修改为我们创建的用户名
	# PGUSER=postgres
	
# 然后给该配置文件赋权
chmod +x pgsql13
# 将 pgsql13 注册到系统服务
chkconfig --add pgsql13
# 查看 pgsql13 服务是否生效 2、3、4、5 运行级别表示随系统启动而启动
chkconfig --list pgsql13

# 然后便可以使用 service pgsql13 stop/start/status 命令来 停止/启动/查看服务状况 
```

#### 修改相关配置

1.  修改允许远程 IP 链接，这儿的文件在我们 初始化 数据库的目录中。

```sh
vi /usr/local/extend/pgsql13/data/postgresql.conf

# 在 59 行添加如下配置
	# 表示允许任意 IP 访问
	listen_addresses = '*'
	# 允许的最大连接数
	max_connections = 100
```

2.  修改客户端授权配置文件，这儿的文件在我们 初始化 数据库的目录中。

```sh
vi /usr/local/extend/pgsql13/data/pg_hba.conf

# 在最后 98 行添加如下
	# 配置 所有网段 为 MD5 认证方式
	host    all             all             0.0.0.0/0               md5

# 修改完成后 重启服务
service pgsql13 restart
	
	
# 认证方法（authentication method）
# trust       无条件地允许联接，这个方法允许任何可以与PostgreSQL 数据库联接的用户以他们期望的任意 PostgreSQL 数据库用户身份进行联接，而不需要口令。
# reject      联接无条件拒绝，常用于从一个组中"过滤"某些主机。
# md5         要求客户端提供一个 MD5 加密的口令进行认证，这个方法是允许加密口令存储在pg_shadow里的唯一的一个方法。
# password    和"md5"一样，但是口令是以明文形式在网络上传递的，我们不应该在不安全的网络上使用这个方式。
# gss         使用GSSAPI认证用户，这只适用于 TCP/IP 连接。
# sspi        使用SSPI认证用户，这只适用于 Windows 连接。
# peer        获取客户端的操作系统的用户名并判断他是否匹配请求的数据库名，这只适用于本地连接。
# ldap        使用LDAP服务进行验证。
# radius      使用RADIUS服务进行验证。
# cert        使用SSL服务进行验证。
# pam         使用操作系统提供的可插入的认证模块服务 （Pluggable Authentication Modules）（PAM）来认证。
```

3.  配置相关环境变量以及修改密码

```sh
# 切换到之前创建的 postgres 用户
su postgres
# 设置环境变量
vi ~/.bashrc
# 添加如下配置
	#######################   PgSQL 13    #####################
	# PG_HOME=/usr/local/pgsql/13.6
	# PATH=$PATH:$PG_HOME/bin

# 刷新环境变量
source ~/.bashrc
# 使用 工具包 来链接 PgSQL
psql
# 修改 pstgres 的密码
alter user postgres with password '123456';
# 可以使用 \q 命令来退出
\q
```

接下来我们便安装好了 PgSQL 13.6

```sh
#####################################################  Postgresql 13.6
安装目录            /usr/local/pgsql/13.6
数据目录            /usr/local/extend/pgsql13/data
配置环境            postgres 用户环境变量 ~/.bashrc
启动服务            service pgsql13 start/status/stop
账户/密码           postgres postgres
```





## 其他

### 通过 SQL 语句，查询相关元数据信息

[Postgresql 系统库中的相关表][Postgresql 系统库中的相关表]

```sql
-- 获取 所有的 Catalog 信息   等同于 -l 命令
SELECT datname FROM pg_database;
-- 查看当前的 Catalog
select catalog_name from information_schema.information_schema_catalog_name 
where catalog_name not in ('information_schema','pg_catalog','pg_toast_temp_1','pg_temp_1','pg_toast');


-- 查看 当前 Catalog 下的所有 Schema 信息
select * from information_schema.schemata
-- Schema 
select catalog_name,schema_name from information_schema.schemata 
where catalog_name not in ('information_schema','pg_catalog','pg_toast_temp_1','pg_temp_1','pg_toast');


-- 查看 当前 Catalog 下的所有 Table 信息
select * from pg_tables;
-- Table 
select table_catalog,table_schema,table_name,table_type from information_schema.tables where table_catalog not in ('information_schema','pg_catalog','pg_toast_temp_1','pg_temp_1','pg_toast')


-- 查看当前 Catalog 下所有名为 testtable 的表信息，可以查看到不同 Schema 下同名的表
select table_catalog,table_schema,table_name,column_name,data_type,udt_name,ordinal_position,is_nullable,character_maximum_length,numeric_precision,numeric_scale,datetime_precision 
from information_schema.columns  
where  table_name in ('testtable') ORDER BY table_name,ordinal_position;

-- 查看指定 Schema 名下面所有的表
select table_catalog,table_schema,table_name,column_name,data_type,ordinal_position,is_nullable,numeric_precision,numeric_precision_radix,numeric_scale,character_set_name,collation_name,datetime_precision,character_maximum_length 
from information_schema.columns 
where table_schema = 'admin'
ORDER BY table_name,ordinal_position;

-- Column 指定表名 Schema 名
select table_catalog,table_schema,table_name,column_name,data_type,ordinal_position,is_nullable,numeric_precision,numeric_precision_radix,numeric_scale,character_set_name,collation_name,datetime_precision,character_maximum_length 
from information_schema.columns 
where table_catalog not in  ('information_schema','pg_catalog','pg_toast_temp_1','pg_temp_1','pg_toast')
and table_schema = 'admin'
and table_name = 'testtable' 
ORDER BY table_name,ordinal_position;

```







---

[官网介绍]:https://www.postgresql.org/
[官方下载地址]:https://www.postgresql.org/ftp/source/
[清华镜像下载]:https://mirrors.tuna.tsinghua.edu.cn/postgresql/
[Postgresql 系统库中的相关表]:https://www.postgresql.org/docs/14/information-schema.html

