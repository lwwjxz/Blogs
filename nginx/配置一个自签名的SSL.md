1. 生成一个RSA私钥 `openssl genrsa -des3 -out server.key 1024`
2. 利用上面创建的秘钥文件，就可以生成csr（证书签署请求文件）`openssl req -new -key server.key -out server.csr`
3. 在第1步创建私钥的过程中，由于必须要指定一个密码。而这个密码会带来一个副作用，那就是在每次Apache/nginx启动Web服务器时，都会要求输入密码，这显然非常不方便。要删除私钥中的密码，操作如下：
`#openssl rsa -in server.key -out server.key`
4. 生成自签名证书`#openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt`
5. 配置nginx
```
    server {
        listen       443 ssl;
        server_name  xzp.alogcc.com;

        ssl_certificate      ssl.conf/server.crt; # 此处的ssl.conf 是在conf目录下自己创建的目录
        ssl_certificate_key  ssl.conf/server.key;

        ssl_session_cache    shared:SSL:1m;
        ssl_session_timeout  5m;

        ssl_ciphers  HIGH:!aNULL:!MD5;
        ssl_prefer_server_ciphers  on;

        location / {
            root   html;
            index  index.html index.htm;
        }
    }
```
