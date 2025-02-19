# WSL



## 介绍

[官网介绍][官网介绍]

[安装介绍][安装介绍]



## 简单安装

### Windows10 + WSL1 + Kali-linux 

安装前需要确保系统是否支持，[检查系统版本是否符合要求][检查系统版本是否符合要求]。

#### 开启系统自带的功能。

-   可以在 `控制面板 -> 程序 -> 启用或关闭Windows功能 -> (选中最后的 “适用于 Linux 的 Windows 子系统” 与 “虚拟机平台” 两项) `


-   也可以使用如下命令 安装
	-   用管理员身份启动 CMD 运行以下两条命令。
	-   dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
	-   dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart


#### 准备安装

```sh
# 指定默认安装 WSL 1
wsl --set-default-version 1
# 查看现在拥有的 子系统版本
wsl -l -o
        # 以下是可安装的有效分发的列表。
        # 请使用“wsl --install -d <分发>”安装。
        # NAME            FRIENDLY NAME
        # Ubuntu          Ubuntu
        # Debian          Debian GNU/Linux
        # kali-linux      Kali Linux Rolling
        # openSUSE-42     openSUSE Leap 42
        # SLES-12         SUSE Linux Enterprise Server v12
        # Ubuntu-16.04    Ubuntu 16.04 LTS
        # Ubuntu-18.04    Ubuntu 18.04 LTS
        # Ubuntu-20.04    Ubuntu 20.04 LTS
# 这儿我们安装 kali-linux
wsl --install -d kali-linux

# 接下来会打开一个新窗口，等待几分钟后，根据提示信息 依次输入我们子系统的信息（输入一个用户名、密码、再次确认密码），如下：

        Enter new UNIX username: test
        Enter new UNIX password:
        Retype new UNIX password:
        passwd: password updated successfully
        Installation successful!
        test@Reese:~$
# 至此安装完毕
```

-   默认会以我们 **新建用户** 进行登录， 默认 root 用户 是 **没有密码** 的。

    -   可以使用 `su` 命令切换到 root ，然后使用 `passwd` 来为其设置密码。
    -   也在 刚刚创建的用户下使用 `sudo passwd root` 来重新设置 root 用户的密码

-   默认 Windows 系统的 盘符 会自动挂在到 `/mnt` 目录下

-   我们 Windows 资源管理器中输入 `\\wsl$` 可以进入到我们默认子系统的文件系统中

    -   也可以在 `C:\Users\Administrator\AppData\Local\Packages\xxx\LocalState\rootfs` 中查看，  *XXX* 处是你安装的子系统的名称。



#### 后续完善工作

为了方便操作，接下来我们都切换到 root 用户来进行。

1.  为我们的 子系统 **换源**

```sh
vi /etc/apt/sources.list

# 注释掉原有的内容，并追加如下内容 ，deb 为常用的软件源  deb-src 为提供软件源码的源

	#清华大学
    deb https://mirrors.tuna.tsinghua.edu.cn/kali kali-rolling main contrib non-free
	deb-src https://mirrors.tuna.tsinghua.edu.cn/kali kali-rolling main contrib non-free
    #阿里云
    deb https://mirrors.aliyun.com/kali kali-rolling main non-free contrib
    deb-src https://mirrors.aliyun.com/kali kali-rolling main non-free contrib
    
# 换完源后 我们更新一下 此过程比较漫长，我们前往不要中断。update 为更新仓库列表，让apt知道有哪些软件需要更新、upgrade 为更新本地已安装的软件
apt update && apt -y upgrade
```

2.  去掉 Windows 环境变量

```sh
# 在 wsl 系统内 新建配置 /etc/wsl.conf 文件
touch /etc/wsl.conf
vi /etc/wsl.conf
# 添加如下内容
		[interop]
		appendWindowsPath = false
		
# 需要重启 WSL 系统才生效我们放到最后所有修改完毕后 重启    
```

3.  安装 官网推荐的 GUI —— [Kali-win-kex][Kali-win-kex]，以及完成的 Kali 工具包。

```sh
# 安装 GUI
# apt install -y kali-win-kex
# 后来发现必须使用 WSL2 才能链接 
Error connecting to the KeX server.
Please try "kex start" to start the service.
If the server fails to start, please try "kex kill" or restart your WSL2 session and try again.

# 安装完整的 Kali 工具包
# 可以使用 apt search kali-linux-  来查看自己需要安装哪些工具包，这儿我们演示安装全部包。
apt install kali-linux-everything
# 这儿有些软件 需要你选择 用户名称，安装完成大约会下载 20 GB 的相关文件。全部安装完 至少需要半个小时。

# 然后更新源
apt update && apt -y upgrade

# 重启计算机
```













---


[官网介绍]:https://docs.microsoft.com/en-us/windows/wsl/about

[检查系统版本是否符合要求]:https://docs.microsoft.com/en-us/windows/wsl/install-manual#step-2---check-requirements-for-running-wsl-2

[安装介绍]:https://docs.microsoft.com/en-us/windows/wsl/install
[Kali-win-kex]:https://www.kali.org/docs/wsl/win-kex-win/


