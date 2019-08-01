
#nginx 作用
反向代理
cache
load balance
lua扩展等 

#安装与使用
MAC系统一个工具 homebrew
默认路径   /usr/local/etc/nginx
WIN 系统下载后是一个压缩包解压后就直接运行nginx.exe就启动了


## 使用nginx 常用命令
直接点击Nginx目录下的nginx.exe    或者    cmd运行start nginx

关闭
nginx -s stop
nginx -s quit
nginx -s reload
nginx -t
stop表示立即停止nginx,不保存相关信息
quit表示正常退出nginx,并保存相关信息

重启(因为改变了配置,需要重启)

nginx检查配置

首先执行命令找到nginx路径，
ps aux | grep nginx；
如nginx路径为；
/usr/local/nginx/sbin/nginx；



nginx的配置

include 某个配置文件吗相当于吧配置文件合并一起，只是形式上在多个文件里而已
servername hostname
location /

c:\windows\system32\drivers\etc

代理缓存的头


https
私钥--服务器上--解密用
公钥--
握手的时候传输
加密字符串


curl -v
curl -v -k 用 h2
curl -v --http1.1

自动兼容


chrome://net-internals
https://http2.akamai.com/demo/http2-lab.html

随机数、支持加密套件 cipher suite
随机数、证书
主密钥


1 客户端想服务端发送随机数+加密套件  cipher suite, 服务端会选一个
2 服务端想客户端发送随机字符串+ 证书（公钥）
3公钥 到 预主密钥 ，预主密钥
中间人无法拿不到加密字符串
解密


