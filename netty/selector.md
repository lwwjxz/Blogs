1. [selector.wakeup()](https://goldendoc.iteye.com/blog/1152079)
    1. select(timeout)和select()的选择过程是阻塞的，其他线程如果想终止这个过程，就可以调用wakeup来唤醒。
1. [selector.now()](https://www.hifreud.com/2017/04/18/java-nio-05-selector/)
    ```
    // 阻塞到至少有一个通道在你注册的事件上就绪了。
    selector.select();
    // 和select()一样，除了最长会阻塞timeout毫秒(参数)。
    selector.select(1000);
    // 不会阻塞，不管什么通道就绪都立刻返回，如果无通道就绪，则立即返回零
    selector.selectNow();
    ```