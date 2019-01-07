    >原创文章，转载请务必将下面这段话置于文章开头处（保留超链接）。
    >本文转发自技术世界，原文链接　http://www.jasongj.com/java/nio_reactor/
    >有图有代码特别容易理解所以特此备份一份有删减
# 阻塞I/O下的服务器实现
## 单线程逐个处理所有请求
```
public class IOServer {
  private static final Logger LOGGER = LoggerFactory.getLogger(IOServer.class);
  public static void main(String[] args) {
    ServerSocket serverSocket = null;
    try {
      serverSocket = new ServerSocket();
      serverSocket.bind(new InetSocketAddress(2345));
    } catch (IOException ex) {
      LOGGER.error("Listen failed", ex);
      return;
    }
    try{
      while(true) {
        Socket socket = serverSocket.accept();
        InputStream inputstream = socket.getInputStream();
        LOGGER.info("Received message {}", IOUtils.toString(inputstream));
        IOUtils.closeQuietly(inputstream);
      }
    } catch(IOException ex) {
      IOUtils.closeQuietly(serverSocket);
      LOGGER.error("Read message failed", ex);
    }
  }
}
```

## 为每个请求创建一个线程

上例使用单线程逐个处理所有请求，同一时间只能处理一个请求，等待I/O的过程浪费大量CPU资源，同时无法充分使用多CPU的优势。下面是使用多线程对阻塞I/O模型的改进。一个连接建立成功后，创建一个单独的线程处理其I/O操作。




