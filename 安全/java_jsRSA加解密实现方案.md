1. java端生成公私钥     
        KeyPairGenerator kpGen = KeyPairGenerator.getInstance("RSA");
        kpGen.initialize(1024);
        KeyPair kp = kpGen.generateKeyPair();
        String privateKeyStr = Base64.getEncoder().encodeToString(kp.getPrivate().getEncoded());
        String publicKeyStr = Base64.getEncoder().encodeToString(kp.getPublic().getEncoded());
        System.out.println("私钥: "+ privateKeyStr);
        System.out.println("公钥: "+ publicKeyStr);
       
2. js端加密       

```
        <!DOCTYPE html>
        <html>
        <head>
        <meta charset="utf-8">
        <title></title>
        </head>
        <body>

        <h1>页面</h1>
        <p>段落</p>
          <script src="https://cdn.jsdelivr.net/npm/jsencrypt@3.0.0-rc.1/bin/jsencrypt.min.js"></script>
        <script>
          var encrypt = new JSEncrypt();
            encrypt.setPublicKey('MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCesgzN/Id2MsV1cBQ1dO3X+OgmqX4MJoOBfue3uuO4jcQJT5I/vJsgLbQNiXSbjnMFICZkIC2uu1v6PwS6NeNOxtsyibBjXMw5RISzkjmbZVIln/gq3bBtQW69vKzR/ogwJTP5zfGgizAnbacUsuVGK6TM0qIfTHr8gul/Nyz/4QIDAQAB');
            var encrypted = encrypt.encrypt('加密的字符串');
        window.alert(encrypted);
        </script>

        </body>
        </html>     
        ```
3. java端解密
```
public class RsaTest2 {

        public static String data="hello 中国";
        public static String publicKeyString="MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQCesgzN/Id2MsV1cBQ1dO3X+OgmqX4MJoOBfue3uuO4jcQJT5I/vJsgLbQNiXSbjnMFICZkIC2uu1v6PwS6NeNOxtsyibBjXMw5RISzkjmbZVIln/gq3bBtQW69vKzR/ogwJTP5zfGgizAnbacUsuVGK6TM0qIfTHr8gul/Nyz/4QIDAQAB";
        public static String privateKeyString= "MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAJ6yDM38h3YyxXVwFDV07df46Capfgwmg4F+57e647iNxAlPkj+8myAttA2JdJuOcwUgJmQgLa67W/o/BLo1407G2zKJsGNczDlEhLOSOZtlUiWf+CrdsG1Bbr28rNH+iDAlM/nN8aCLMCdtpxSy5UYrpMzSoh9MevyC6X83LP/hAgMBAAECgYBMpOmSQriZ2YOMaIkaGFMWz9wvcAS0kZVJ4aTAE78Pz0gyxv93UPwK2ofvUcfDqVTb0N851GC71zlg7za1SHlzOUjTrw/3KTySb8dvtBNJKUBreSsFVJk7aAMehzLT3VAbNv3bOz1i49+cvHOqseshul6hl5h0WPLnmlSFvgNbAQJBAO0p5+iGKhWxWTwnUFfROfasKMivgbyrv98hqUbBizkl/zyEYYzXNEIagskz00xCqZb7oP/Mr1doIQ1oGpiS6BkCQQCrTLOtRHFuSQLv/Rzd7ArjAU+dzotu3k7XhhA0K07sLHNNWyu8x3zvvaxwS7p7Iaj93bX67vagajwuVJXOYG8JAkEAiww+w72lfwJz5yjFmjc5XL6jSsZbslqgLBp4PNvM3LzCYKDc8M5b/UW92GliQRv0gmkVg+RmCUEr38hhj4LSQQJAbLkWIZcbV6BHmQLR25kBn+spGUQLA6dd6zVP+4yxXv0ngaWoMP18sr10QSIPji9jDx41brtVFaPX5qARJRfX4QJBAKUm+nv3jCCghLKMcIJq2DBTl1IrvfO/fv/Uqpk4p8ZL99ATtxwyCsiLpRnLaSFnPZ8VwIEaYgaHStsuHkj5ytI=";

    public static void main(String[] args) throws Exception {
            // TODO Auto-generated method stub


            //获取公钥
            PublicKey publicKey=getPublicKey(publicKeyString);

            //获取私钥
            PrivateKey privateKey=getPrivateKey(privateKeyString);

            //公钥加密
            byte[] encryptedBytes=encrypt(data.getBytes(), publicKey);
            System.out.println("加密后："+new String(encryptedBytes));

            //私钥解密
            byte[] decryptedBytes=decrypt(encryptedBytes, privateKey);
            System.out.println("解密后："+new String(decryptedBytes));
        }

        //将base64编码后的公钥字符串转成PublicKey实例
        public static PublicKey getPublicKey(String publicKey) throws Exception{
            byte[ ] keyBytes= Base64.getDecoder().decode(publicKey.getBytes());
            X509EncodedKeySpec keySpec=new X509EncodedKeySpec(keyBytes);
            KeyFactory keyFactory=KeyFactory.getInstance("RSA");
            return keyFactory.generatePublic(keySpec);
        }

        //将base64编码后的私钥字符串转成PrivateKey实例
        public static PrivateKey getPrivateKey(String privateKey) throws Exception{
            byte[ ] keyBytes=Base64.getDecoder().decode(privateKey.getBytes());
            PKCS8EncodedKeySpec keySpec=new PKCS8EncodedKeySpec(keyBytes);
            KeyFactory keyFactory=KeyFactory.getInstance("RSA");
            return keyFactory.generatePrivate(keySpec);
        }

        //公钥加密
        public static byte[] encrypt(byte[] content, PublicKey publicKey) throws Exception{
            Cipher cipher=Cipher.getInstance("RSA");//java默认"RSA"="RSA/ECB/PKCS1Padding"
            cipher.init(Cipher.ENCRYPT_MODE, publicKey);
            return cipher.doFinal(content);
        }
        //私钥解密
        public static byte[] decrypt(byte[] content, PrivateKey privateKey) throws Exception{
            Cipher cipher=Cipher.getInstance("RSA");
            cipher.init(Cipher.DECRYPT_MODE, privateKey);
            return cipher.doFinal(content);
        }





}
```
