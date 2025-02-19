# NodeJS



## 安装包准备

[官网介绍][官网介绍]

[官方下载地址][官方下载地址]


## 简单安装

### Centos7 + NodeJS-V19.0.0

#### 下载安装包进行解压 编译安装

```sh
# 确保系统有 相关的 编译库
# GCC编译器: gcc gcc-c++
yum install -y gcc gcc-c++
# 创建相关的文件夹
mkdir -p /usr/local/node
cd /usr/local/node
# 下载相关版本的 NodeJS
wget -c -O node-v19.0.0.tar.gz --no-check-certificate https://nodejs.org/dist/v19.0.0/node-v19.0.0.tar.gz
# 解压源码包
tar -vxzf ./node-v19.0.0.tar.gz -C ./
# 删除压缩包
rm -f ./node-v19.0.0.tar.gz
# 创建 当前版本的 NodeJS 安装文件夹
mkdir ./node-19-0-0
# 进入解压文件夹
cd node-v19.0.0/
# 修改配置 指定安装位置
./configure --prefix=/usr/local/node/node-19-0-0
# 编译安装  -j 8 可以依据CPU核心数，指定多个并行度加快编译速度
make -j 8 && make install
# 删除解压包等信息
rm -rf /usr/local/node/node-v19.0.0
```



#### 修改环境变量以及配置NPM 镜像源

-   修改环境变量，我当前修改的是用户环境变量，若要修改全局环境变量，请修改 `/etc/profile` 文件

```sh
# 编辑当前用户环境变量
# vi ~/.bashrc
# 将一下信息 追加到末尾 
######################   NodeJS 19.0.0    #####################
# export NODE_HOME=/usr/local/node/node-19-0-0
# export NPM_HOME=/usr/local/node/node-19-0-0/lib/node_modules
# export PATH=$PATH:$NODE_HOME/bin:$NPM_HOME


cat >> ~/.bashrc << EOF
######################   NodeJS 19.0.0    #####################
export NODE_HOME=/usr/local/node/node-19-0-0
export NPM_HOME=/usr/local/node/node-19-0-0/lib/node_modules
export PATH=\$PATH:\$NODE_HOME/bin:\$NPM_HOME
EOF

source ~/.bashrc

# 切换 npm 镜像源为 淘宝镜像源
npm config set registry https://registry.npm.taobao.org
# 查看配置结果
npm config get registry
# 测试一下 获取包信息
npm info express
```



接下来我们便安装好了 EFAK

```sh
#####################################################  NodeJS 19.0.0
安装目录 			/usr/local/node/node-19-0-0
```









---

[官网介绍]:https://nodejs.org/
[官方下载地址]:https://nodejs.org/dist/

