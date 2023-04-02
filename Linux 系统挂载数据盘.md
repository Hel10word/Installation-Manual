### 

```sh
# 查看系统当前已挂载的文件
df -h

# 查看系统当前所有的磁盘
fdisk -l

# 记住我们需要挂载的数据盘 路径
# 例如: Disk /dev/sdb: 53.7 GB, 53687091200 bytes, 104857600 sectors
# 使用命令对磁盘进行分区,依次输入: n、p、1、回车两次、wq
fdisk /dev/sdb

# 使用 fdisk -l 命令，可以看到我们上一步 数据盘分区后的路径
# 例如:    Device Boot      Start         End      Blocks   Id  System
# 		/dev/sdb1            2048   104857599    52427776   83  Linux
# /dev/sdb1 便是分区后的路径

# 格式化我们上一步的创建的新分区
# mkfs.ext3 /dev/sdb1
# 如果是 centos 6.4 版本以上 可以使用
mkfs.ext4 /dev/sdb1

# 创建我们 需要挂载数据盘的文件夹
mkdir -p /usr/local/extend

# 修改 系统分区映射配置
echo '/dev/sdb1  /usr/local/extend ext4    defaults    0  0' >> /etc/fstab

# 挂载新分区
mount -a

# 接下来 便可以查看我们挂载的分区了
df -h
```

