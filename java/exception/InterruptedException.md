参考:https://www.jianshu.com/p/a8abe097d4ed

```下文中的阻塞方法好像特指sleep，wait()等。所以抛出InterruptedException不一定是阻塞方法被打断，请求中断标志不一定为false。方法java.util.concurrent.locks.AbstractQueuedSynchronizer$ConditionObject.reportInterruptAfterWait好像就抛出异常但是没有将断标志设置为false ```   
```catch到InterruptedException后是否需要把中断请求设置为false/true,需要视情况而定```


如果我们有一个运行中的软件，例如是杀毒软件正在全盘查杀病毒，此时我们不想让他杀毒，这时候点击取消，那么就是正在中断一个运行的线程。      
每一个线程都有一个boolean类型的标志，此标志意思是当前的请求是否请求中断，默认为false。当一个线程A调用了线程B的interrupt方法时，那么线程B的是否请求的中断标志变为true。而线程B可以调用方法检测到此标志的变化。      

**阻塞方法：** 如果线程B调用了阻塞方法，如果是否请求中断标志变为了true，那么它会抛出InterruptedException异常。抛出异常的同时它会将线程B的是否请求中断标志置为false      
**非阻塞方法：** 可以通过线程B的isInterrupted方法进行检测是否请求中断标志为true还是false，另外还有一个静态的方法interrupted方法也可以检测标志。但是静态方法它检测完以后会自动的将是否请求中断标志位置为false。例如线程A调用了线程B的interrupt的方法，那么如果此时线程B中用静态interrupted方法进行检测标志位的变化的话，那么第一次为true，第二次就为false。下面为具体的例子：
```
/**
 * @program: Test
 * @description:
 * @author: hu_pf@suixingpay.com
 * @create: 2018-07-31 15:43
 **/
public class InterrupTest implements Runnable{

    public void run(){
            try {
                while (true) {
                    Boolean a = Thread.currentThread().isInterrupted();
                    System.out.println("in run() - about to sleep for 20 seconds-------" + a);
                    Thread.sleep(20000);
                    System.out.println("in run() - woke up");
                }
            } catch (InterruptedException e) {
                Thread.currentThread().interrupt();//如果不加上这一句，那么cd将会都是false，因为在捕捉到InterruptedException异常的时候就会自动的中断标志置为了false
                Boolean c=Thread.interrupted();
                Boolean d=Thread.interrupted();
                System.out.println("c="+c);
                System.out.println("d="+d);
            }
    }
    public static void main(String[] args) {
        InterrupTest si = new InterrupTest();
        Thread t = new Thread(si);
        t.start();
        //主线程休眠2秒，从而确保刚才启动的线程有机会执行一段时间
        try {
            Thread.sleep(2000);
        }catch(InterruptedException e){
            e.printStackTrace();
        }
        System.out.println("in main() - interrupting other thread");
        //中断线程t
        t.interrupt();
        System.out.println("in main() - leaving");
    }
}

```

