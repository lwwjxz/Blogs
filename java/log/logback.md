
1. springboot的application.yml中配置文件地址        
  ```
  # 日志配置
  logging:
  config: classpath:logback/logback.xml
  ```
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
    <root level="error">
        <appender-ref ref="file" />
        <!--<appender-ref ref="console" />-->
    </root>
</configuration>
  ```
