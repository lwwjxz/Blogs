1. 通用配置放上面，环境相关的配置放下面
    ```
    mybatis:
      config-location: mybatis/mybatis-config.xml

    quartz:
      scheduled:
        time: "*/1 * * * * ?"



    # 环境相关的配置
    spring:
      profiles:
        active: dev

    ---
    spring:
      profiles: dev

    oracle:
      datasource:
        driver-class-name: oracle.jdbc.driver.OracleDriver
        url: jdbc:oracle:thin:xxxxxxx
        username: xxxxxxx
        password: xxxxxxx

    ---
    spring:
      profiles: test

    oracle:
      datasource:
        driver-class-name: oracle.jdbc.driver.OracleDriver
        url: jdbc:oracle:thin:xxxxxxx
        username: xxxxxxx
        password: xxxxxxx

    ---
    spring:
      profiles: prod

    oracle:
      datasource:
        driver-class-name: oracle.jdbc.driver.OracleDriver
        url: jdbc:oracle:thin:xxxxxxx
        username: xxxxxxx
        password: xxxxxxx
    ```
