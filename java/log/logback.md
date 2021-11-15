
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
