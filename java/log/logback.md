
1. springboot的application.yml中不用加日志相关的配置。默认会找logback-spring.xml。
    > 最好用logback-spring.xml作为文件名而不是logback.xml。因为加载优先级为：logback.xml--->application.properties--->logback-spring.xml.logback.xml加载早于application.properties，所以如果你在logback.xml使用了变量时，而恰好这个变量是写在application.properties时，那么就会获取不到，只要改成logback-spring.xml就可以解决。    
1. 开发二方包给人的时候如果要打日志，可以将自己的logback.xml打到包中，此种情况下可能要考虑不光要logback的配置也要支持log4j2等的配置，因为不知道引用方的是指实现是什么。
2. logback源码解读文档：https://www.jianshu.com/nb/31036067
1. 常用配置:[参考](https://segmentfault.com/a/1190000008315137#articleHeader9)      
  ```
  <configuration>
    <appender name="file" class="ch.qos.logback.core.rolling.RollingFileAppender">
        <file>projectname.log</file>
        <rollingPolicy class="ch.qos.logback.core.rolling.SizeAndTimeBasedRollingPolicy">
            <!--精确到分-->
            <!--<fileNamePattern>projectname-%d{yyyy-MM-dd_HH-mm}%i.log</fileNamePattern>-->
            <!--精确到天-->
            <fileNamePattern>orgstructsyc-%d{yyyy-MM-dd}%i.log</fileNamePattern>
            <maxFileSize>100MB</maxFileSize>
            <!--3分/天的数据自动删除-->
            <maxHistory>3</maxHistory>
            
        </rollingPolicy>
        <encoder>
            <!--logger{24}包名缩写，logger{32}包名全称-->
            <pattern>%d [%thread] %-5level %logger{24} - %msg%n</pattern>
        </encoder>
    </appender>
    <appender name="console" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>%d [%thread] %-5level %logger{32} - %msg%n</pattern>
        </encoder>
    </appender>

    <logger name="poggyio.restapi" level="warn" />
    <logger name="poggyio.boot" level="warn" />
    
    <springProfile name="dev">
        <root level="info">
            <appender-ref ref="console"/>
        </root>
    </springProfile>
    <springProfile name="test">
        <root level="info">
            <appender-ref ref="file"/>
        </root>
    </springProfile>
    <springProfile name="prod">
        <root level="info">
            <appender-ref ref="file"/>
        </root>
    </springProfile>
</configuration>
  ```   
1. 包含logback-core, logback-classic and logback-access. 三模块    
    1. logback-core 基础模块，可以在该模块之上自定义自己的模块。      
    2. logback-classic 实现了SLF4J可以方便的切换成log4f，jul等框架。
    3. logback-access 与Tomcat，Jetty等容器集成，提供http访问日志功能。   
2. LoggerContext lc = (LoggerContext) LoggerFactory.getILoggerFactory();    
    1. 日志上下文
    2. logger的级别，设置就就用
    3. 日志的Hierarchy，是一棵树：https://logback.qos.ch/manual/architecture.html,日志级别是自己配置了就用自己的，没配置就往上找最近的祖先的级别   
    4. 同一个名字只有一个实例对象(同名单例)    
3. 配置一般是在代码初始化的时候完成的。     
4. appender 日志输出的目的地，一般为控制台、文件、远程套接字服务器、MySQL、PostgreSQL、Oracle和其他数据库、JMS以及远程UNIX Syslog守护程序都有附加程序。
5. 一个logger可以链接多个appender。apppender会继承，可以配置<logger name="MONITER_FILE" additivity="false">中断继承。    
6. 日志打印流程图:https://logback.qos.ch/manual/underTheHood.html
7. 日志打印是线程安全的。       
8. 并发打印时日志的顺序？    
9. 配置文件的加载顺序: logback-test.xml,logback.xml       
10. 排查logback的问题可以，注册lisenter或硬编码,不仅可以看到读取的配置信息还可以排查比如磁盘满了，配置文件格式正确等错误。
    ```
    LoggerContext lc = (LoggerContext) LoggerFactory.getILoggerFactory();
    StatusManager statusManager = lc.getStatusManager();
    OnConsoleStatusListener onConsoleListener = new
    OnConsoleStatusListener();
    statusManager.add(onConsoleListener);
    ```
    
    ```
    <configuration>
        <!-- Recommendation: place status listeners towards the the top of the configuration file -->
        <statusListener class="ch.qos.logback.core.status.OnConsoleStatusListener" />
        <!--  the rest of the configuration file -->
    </configuration>
    ```
11. 配置文件可以定时刷新。    
12. Enabling packaging data in stack traces可以打印异常日志的打包数据但是特别耗费资源,每一行异常日志后面都会打印出当前类所受的jar包。
    ```
    14:28:48.835 [btpool0-7] INFO  c.q.l.demo.prime.PrimeAction - 99 is not a valid value
    java.lang.Exception: 99 is invalid
    at ch.qos.logback.demo.prime.PrimeAction.execute(PrimeAction.java:28) [classes/:na]
    at org.apache.struts.action.RequestProcessor.processActionPerform(RequestProcessor.java:431) [struts-1.2.9.jar:1.2.9]
    at org.apache.struts.action.RequestProcessor.process(RequestProcessor.java:236) [struts-1.2.9.jar:1.2.9]
    at org.apache.struts.action.ActionServlet.doPost(ActionServlet.java:432) [struts-1.2.9.jar:1.2.9]
    at javax.servlet.http.HttpServlet.service(HttpServlet.java:820) [servlet-api-2.5-6.1.12.jar:6.1.12]
    at org.mortbay.jetty.servlet.ServletHolder.handle(ServletHolder.java:502) [jetty-6.1.12.jar:6.1.12]
    at ch.qos.logback.demo.UserServletFilter.doFilter(UserServletFilter.java:44) [classes/:na]
    at org.mortbay.jetty.servlet.ServletHandler$CachedChain.doFilter(ServletHandler.java:1115) [jetty-6.1.12.jar:6.1.12]
    at org.mortbay.jetty.servlet.ServletHandler.handle(ServletHandler.java:361) [jetty-6.1.12.jar:6.1.12]
    at org.mortbay.jetty.webapp.WebAppContext.handle(WebAppContext.java:417) [jetty-6.1.12.jar:6.1.12]
    at org.mortbay.jetty.handler.ContextHandlerCollection.handle(ContextHandlerCollection.java:230) [jetty-6.1.12.jar:6.1.12]
  
    
13. jar包中打日志,getLoger后，可以设置appender，appender可以手动指定文件位置和其他配置。     
    
    
    
    

 
   
