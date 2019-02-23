## 名称解释
1. TLS：传输层安全协议 Transport Layer Security的缩写    
1. SSL：安全套接字层 Secure Socket Layer的缩写   
1. TLS与SSL对于不是专业搞安全的开发人员来讲，可以认为是差不多的，这二者是并列关系，详细差异见 http://kb.cnblogs.com/page/197396/

1. KEY 通常指私钥。

1. CSR 是Certificate Signing Request的缩写，即证书签名请求，这不是证书，可以简单理解成公钥，生成证书时要把这个提交给权威的证书颁发机构。

1. CRT 即 certificate的缩写，即证书。

1. X.509   
    > 是一种证书格式.对X.509证书来说，认证者总是CA或由CA指定的人，一份X.509证书是一些标准字段的集合，这些字段包含有关用户或设备及其相应公钥的信息。   
    > X.509的证书文件，一般以.crt结尾，根据该文件的内容编码格式，可以分为以下二种格式：

        >> PEM - Privacy Enhanced Mail,打开看文本格式,以"-----BEGIN..."开头, "-----END..."结尾,内容是BASE64编码.
        Apache和*NIX服务器偏向于使用这种编码格式.

        >> DER - Distinguished Encoding Rules,打开看是二进制格式,不可读.
        Java和Windows服务器偏向于使用这种编码格式

1. OpenSSL 相当于SSL的一个实现，如果把SSL规范看成OO中的接口，那么OpenSSL则认为是接口的实现。接口规范本身是安全没问题的，但是具体实现可能会有不完善的地方，比如之前的"心脏出血"漏洞，就是OpenSSL中的一个bug.    
## [申请证书](http://xstarcd.github.io/wiki/sysadmin/openssl_genrsa_req_sign.html)
1. 一般情况下，制作证书要经过几个步骤，如上图所示。

    > 首先用openssl genrsa生成一个私钥  
    > 然后用openssl req生成一个签署请求    
    > 最后把请求交给CA，CA签署后就成为该CA认证的证书     
    > 如果生成签署请求时加上-x509参数，那么就直接生成一个self-signed的证书，即自己充当CA认证自己。   
  
1. 如果您只是想做一张测试用的电子证书或不想花钱去找个 CA 签署，您可以造一张自签 (Self-signed) 的电子证书。当然这类电子证书没有任何保证，大部份软件偶到这证书会发出警告，甚至不接收这类证书。使用自签名(self-signed)的证书，它的主要目的不是防伪，而是使用户和系统之间能够进行SSL通信，保证密码等个人信息传输时的安全。

1. 这里先说下证书相关的几个名词：

    > RSA私钥能解密用证书公钥加密后的信息。通常以.key为后缀，表示私钥也称作密钥。是需要管理员小心保管，不能泄露的。
    > CSR(Certificate Signing Request)包含了公钥和名字信息。通常以.csr为后缀，是网站向CA发起认证请求的文件，是中间文件。
    > 证书通常以.crt为后缀，表示证书文件。
    > CA(Certifying Authority)表示证书权威机构，它的职责是证明公钥属于个人、公司或其他的组织。   
1. 申请过程    
```
# 生成一个RSA密钥
openssl genrsa -des3 -out 33iq.key 1024
 
# 拷贝一个不需要输入密码的密钥文件 
openssl rsa -in 33iq.key -out 33iq_nopass.key
 
# 生成一个证书请求
# 会提示输入省份、城市、域名信息等，重要的是email一定要是你的域名后缀的；
# 这样就有一个 csr 文件了，提交给 ssl 提供商的时候就是这个 csr 文件。
# CA会给你一个新的文件cacert.pem，那才是你的数字证书。
openssl req -new -key 33iq.key -out 33iq.csr
 
# 自己签发证书
openssl x509 -req -days 365 -in 33iq.csr -signkey 33iq.key -out 33iq.crt
 
# 直接生成自签发证书
# 如果生成签署请求时加上-x509参数，那么就直接生成一个self-signed的证书，即自己充当CA认证自己
openssl req -x509 -newkey rsa:1024 -nodes -days 999 -keyout 33iq.key -out 33iq.crt
```

## 双向认证
单向认证后数据传输已经是安全的了，一般的单向认证客户端需要确认服务端的身份，双向认证服务端也需要确认客户端的
身份










