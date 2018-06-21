1. 手动上传  手动删除不支持snapshots。
![](https://github.com/lwwjxz/Blogs/blob/master/image/WX20180621-104936.png)   
1. 最简单的  
```
curl -v -u admin:admin123 --upload-file pom.xml http://localhost:8081/nexus/content/repositories/releases/org/foo/1.0/foo-1.0.pom
```
[参考](https://support.sonatype.com/hc/en-us/articles/213465818-How-can-I-programmatically-upload-an-artifact-into-Nexus-2-)