[证书生成命令](https://gist.github.com/Jokcy/5e73fd6b2a9b21c142ba2b1995150808)


openssl req -x509 -newkey rsa:1024 -keyout key.pem -out req.pem 
openssl req -x509 -newkey rsa:2048 -nodes -sha256 -keyout  test-privkey.pem -out  test-cert.pem 

server{
 #SPDI
 listen 443 http2;
 server_name test.com;
 http2_push_preload on;
 ssl on;

}


server{
  listen 80;
  server_name arc.com;
  location /{
  # 默认 这个代理的ip会在后端拿到，而不是客户端的host，（转发者是nginx，nginx重新发起了一个请求，后端拿到的是nginx的host是符合逻辑的）如果想在后端拿到客户端的host则加配置：proxy_set_header Host $host;
    proxy_pass http://127.0.0.1:8002;
    #用于把客户请求头 传递到后端： 代理服务器修改请求头
    proxy_set_header Host $host;

  }
}



http2
信道复用
分帧发送 并发发送请求

Server Push 服务端主动推送

http 原理
tcp 链接 三次链接
https 握手
长连接


http技术点 cache  etag csp 网页内容安全性 可用性


nginx实践


一个连就能复用
并发连接数限制


//删除文件
del /a /f /q C:\windows\*.txt

解释：
DEL为删除命令
/a /f 是强制删除所有属性的文件
/q是无需确认直接删除
*为通配符
要是再加上/s开关，就可以删除子文件加中的文件
如果想删除所有文件夹内的.txt文件就是
del /a /f /s /q D:\*.txt
能删除D盘所有txt后缀文件 并且不用确认



# 学习记录

默认情况下服务器获取的host是 nginx的host，如果需要客户端的host则 配置一下啊 "proxy_set_header Host $host;"


proxy_set_header



--------------------------------------------------------------------------------------

 


 













 
PS：Nginx使用有两三年了，现在经常碰到有新用户问一些很基本的问题，我也没时间一一回答，今天下午花了点时间，结合自己的使用经验，把Nginx的主要配置参数说明分享一下，也参考了一些网络的内容，这篇是目前最完整的Nginx配置参数中文说明了。更详细的模块参数请参考：http://wiki.nginx.org/Main

#定义Nginx运行的用户和用户组

user www www;

 

#nginx进程数，建议设置为等于CPU总核心数。

worker_processes 8;

 

#全局错误日志定义类型，[ debug | info | notice | warn | error | crit ]

error_log ar/loginx/error.log info;

 

#进程文件

pid ar/runinx.pid;

 

#一个nginx进程打开的最多文件描述符数目，理论值应该是最多打开文件数（系统的值ulimit -n）与nginx进程数相除，但是nginx分配请求并不均匀，所以建议与ulimit -n的值保持一致。

worker_rlimit_nofile 65535;

 

#工作模式与连接数上限

events

{

#参考事件模型，use [ kqueue | rtsig | epoll | /dev/poll | select | poll ]; epoll模型是Linux 2.6以上版本内核中的高性能网络I/O模型，如果跑在FreeBSD上面，就用kqueue模型。

use epoll;

#单个进程最大连接数（最大连接数=连接数*进程数）

worker_connections 65535;

}

 

#设定http服务器

http

{

include mime.types; #文件扩展名与文件类型映射表

default_type application/octet-stream; #默认文件类型

#charset utf-8; #默认编码

server_names_hash_bucket_size 128; #服务器名字的hash表大小

client_header_buffer_size 32k; #上传文件大小限制

large_client_header_buffers 4 64k; #设定请求缓

client_max_body_size 8m; #设定请求缓

sendfile on; #开启高效文件传输模式，sendfile指令指定nginx是否调用sendfile函数来输出文件，对于普通应用设为 on，如果用来进行下载等应用磁盘IO重负载应用，可设置为off，以平衡磁盘与网络I/O处理速度，降低系统的负载。注意：如果图片显示不正常把这个改成off。

autoindex on; #开启目录列表访问，合适下载服务器，默认关闭。

tcp_nopush on; #防止网络阻塞

tcp_nodelay on; #防止网络阻塞

keepalive_timeout 120; #长连接超时时间，单位是秒

 

#FastCGI相关参数是为了改善网站的性能：减少资源占用，提高访问速度。下面参数看字面意思都能理解。

fastcgi_connect_timeout 300;

fastcgi_send_timeout 300;

fastcgi_read_timeout 300;

fastcgi_buffer_size 64k;

fastcgi_buffers 4 64k;

fastcgi_busy_buffers_size 128k;

fastcgi_temp_file_write_size 128k;

 

#gzip模块设置

gzip on; #开启gzip压缩输出

gzip_min_length 1k; #最小压缩文件大小

gzip_buffers 4 16k; #压缩缓冲区

gzip_http_version 1.0; #压缩版本（默认1.1，前端如果是squid2.5请使用1.0）

gzip_comp_level 2; #压缩等级

gzip_types text/plain application/x-javascript text/css application/xml;

#压缩类型，默认就已经包含textml，所以下面就不用再写了，写上去也不会有问题，但是会有一个warn。

gzip_vary on;

#limit_zone crawler $binary_remote_addr 10m; #开启限制IP连接数的时候需要使用

 

upstream blog.ha97.com {

#upstream的负载均衡，weight是权重，可以根据机器配置定义权重。weigth参数表示权值，权值越高被分配到的几率越大。

server 192.168.80.121:80 weight=3;

server 192.168.80.122:80 weight=2;

server 192.168.80.123:80 weight=3;

}

 

#虚拟主机的配置

server

{

#监听端口

listen 80;

#域名可以有多个，用空格隔开

server_name www.ha97.com ha97.com;

index index.html index.htm index.php;

root /data/www/ha97;

location ~ .*.(php|php5)?$

{

fastcgi_pass 127.0.0.1:9000;

fastcgi_index index.php;

include fastcgi.conf;

}

#图片缓存时间设置

location ~ .*.(gif|jpg|jpeg|png|bmp|swf)$

{

expires 10d;

}

#JS和CSS缓存时间设置

location ~ .*.(js|css)?$

{

expires 1h;

}

#日志格式设定

log_format access '$remote_addr - $remote_user [$time_local] "$request" '

'$status $body_bytes_sent "$http_referer" '

'"$http_user_agent" $http_x_forwarded_for';

#定义本虚拟主机的访问日志

access_log ar/loginx/ha97access.log access;

 

#对 "/" 启用反向代理

location / {

proxy_pass http://127.0.0.1:88;

proxy_redirect off;

proxy_set_header X-Real-IP $remote_addr;

#后端的Web服务器可以通过X-Forwarded-For获取用户真实IP

proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

#以下是一些反向代理的配置，可选。

proxy_set_header Host $host;

client_max_body_size 10m; #允许客户端请求的最大单文件字节数

client_body_buffer_size 128k; #缓冲区代理缓冲用户端请求的最大字节数，

proxy_connect_timeout 90; #nginx跟后端服务器连接超时时间(代理连接超时)

proxy_send_timeout 90; #后端服务器数据回传时间(代理发送超时)

proxy_read_timeout 90; #连接成功后，后端服务器响应时间(代理接收超时)

proxy_buffer_size 4k; #设置代理服务器（nginx）保存用户头信息的缓冲区大小

proxy_buffers 4 32k; #proxy_buffers缓冲区，网页平均在32k以下的设置

proxy_busy_buffers_size 64k; #高负荷下缓冲大小（proxy_buffers*2）

proxy_temp_file_write_size 64k;

#设定缓存文件夹大小，大于这个值，将从upstream服务器传

}

 

#设定查看Nginx状态的地址

location /NginxStatus {

stub_status on;

access_log on;

auth_basic "NginxStatus";

auth_basic_user_file confpasswd;

#htpasswd文件的内容可以用apache提供的htpasswd工具来产生。

}

 

#本地动静分离反向代理配置

#所有jsp的页面均交由tomcat或resin处理

location ~ .(jsp|jspx|do)?$ {

proxy_set_header Host $host;

proxy_set_header X-Real-IP $remote_addr;

proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;

proxy_pass http://127.0.0.1:8080;

}

#所有静态文件由nginx直接读取不经过tomcat或resin

location ~ .*.(htm|html|gif|jpg|jpeg|png|bmp|swf|ioc|rar|zip|txt|flv|mid|doc|ppt|pdf|xls|mp3|wma)$

{ expires 15d; }

location ~ .*.(js|css)?$

{ expires 1h; }

}

}

 

更详细的模块参数请参考：http://wiki.nginx.org/Main
