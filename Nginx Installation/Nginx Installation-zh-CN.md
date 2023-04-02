# Nginx



## 安装包准备

[官网介绍][官网介绍]

[官方下载地址][官方下载地址]


## 简单安装

### Centos7 + Nginx

#### 下载安装包进行解压

```sh
# 创建相关的文件夹
mkdir -p /usr/local/nginx
cd /usr/local/nginx
# 下载相关版本的 Nginx
wget -c -O nginx-1.20.2.tar.gz --no-check-certificate https://nginx.org/download/nginx-1.20.2.tar.gz
tar -vxzf ./nginx-1.20.2.tar.gz -C ./
rm -f ./nginx-1.20.2.tar.gz
```



#### 编译安装

1.  普通编译

```sh

# 确保系统有 相关的 编译库
# GCC编译器: gcc gcc-c++
# 正则表达式PCRE库: pcre pcre-devel
# zlib压缩库: zlib zlib-devel
# OpenSSL开发库: openssl openssl-devel
yum install -y gcc gcc-c++ pcre pcre-devel zlib zlib-devel openssl openssl-devel

# 创建我们的安装目录
mkdir /usr/local/nginx/nginx-1-20

# 生成 makefile 文件
./configure \
--prefix=/usr/local/nginx/nginx-1-20 \
--conf-path=/usr/local/nginx/nginx-1-20/nginx.conf \
--error-log-path=/usr/local/nginx/nginx-1-20/logs/error.log \
--http-log-path=/usr/local/nginx/nginx-1-20/logs/http.log \
--pid-path=/usr/local/nginx/nginx-1-20/nginx.pid \
--lock-path=/usr/local/nginx/nginx-1-20/nginx.lock \
--http-client-body-temp-path=/usr/local/nginx/nginx-1-20/client_temp \
--http-proxy-temp-path=/usr/local/nginx/nginx-1-20/proxy_temp \
--http-fastcgi-temp-path=/usr/local/nginx/nginx-1-20/fastcgi_temp \
--http-uwsgi-temp-path=/usr/local/nginx/nginx-1-20/uwsgi_temp \
--http-scgi-temp-path=/usr/local/nginx/nginx-1-20/scgi_temp \
--with-file-aio \
--with-threads \
--with-http_addition_module \
--with-http_auth_request_module \
--with-http_dav_module \
--with-http_flv_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_mp4_module \
--with-http_random_index_module \
--with-http_realip_module \
--with-http_secure_link_module \
--with-http_slice_module \
--with-http_ssl_module \
--with-http_stub_status_module \
--with-http_sub_module \
--with-http_v2_module \
--with-mail \
--with-mail_ssl_module \
--with-stream \
--with-stream_realip_module \
--with-stream_ssl_module \
--with-stream_ssl_preread_module 


# 编译安装  -j 8 可以依据CPU核心数，指定多个并行度加快编译速度
make -j 8 && make install

# 验证是否安装成功
cd /usr/local/nginx/nginx-1-20/sbin
./nginx -v
```

2.  编译 Lua 模块

    [Luajit 地址][Luajit 地址] 	[ngx_devel_kit 地址][ngx_devel_kit 地址] 	[lua-nginx-module 地址][lua-nginx-module 地址]
