# Kafka



## 安装包准备

[官网介绍][官网介绍]

[官方下载地址][官方下载地址] [阿里云镜像地址][阿里云镜像地址]

## 简单安装



### Centos7 + Kafka 3.3.1 (单节点)

#### 下载安装包进行解压 安装

```sh
# 创建相关的文件夹
mkdir -p /usr/local/kafka
cd /usr/local/kafka
# 下载相关版本的 XXXX
wget -c -O kafka_2.12-3.3.1.tgz --no-check-certificate https://mirrors.aliyun.com/apache/kafka/3.3.1/kafka_2.12-3.3.1.tgz
tar -vxzf ./kafka_2.12-3.3.1.tgz -C ./
rm -f ./kafka_2.12-3.3.1.tgz
```



#### 进行相关配置

1.  配置 Zookeeper 单节点 (Kafka 自带,无需重新下载)

```sh
# 进入 kafka 安装目录
cd /usr/local/kafka/kafka_2.12-3.3.1
# 创建 Zookeeper 相关目录
mkdir -p ./zk/data ./zk/logs
# 备份相应配置 并进行修改
cd config/
mv ./zookeeper.properties ./zookeeper.properties.bak

cat > ./zookeeper.properties <<  EOF
tickTime=2000
dataDir=/usr/local/kafka/kafka_2.12-3.3.1/zk/data
dataLogDir=/usr/local/kafka/kafka_2.12-3.3.1/zk/logs
clientPort=2181
EOF
```

2.  配置 Kafka 单节点

```sh
cd /usr/local/kafka/kafka_2.12-3.3.1
# 创建日志存放目录
mkdir logs
# 备份配置并进行修改
cd config/
mv server.properties server.properties.bak

cat > ./server.properties << EOF
broker.id = 1
listeners=PLAINTEXT://192.168.30.145:9092
num.network.threads=3
socket.send.buffer.bytes=102400
socket.receive.buffer.bytes=102400
socket.request.max.bytes=104857600
log.dirs=/usr/local/kafka/kafka_2.12-3.3.1/logs
num.partitions=1
num.recovery.threads.per.data.dir=1
offsets.topic.replication.factor=1
transaction.state.log.replication.factor=1
transaction.state.log.min.isr=1
log.retention.hours=168
log.segment.bytes=1073741824
log.retention.check.interval.ms=300000
zookeeper.connect=192.168.30.145:2181
zookeeper.connection.timeout.ms=6000
EOF

```



#### 启动停止

需要先启动 Zookeeper 再启动 kafka

```sh
# 启动 Zookeeper
/usr/local/kafka/kafka_2.12-3.3.1/bin/zookeeper-server-start.sh -daemon /usr/local/kafka/kafka_2.12-3.3.1/config/zookeeper.properties

# 启动 Kafka
/usr/local/kafka/kafka_2.12-3.3.1/bin/kafka-server-start.sh -daemon /usr/local/kafka/kafka_2.12-3.3.1/config/server.properties

# 停止 Kafka
/usr/local/kafka/kafka_2.12-3.3.1/bin/kafka-server-stop.sh

# 停止 Zookeeper
/usr/local/kafka/kafka_2.12-3.3.1/bin/zookeeper-server-stop.sh

```



接下来我们便安装好了单节点 Kafka 3.3.1

```sh
#####################################################  Kafka 3.3.1
安装目录 			/usr/local/kafka/kafka_2.12-3.3.1/
当前安装为 单节点   Zookeeper Prot: 2181    Kafka Prot:  9092

启动 Zookeeper
/usr/local/kafka/kafka_2.12-3.3.1/bin/zookeeper-server-start.sh -daemon /usr/local/kafka/kafka_2.12-3.3.1/config/zookeeper.properties

启动 Kafka
/usr/local/kafka/kafka_2.12-3.3.1/bin/kafka-server-start.sh -daemon /usr/local/kafka/kafka_2.12-3.3.1/config/server.properties

停止 Kafka
/usr/local/kafka/kafka_2.12-3.3.1/bin/kafka-server-stop.sh

停止 Zookeeper
/usr/local/kafka/kafka_2.12-3.3.1/bin/zookeeper-server-stop.sh
```









## 安装 EFAK   监控工具

[EFKA 官网][EFKA 官网] 			[EFKA GitHub 地址][EFKA GitHub 地址]

[EFKA 下载地址][EFKA 下载地址]



#### 下载与解压

```sh
mkdir -p /usr/local/kafka/efak
cd /usr/local/kafka/efak
# 下载相关包
wget -c -O v3.0.1.tar.gz --no-check-certificate  https://github.com/smartloli/kafka-eagle-bin/archive/v3.0.1.tar.gz

tar -zxvf ./v3.0.1.tar.gz -C ./
rm -f ./v3.0.1.tar.gz

tar -vxzf ./kafka-eagle-bin-3.0.1/efak-web-3.0.1-bin.tar.gz -C ./
rm -rf ./kafka-eagle-bin-3.0.1
```



#### 进行相关配置

需要确保有一个可用的 MySQL 数据库,并且建好名为 `ke` 的数据库

```sh
cd /usr/local/kafka/efak/efak-web-3.0.1/conf/

mv ./system-config.properties ./system-config.properties.bak

cat > ./system-config.properties << EOF
efak.zk.cluster.alias=cluster1
cluster1.zk.list=192.168.30.145:2181
cluster1.efak.broker.size=20
kafka.zk.limit.size=16
efak.webui.port=8048
cluster1.efak.offset.storage=kafka
cluster1.efak.jmx.uri=service:jmx:rmi:///jndi/rmi://%s/jmxrmi
efak.metrics.charts=true
efak.metrics.retain=15
efak.sql.topic.records.max=5000
efak.sql.topic.preview.records.max=10
efak.topic.token=keadmin
efak.driver=com.mysql.cj.jdbc.Driver
efak.url=jdbc:mysql://192.168.30.145:3306/ke?useUnicode=true&characterEncoding=UTF-8&zeroDateTimeBehavior=convertToNull
efak.username=root
efak.password=root
EOF
```



#### 配置环境变量

```sh
# 编辑当前用户环境变量
# vi ~/.bashrc
# 将一下信息 追加到末尾 
######################   EFAK-web 3.0.1    #####################
# KE_HOME=/usr/local/kafka/efak/efak-web-3.0.1
# PATH=$PATH:$KE_HOME/bin


cat >> ~/.bashrc << EOF
######################   EFAK-web 3.0.1    #####################
export KE_HOME=/usr/local/kafka/efak/efak-web-3.0.1
export PATH=\$PATH:\$KE_HOME/bin
EOF

source ~/.bashrc
```



#### 启动

```sh
cd /usr/local/kafka/efak/efak-web-3.0.1/bin/

# 启动 EFAK
ke.sh start

# 查看状态 
ke.sh status

# 停止 EFAK
ke.sh stop

# 默认登录密码 admin 123456
```



#### 其他

```sh
# 如果 发现 EFAK 无法监控 Kafka 节点的状态
# 需要在 kafka ./bin 目录下 kafka-run-class.sh 文件第一行加入 下面配置,开启 JMX 端口,并重启 Kafka
export JMX_PORT=9988
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

[官网介绍]:https://kafka.apache.org/
[官方下载地址]:https://kafka.apache.org/downloads
[阿里云镜像地址]: https://mirrors.aliyun.com/apache/kafka/



[EFKA 官网]:https://www.kafka-eagle.org/
[EFKA GitHub 地址]: https://github.com/smartloli/EFAK
[EFKA 下载地址]: https://www.kafka-eagle.org/#download
