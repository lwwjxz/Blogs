1. 用于替换原生的java.net.URL，因为原生的不好用，比如去取classpath中的资源，获取servlet容器中的中的资源，虽然可以重新写实现但是很复杂，且java.net.URL也缺少一些实用的接口
比如exists();    
2. 内置实现
```
UrlResource
ClassPathResource
FileSystemResource
PathResource
ServletContextResource
InputStreamResource
ByteArrayResource
```
3. ResourceLoaderAware
4. 