```sh
# 创建我们的安装目录
mkdir /usr/local/nginx/nginx-1-20 
mkdir /usr/local/nginx/LuaJIT

# 下载与安装 luajit
cd /usr/local/nginx/LuaJIT
wget -c -O LuaJIT-2.0.5.tar.gz --no-check-certificate https://luajit.org/download/LuaJIT-2.0.5.tar.gz
tar -vxzf ./LuaJIT-2.0.5.tar.gz -C ./
rm -f LuaJIT-2.0.5.tar.gz
cd LuaJIT-2.0.5/
make install PREFIX=/usr/local/nginx/LuaJIT
cd ..
rm -rf LuaJIT-2.0.5
# 添加为 环境变量
cat >> ~/.bashrc << EOF
######################   LuaJIT-2.0.5    #####################
export LUAJIT_LIB=/usr/local/nginx/LuaJIT/lib
export LUAJIT_INC=/usr/local/nginx/LuaJIT/include/luajit-2.0
EOF

source ~/.bashrc

# 下载相应的 模块 并解压
cd /usr/local/nginx/nginx-1.20.2
mkdir module && cd module
wget -c -O v0.3.1rc1.tar.gz --no-check-certificate https://github.com/vision5/ngx_devel_kit/archive/refs/tags/v0.3.1rc1.tar.gz
# 一定要下载 v0.10.9rc7.tar.gz 版本的
wget -c -O v0.10.9rc7.tar.gz --no-check-certificate https://github.com/openresty/lua-nginx-module/archive/v0.10.9rc7.tar.gz
tar -vxzf ./v0.10.22.tar.gz -C ./
tar -vxzf ./v0.3.1rc1.tar.gz -C ./
rm -rf ./*.gz
mv lua-nginx-module-0.10.9rc7 lua-nginx-module && mv ngx_devel_kit-0.3.1rc1 ngx_devel_kit
# 生成 makefile 文件
cd /usr/local/nginx/nginx-1.20.2
./configure \
--prefix=/usr/local/nginx/nginx-1-20 \
--conf-path=/usr/local/nginx/nginx-1-20/nginx.conf \
--error-log-path=/usr/local/nginx/nginx-1-20/logs/error.log \
--http-log-path=/usr/local/nginx/nginx-1-20/logs/http.log \
--pid-path=/usr/local/nginx/nginx-1-20/nginx.pid \
--lock-path=/usr/local/nginx/nginx-1-20/nginx.lock \
--http-client-body-temp-path=/usr/local/nginx/nginx-1-20/client_temp \
--http-proxy-temp-path=/usr/local/nginx/nginx-1-20/proxy_temp \
--http-fastcgi-temp-path=/usr/local/nginx/nginx-1-20/fastcgi_temp \
--http-uwsgi-temp-path=/usr/local/nginx/nginx-1-20/uwsgi_temp \
--http-scgi-temp-path=/usr/local/nginx/nginx-1-20/scgi_temp \
--with-file-aio \
--with-threads \
--with-http_addition_module \
--with-http_auth_request_module \
--with-http_dav_module \
--with-http_flv_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_mp4_module \
--with-http_random_index_module \
--with-http_realip_module \
--with-http_secure_link_module \
--with-http_slice_module \
--with-http_ssl_module \
--with-http_stub_status_module \
--with-http_sub_module \
--with-http_v2_module \
--with-mail \
--with-mail_ssl_module \
--with-stream \
--with-stream_realip_module \
--with-stream_ssl_module \
--with-stream_ssl_preread_module \
--add-module=/usr/local/nginx/nginx-1.20.2/module/ngx_devel_kit \
--add-module=/usr/local/nginx/nginx-1.20.2/module/lua-nginx-module \
--with-ld-opt="-Wl,-rpath,$LUAJIT_LIB"


# 编译安装  -j 8 可以依据CPU核心数，指定多个并行度加快编译速度
make -j 8 && make install

# 验证是否安装成功
cd /usr/local/nginx/nginx-1-20/sbin
./nginx -v
```



#### 修改环境变量以及

-   修改环境变量，我当前修改的是用户环境变量，若要修改全局环境变量，请修改 `/etc/profile` 文件

```sh
# 编辑当前用户环境变量
# vi ~/.bashrc
# 将一下信息 追加到末尾 
######################   Nginx 1.20.2    #####################
# export NGINX_HOME=/usr/local/nginx/nginx-1-20
# export PATH=$PATH:$NGINX_HOME/sbin


cat >> ~/.bashrc << EOF
######################   Nginx 1.20.2    #####################
export NGINX_HOME=/usr/local/nginx/nginx-1-20
export PATH=\$PATH:\$NGINX_HOME/sbin
EOF

source ~/.bashrc
```



#### 其他

```sh
cd /usr/local/nginx/nginx-1-20
# 启动
nginx

# 重启
nginx -s reload

# 校验 配置文件是否正确
nginx -t
```







接下来我们便安装好了 Nginx 1.20.2

```sh
#####################################################  Nginx 1.20.2
安装目录 			/usr/local/nginx/nginx-1-20
启动服务 			nginx
```





---



[官网介绍]: https://nginx.org/en/
[官方下载地址]: https://nginx.org/en/download.html
[Luajit 地址]: https://luajit.org/download.html
[ngx_devel_kit 地址]: https://github.com/vision5/ngx_devel_kit/archive/refs/tags/
[lua-nginx-module 地址]: https://github.com/openresty/lua-nginx-module/archive/refs/tags/