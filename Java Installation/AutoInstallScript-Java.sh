#!/bin/bash

echo "======== Java Install Auto ========"

# 创建目录
mkdir /usr/local/java
cd /usr/local/java
# 下载安装包
wget -c -O jdk-8u171-linux-x64.tar.gz --no-check-certificate https://repo.huaweicloud.com/java/jdk/8u171-b11/jdk-8u171-linux-x64.tar.gz
# 解压文件
tar -zxvf ./jdk-8u171-linux-x64.tar.gz -C ./
# 删除源文件 
rm -f ./jdk-8u171-linux-x64.tar.gz


cat << EOF >> ~/.bashrc
######################   JAVA    #####################
export JAVA_HOME=/usr/local/java/jdk1.8.0_171
export CLASSPATH=\$JAVA_HOME/lib/
export PATH=\$PATH:\$JAVA_HOME/bin
EOF

# 使用source 命令刷新环境变量
source ~/.bashrc
# 验证 Java 是否配置成功
java -version
