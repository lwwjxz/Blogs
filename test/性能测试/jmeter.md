1. [插件管理器安装](https://jmeter-plugins.org/wiki/PluginsManager/)
1. [让你的 JMeter 像 LoadRunner 那样实时查看每秒事务数(TPS)、事务响应时间(TRT)](https://blog.csdn.net/defonds/article/details/54576604)
2. [使用Jmeter进行接口测试和压力测试的配置和使用](https://blog.csdn.net/m0_37529303/article/details/75453230)
3. [JMeter - Constant Throughput Timer Example](http://www.software-testing-tutorials-automation.com/2017/02/jmeter-constant-throughput-timer-example.html)
    1. `Using constant throughput timer, You can decide how many samples should be executed per minute. Constant throughput timer will add random pauses between requests during test execution to match required throughput figure(samples per minute).`
    2.  Calculate Throughput based on：有5个选项： 
        1. This thread only：控制每个线程的吞吐量，选择这种模式时，总的吞吐量为设置的target Throughput 乘以该线程的数量
        2. All active threads：设置的target Throughput      将分配在每个活跃线程上，每个活跃线程在上一次运行结束后等待合理的时间后再次运行。活跃线程指同一时刻同时运行的线程。
        3. All avtive threads(shared)：与All active threads的选项基本相同。唯一区别是，每个活跃线程都会在所有活跃线程上一次运行结束后等待合理的时间后再次运行。
        4. All active threads in current thread group：设置的target Throughput 将分配在当前线程组的每一个活跃线程上，当测试计划中只有一个线程组时，该选项和All active threads 选项的效果完全相同。
        5. All active threads in current thread group(shared)：与All active threads in current thread group 基本相同，唯一的区别是，每个活跃线程都会在所有活跃线程的上一次运行结束后等待合理的时间后再次运行。


