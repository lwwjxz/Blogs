
1. springboot的application.yml中不用加日志相关的配置。默认会找logback-spring.xml。
> 最好用logback-spring.xml作为文件名而不是logback.xml因为在测试的过程中发现如果文件中有springProfile属性启动的时候回有点问题(能正常启动，也可以正常使用)，我猜是刚开始启动的时候还没有加载application.yml文件所以有点问题而logback-spring.xml如果找不到会用默认的配置，这应该是spring-boot做的
优化，难怪推荐用logback-spring.xml作为文件名。    
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
