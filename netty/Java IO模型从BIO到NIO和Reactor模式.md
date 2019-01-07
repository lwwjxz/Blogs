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
![](https://github.com/lwwjxz/Blogs/blob/master/image/IO_multithread.png)    
```
public class IOServerMultiThread {
  private static final Logger LOGGER = LoggerFactory.getLogger(IOServerMultiThread.class);
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
        new Thread( () -> {
          try{
            InputStream inputstream = socket.getInputStream();
            LOGGER.info("Received message {}", IOUtils.toString(inputstream));
            IOUtils.closeQuietly(inputstream);
          } catch (IOException ex) {
            LOGGER.error("Read message failed", ex);
          }
        }).start();
      }
    } catch(IOException ex) {
      IOUtils.closeQuietly(serverSocket);
      LOGGER.error("Accept connection failed", ex);
    }
  }
}

```

## 使用线程池处理请求

为了防止连接请求过多，导致服务器创建的线程数过多，造成过多线程上下文切换的开销。可以通过线程池来限制创建的线程数，如下所示。
```
public class IOServerThreadPool {
  private static final Logger LOGGER = LoggerFactory.getLogger(IOServerThreadPool.class);
  public static void main(String[] args) {
    ExecutorService executorService = Executors.newFixedThreadPool(Runtime.getRuntime().availableProcessors());
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
        executorService.submit(() -> {
          try{
            InputStream inputstream = socket.getInputStream();
            LOGGER.info("Received message {}", IOUtils.toString(new InputStreamReader(inputstream)));
          } catch (IOException ex) {
            LOGGER.error("Read message failed", ex);
          }
        });
      }
    } catch(IOException ex) {
      try {
        serverSocket.close();
      } catch (IOException e) {
      }
      LOGGER.error("Accept connection failed", ex);
    }
  }
}
```

# Reactor模式
## 精典Reactor模式

精典的Reactor模式示意图如下所示。
![](https://github.com/lwwjxz/Blogs/blob/master/image/classic_reactor.png)

在Reactor模式中，包含如下角色
    1. Reactor 将I/O事件发派给对应的Handler
    1. Acceptor 处理客户端连接请求
    1. Handlers 执行非阻塞读/写
最简单的Reactor模式实现代码如下所示。
```
ublic class NIOServer {
  private static final Logger LOGGER = LoggerFactory.getLogger(NIOServer.class);
  public static void main(String[] args) throws IOException {
    Selector selector = Selector.open();
    ServerSocketChannel serverSocketChannel = ServerSocketChannel.open();
    serverSocketChannel.configureBlocking(false);
    serverSocketChannel.bind(new InetSocketAddress(1234));
    serverSocketChannel.register(selector, SelectionKey.OP_ACCEPT);
    while (selector.select() > 0) {
      Set<SelectionKey> keys = selector.selectedKeys();
      Iterator<SelectionKey> iterator = keys.iterator();
      while (iterator.hasNext()) {
        SelectionKey key = iterator.next();
        iterator.remove();
        if (key.isAcceptable()) {
          ServerSocketChannel acceptServerSocketChannel = (ServerSocketChannel) key.channel();
          SocketChannel socketChannel = acceptServerSocketChannel.accept();
          socketChannel.configureBlocking(false);
          LOGGER.info("Accept request from {}", socketChannel.getRemoteAddress());
          socketChannel.register(selector, SelectionKey.OP_READ);
        } else if (key.isReadable()) {
          SocketChannel socketChannel = (SocketChannel) key.channel();
          ByteBuffer buffer = ByteBuffer.allocate(1024);
          int count = socketChannel.read(buffer);
          if (count <= 0) {
            socketChannel.close();
            key.cancel();
            LOGGER.info("Received invalide data, close the connection");
            continue;
          }
          LOGGER.info("Received message {}", new String(buffer.array()));
        }
        keys.remove(key);
      }
    }
  }
}
```

为了方便阅读，上示代码将Reactor模式中的所有角色放在了一个类中。

从上示代码中可以看到，多个Channel可以注册到同一个Selector对象上，实现了一个线程同时监控多个请求状态（Channel）。同时注册时需要指定它所关注的事件，例如上示代码中socketServerChannel对象只注册了OP_ACCEPT事件，而socketChannel对象只注册了OP_READ事件。    
selector.select()是阻塞的，当有至少一个通道可用时该方法返回可用通道个数。同时该方法只捕获Channel注册时指定的所关注的事件。    

## 多工作线程Reactor模式
经典Reactor模式中，尽管一个线程可同时监控多个请求（Channel），但是所有读/写请求以及对新连接请求的处理都在同一个线程中处理，无法充分利用多CPU的优势，同时读/写操作也会阻塞对新连接请求的处理。因此可以引入多线程，并行处理多个读/写操作，如下图所示。

![](https://github.com/lwwjxz/Blogs/blob/master/image/multithread_reactor.png)

多线程Reactor模式示例代码如下所示。

```
public class NIOServer {
  private static final Logger LOGGER = LoggerFactory.getLogger(NIOServer.class);
  public static void main(String[] args) throws IOException {
    Selector selector = Selector.open();
    ServerSocketChannel serverSocketChannel = ServerSocketChannel.open();
    serverSocketChannel.configureBlocking(false);
    serverSocketChannel.bind(new InetSocketAddress(1234));
    serverSocketChannel.register(selector, SelectionKey.OP_ACCEPT);
    while (true) {
      if(selector.selectNow() < 0) {
        continue;
      }
      Set<SelectionKey> keys = selector.selectedKeys();
      Iterator<SelectionKey> iterator = keys.iterator();
      while(iterator.hasNext()) {
        SelectionKey key = iterator.next();
        iterator.remove();
        if (key.isAcceptable()) {
          ServerSocketChannel acceptServerSocketChannel = (ServerSocketChannel) key.channel();
          SocketChannel socketChannel = acceptServerSocketChannel.accept();
          socketChannel.configureBlocking(false);
          LOGGER.info("Accept request from {}", socketChannel.getRemoteAddress());
          SelectionKey readKey = socketChannel.register(selector, SelectionKey.OP_READ);
          readKey.attach(new Processor());
        } else if (key.isReadable()) {
          Processor processor = (Processor) key.attachment();
          processor.process(key);
        }
      }
    }
  }
}
```

从上示代码中可以看到，注册完SocketChannel的OP_READ事件后，可以对相应的SelectionKey attach一个对象（本例中attach了一个Processor对象，该对象处理读请求），并且在获取到可读事件后，可以取出该对象。

注：attach对象及取出该对象是NIO提供的一种操作，但该操作并非Reactor模式的必要操作，本文使用它，只是为了方便演示NIO的接口。

具体的读请求处理在如下所示的Processor类中。该类中设置了一个静态的线程池处理所有请求。而process方法并不直接处理I/O请求，而是把该I/O操作提交给上述线程池去处理，这样就充分利用了多线程的优势，同时将对新连接的处理和读/写操作的处理放在了不同的线程中，读/写操作不再阻塞对新连接请求的处理。

```
public class Processor {
  private static final Logger LOGGER = LoggerFactory.getLogger(Processor.class);
  private static final ExecutorService service = Executors.newFixedThreadPool(16);
  public void process(SelectionKey selectionKey) {
    service.submit(() -> {
      ByteBuffer buffer = ByteBuffer.allocate(1024);
      SocketChannel socketChannel = (SocketChannel) selectionKey.channel();
      int count = socketChannel.read(buffer);
      if (count < 0) {
        socketChannel.close();
        selectionKey.cancel();
        LOGGER.info("{}\t Read ended", socketChannel);
        return null;
      } else if(count == 0) {
        return null;
      }
      LOGGER.info("{}\t Read message {}", socketChannel, new String(buffer.array()));
      return null;
    });
  }
}

```

## 多Reactor
Netty中使用的Reactor模式，引入了多Reactor，也即一个主Reactor负责监控所有的连接请求，多个子Reactor负责监控并处理读/写请求，减轻了主Reactor的压力，降低了主Reactor压力太大而造成的延迟。
并且每个子Reactor分别属于一个独立的线程，每个成功连接后的Channel的所有操作由同一个线程处理。这样保证了同一请求的所有状态和上下文在同一个线程中，避免了不必要的上下文切换，同时也方便了监控请求响应状态。

多Reactor模式示意图如下所示。个人认为图中的mainReator和subReactor命名为acceptorReator和otherReator比较合适。
![](https://github.com/lwwjxz/Blogs/blob/master/image/multi_reactor.png)

多Reactor示例代码如下所示。

```
public class NIOServer {
  private static final Logger LOGGER = LoggerFactory.getLogger(NIOServer.class);
  public static void main(String[] args) throws IOException {
    Selector selector = Selector.open();
    ServerSocketChannel serverSocketChannel = ServerSocketChannel.open();
    serverSocketChannel.configureBlocking(false);
    serverSocketChannel.bind(new InetSocketAddress(1234));
    serverSocketChannel.register(selector, SelectionKey.OP_ACCEPT);
    int coreNum = Runtime.getRuntime().availableProcessors();
    Processor[] processors = new Processor[coreNum];
    for (int i = 0; i < processors.length; i++) {
      processors[i] = new Processor();
    }
    int index = 0;
    while (selector.select() > 0) {
      Set<SelectionKey> keys = selector.selectedKeys();
      for (SelectionKey key : keys) {
        keys.remove(key);
        if (key.isAcceptable()) {
          ServerSocketChannel acceptServerSocketChannel = (ServerSocketChannel) key.channel();
          SocketChannel socketChannel = acceptServerSocketChannel.accept();
          socketChannel.configureBlocking(false);
          LOGGER.info("Accept request from {}", socketChannel.getRemoteAddress());
          Processor processor = processors[(int) ((index++) % coreNum)];
          processor.addChannel(socketChannel);
          processor.wakeup();
        }
      }
    }
  }
}

```
如上代码所示，本文设置的子Reactor个数是当前机器可用核数的两倍（与Netty默认的子Reactor个数一致）。对于每个成功连接的SocketChannel，通过round robin的方式交给不同的子Reactor。

子Reactor对SocketChannel的处理如下所示。

```
public class Processor {
  private static final Logger LOGGER = LoggerFactory.getLogger(Processor.class);
  private static final ExecutorService service =
      Executors.newFixedThreadPool(2 * Runtime.getRuntime().availableProcessors());
  private Selector selector;
  public Processor() throws IOException {
    this.selector = SelectorProvider.provider().openSelector();
    start();
  }
  public void addChannel(SocketChannel socketChannel) throws ClosedChannelException {
    socketChannel.register(this.selector, SelectionKey.OP_READ);
  }
  public void wakeup() {
    this.selector.wakeup();
  }
  public void start() {
    service.submit(() -> {
      while (true) {
        if (selector.select(500) <= 0) {
          continue;
        }
        Set<SelectionKey> keys = selector.selectedKeys();
        Iterator<SelectionKey> iterator = keys.iterator();
        while (iterator.hasNext()) {
          SelectionKey key = iterator.next();
          iterator.remove();
          if (key.isReadable()) {
            ByteBuffer buffer = ByteBuffer.allocate(1024);
            SocketChannel socketChannel = (SocketChannel) key.channel();
            int count = socketChannel.read(buffer);
            if (count < 0) {
              socketChannel.close();
              key.cancel();
              LOGGER.info("{}\t Read ended", socketChannel);
              continue;
            } else if (count == 0) {
              LOGGER.info("{}\t Message size is 0", socketChannel);
              continue;
            } else {
              LOGGER.info("{}\t Read message {}", socketChannel, new String(buffer.array()));
            }
          }
        }
      }
    });
  }
}
```

在Processor中，同样创建了一个静态的线程池，且线程池的大小为机器核数的两倍。每个Processor实例均包含一个Selector实例。同时每次获取Processor实例时均提交一个任务到该线程池，并且该任务正常情况下一直循环处理，不会停止。而提交给该Processor的SocketChannel通过在其Selector注册事件，加入到相应的任务中。由此实现了每个子Reactor包含一个Selector对象，并由一个独立的线程处理。







