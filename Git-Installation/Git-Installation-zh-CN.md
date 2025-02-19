# Git



## 安装包准备


[官网介绍][官网介绍]

[官方下载地址][官方下载地址]


## 简单安装

### Centos7 + Git 

#### 下载安装包进行解压 编译安装

```sh
# 创建相关的文件夹
mkdir -p /usr/local/git
cd /usr/local/git
# 下载相关版本的 Git
wget -c -O git-2.39.0.tar.gz --no-check-certificate https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.39.0.tar.gz
tar -vxzf ./git-2.39.0.tar.gz -C ./
# 创建 当前版本的 git 安装文件夹
mkdir ./git-2-39-0
# 进入解压文件夹
cd git-2.39.0
# 修改配置 指定安装位置
./configure --prefix=/usr/local/git/git-2-39-0
# 编译安装
make -j 8 && make install
# 删除解压包等信息
cd /usr/local/git
rm -rf git-2.39.0
```



#### 修改环境变量以及

-   修改环境变量，我当前修改的是用户环境变量，若要修改全局环境变量，请修改 `/etc/profile` 文件

```sh
# 编辑当前用户环境变量
# vi ~/.bashrc
# 将一下信息 追加到末尾 
######################   Git 2.39.0    #####################
# export GIT_HOME=/usr/local/git/git-2-39-0
# export PATH=$PATH:$GIT_HOME/bin


cat >> ~/.bashrc << EOF

######################   Git 2.39.0    #####################
export GIT_HOME=/usr/local/git/git-2-39-0
export PATH=\$PATH:\$GIT_HOME/bin

EOF

source ~/.bashrc
```



接下来我们便安装好了 Git

```sh
#####################################################  Git 2.39.0
安装目录 			/usr/local/git/git-2-39-0
```









---

[官网介绍]:https://git-scm.com/
[官方下载地址]:https://git-scm.com/downloads