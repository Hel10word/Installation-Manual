# MemSQL
​	MemSQL 是前FaceBook 工程师创办的，号称是世界上最快的分布式关系型数据库，它通过将数据放置在内存中，并将 SQL 语句翻译为 C++ 来达到执行最优化。通过了解知道 [MemSQL 改名了][MemSQL 改名了]，改名后叫 **SingleStore DB**。

[官网介绍][官网介绍]


## 简单安装

### Centos7 + MemSQL + MemSQL-OPS

​	本教程采用的是 MemSQL-OPS 工具来安装的，根据官方介绍 [Memsql-OPS][Memsql-OPS]，该工具不支持安装 [SingleStore DB v7.5后的版本][SingleStore DB v7.5后的版本]，安装更高的版本推荐使用[SingleStore-Tools][SingleStore-Tools]。



#### 需要准备的安装文件

- `memsql-ops-6.0.7`  ：这是MemSQL的集群管理工具 [下载地址][memsql-ops-6.0.7.tar.gz] 
- `memsqlbin_amd64` ： 这是MemSQL数据库本体的二进制文件，下载后将其手动添加到Ops中进行安装。该地址会**默认拉去最新版本**，我当前下载的版本是 `7.3.15` 。 [下载地址][memsqlbin_amd64.tar.gz]

#### 下载相关文件

```sh
# 创建相关目录
mkdir /usr/local/memsql
cd /usr/local/memsql

# MemSQL Ops 存放相关的数据以及日志
mkdir memsql-ops-data

# MemSQL Ops 安装数据的存储目录
mkdir memsql-install

# 下载 OPS
wget http://download.memsql.com/memsql-ops-6.0.7/memsql-ops-6.0.7.tar.gz 

# 下载 DB
wget http://download.memsql.com/releases/latest/memsqlbin_amd64.tar.gz

# 解压 OPS 
tar -vzxf ./memsql-ops-6.0.7.tar.gz -C ./
```



#### 安装 MemSQL-OPS

```sh
# 进入目录
cd /usr/local/memsql/memsql-ops-6.0.7

# 安装  指定我们上一步创建的相关目录
./install.sh --ops-datadir /usr/local/memsql/memsql-ops-data --memsql-installs-dir /usr/local/memsql/memsql-install

# 接下来会启动 OPS 的 Web 管理界面 默认 端口是 9000
# 这儿会询问是否作为单机安装。 我们默认选择 N
```



#### 使用 OPS 安装 MemSQL

网上很多推荐，关闭网络链，迫使 Ops 的 Web 界面无法 在线安装 MemSQL，因为 Web 界面会先查看主机是否拥有 MemSQL 数据库，若没有会自动在线安装，其实也可以不断网，直接通过下面的命令来进行手动安装 MemSQL。若上一步安装 Ops 忘记选择 N，这一步也可以通过下面的命令来手动安装 MemSQL。

1.  安装 数据库 本体

```sh
# 进入 OPS 的安装目录
cd /usr/local/memsql/memsql-ops-6.0.7

# 安装我们下载的 DB 
memsql-ops file-add -t memsql /usr/local/memsql/memsqlbin_amd64.tar.gz
```

2.  如果是我们搭建的是多集群，需要在每个节点上部署 OPS—Agent 来管理相关的节点

```sh
# 使用如下命令安装 OPS-Agent ,这儿需要输入 SSH 登录的用户名与密码，并设置 Agent 的数据目录与 DB 的安装目录
memsql-ops agent-deploy -h 192.168.64.125-u root -p 123456 --ops-datadir /usr/local/memsql/memsql-ops-data --memsql-installs-dir /usr/local/memsql/memsql-install
```

3.  部署我们的 集群

```sh
# 安装主节点 Master节点
memsql-ops memsql-deploy -r master

# 部署从节点 Leaf节点
memsql-ops memsql-deploy -r leaf -P 3307

############  管理多节点机器
# 查看当前注册的 Agent
memsql-ops agent-list

# 如果需要在其他机器部署 从节点
# -a 需要指定 agent-list 中查询的 ID
# -p 为该节点 数据库 服务 启用的端口
# -r 指定该 数据节点 充当的 角色 (master、leaf)
memsql-ops memsql-deploy -a Afa8d10 -P 3307 -r leaf
```

4.  修改所有节点的密码，使用命令时还请 [注意 MemSQL 版本][注意 MemSQL 版本]

```sh
# 所有节点默认是没有密码的， 我们通过如下语句 将所有节点密码设置为 123456
memsql-ops memsql-list -q | xargs -n 1 memsql-ops memsql-update-root-password --no-confirmation -p 123456
```



#### 删除相关信息



1.  首先删除 MemSQL 下面所有的节点

```sh
# 删除全部节点
memsql-ops memsql-delete --all
# 删除单个节点
memsql-ops memsql-delete 08270BC
```

2.  然后删除 Ops 

```sh
memsql-ops uninstall
```

3.  然后可以手动的清理掉 相关的目录了

 {`/var/lib/memsql-ops`、`/usr/bin/memsql`、`/usr/bin/memsql-ops`、`/usr/local/memsql`}











---



[MemSQL 改名了]:https://www.singlestore.com/blog/revolution/


[官网介绍]:https://docs.singlestore.com/

[Memsql-OPS]:https://docs.singlestore.com/db/v7.3/en/user-and-cluster-administration/migrate-from-ops-to-tools/sudo.html?action=version-change

[SingleStore DB v7.5后的版本]:https://docs.singlestore.com/db/v7.3/en/introduction/faqs/singlestore-tools/can-i-still-use-memsql-ops-.html?action=version-change

[SingleStore-Tools]:https://docs.singlestore.com/db/v7.3/en/reference/singlestore-tools-reference/singlestore-tools-reference.html

[memsql-ops-6.0.7.tar.gz]:http://download.memsql.com/memsql-ops-6.0.7/memsql-ops-6.0.7.tar.gz

[memsqlbin_amd64.tar.gz]:http://download.memsql.com/releases/latest/memsqlbin_amd64.tar.gz
[注意 MemSQL 版本]:https://archived.docs.singlestore.com/v7.1/tools/memsql-ops/securing-memsql/#configuring-the-root-password



