1. ScheduledThreadPoolExecutor     
  - scheduleAtFixedRate 每隔固定的一段时间执行一次任务    
  - scheduleWithFixedDelay  每次任务执行完后延迟固定的时长再次执行任务     
2. java.unit.Timer的坑。      
  - Timer是基于绝对时间的，容易受到系统时钟的影响。    
  - Timer只新建一个线程来执行所有的TimerTask，所以前面的任务会影响到后面的任务。跟ScheduledThreadPoolExecutor.scheduleAtFixedRate的效果一致的。   
  - Timer不会捕获TimerTask的异常，只是简单地停止。因此会影响到其他TimeTask的执行。     

