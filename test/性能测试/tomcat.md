
1. Tomcat 8.5 and 9.0 have completely dropped the BIO connector.新版的tomcat已经不支持BIO。

1. 分别测试单个因素对tomcat性能的影响。       
    1. 各个因素的默认值为:
        系统:centos
        机器:低配
        接口阻塞时间:0毫秒
        接口数量:1
        内存设置: -Xms1024m -Xmn384m -XX:MetaspaceSize=128m
        IO:
        返回前等待时间:立即返回
        网络:弱网














1. 默认jvm参数 
    ```
    nohup java -jar  -Dspring.profiles.active=test -Djava.net.preferIPv4Stack=true -server -Xmx1024m -Xms1024m -Xmn384m -XX:MetaspaceSize=128m -XX:+HeapDumpBeforeFullGC -XX:HeapDumpPath=/data/dump -XX:MaxMetaspaceSize=512m -Xss2m -XX:+DisableExplicitGC -XX:+UseConcMarkSweepGC -XX:+CMSParallelRemarkEnabled -XX:+UseCMSCompactAtFullCollection -XX:LargePageSizeInBytes=128m -XX:+UseFastAccessorMethods -XX:+UseCMSInitiatingOccupancyOnly -XX:CMSInitiatingOccupancyFraction=70 -XX:+PrintGC -XX:+PrintGCDetails -XX:+PrintGCTimeStamps -XX:+PrintGCDateStamps -Xloggc:/data/gclogs/template-gc.log  template-0.0.1-SNAPSHOT.jar >>/data/logs/template.log 2>&1 &
    ```
1. 两台机器
    1. 低配 2核4G 虚拟机中一个processor代表一个核吧
        ```
        free -h
                      total        used        free      shared  buff/cache   available
        Mem:           3.9G        851M        2.5G        8.6M        495M        2.8G
        Swap:          8.0G          0B        8.0G
        cat /proc/cpuinfo
        processor   : 0
        vendor_id   : GenuineIntel
        cpu family  : 6
        model       : 79
        model name  : Intel(R) Xeon(R) CPU E5-4620 v4 @ 2.10GHz
        stepping    : 1
        microcode   : 0xb000021
        cpu MHz     : 2095.148
        cache size  : 25600 KB
        physical id : 0
        siblings    : 1
        core id     : 0
        cpu cores   : 1
        apicid      : 0
        initial apicid  : 0
        fpu     : yes
        fpu_exception   : yes
        cpuid level : 20
        wp      : yes
        flags       : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts mmx fxsr sse sse2 ss syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts nopl xtopology tsc_reliable nonstop_tsc aperfmperf eagerfpu pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch ida arat epb pln pts dtherm fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 invpcid rtm rdseed adx smap xsaveopt
        bogomips    : 4190.29
        clflush size    : 64
        cache_alignment : 64
        address sizes   : 42 bits physical, 48 bits virtual
        power management:

        processor   : 1
        vendor_id   : GenuineIntel
        cpu family  : 6
        model       : 79
        model name  : Intel(R) Xeon(R) CPU E5-4620 v4 @ 2.10GHz
        stepping    : 1
        microcode   : 0xb000021
        cpu MHz     : 2095.148
        cache size  : 25600 KB
        physical id : 2
        siblings    : 1
        core id     : 0
        cpu cores   : 1
        apicid      : 2
        initial apicid  : 2
        fpu     : yes
        fpu_exception   : yes
        cpuid level : 20
        wp      : yes
        flags       : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts mmx fxsr sse sse2 ss syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts nopl xtopology tsc_reliable nonstop_tsc aperfmperf eagerfpu pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch ida arat epb pln pts dtherm fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 invpcid rtm rdseed adx smap xsaveopt
        bogomips    : 4190.29
        clflush size    : 64
        cache_alignment : 64
        address sizes   : 42 bits physical, 48 bits virtual
        power management:
        ```
    1. 高配:8核32G，虚拟机中一个processor代表一个核吧
        ```
        free -h
                     total       used       free     shared    buffers     cached
        Mem:           31G        15G        15G       160K       216M       1.2G
        -/+ buffers/cache:        14G        17G
        Swap:         3.9G         0B       3.9G

        # cat /proc/cpuinfo
        processor   : 0
        vendor_id   : GenuineIntel
        cpu family  : 6
        model       : 79
        model name  : Intel(R) Xeon(R) CPU E5-4620 v4 @ 2.10GHz
        stepping    : 1
        microcode   : 184549409
        cpu MHz     : 2095.148
        cache size  : 25600 KB
        physical id : 0
        siblings    : 2
        core id     : 0
        cpu cores   : 2
        apicid      : 0
        initial apicid  : 0
        fpu     : yes
        fpu_exception   : yes
        cpuid level : 20
        wp      : yes
        flags       : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts xtopology tsc_reliable nonstop_tsc aperfmperf unfair_spinlock pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch ida arat epb xsaveopt pln pts dtherm invpcid_single fsgsbase bmi1 hle avx2 smep bmi2 invpcid rtm rdseed adx
        bogomips    : 4190.29
        clflush size    : 64
        cache_alignment : 64
        address sizes   : 42 bits physical, 48 bits virtual
        power management:

        processor   : 1
        vendor_id   : GenuineIntel
        cpu family  : 6
        model       : 79
        model name  : Intel(R) Xeon(R) CPU E5-4620 v4 @ 2.10GHz
        stepping    : 1
        microcode   : 184549409
        cpu MHz     : 2095.148
        cache size  : 25600 KB
        physical id : 0
        siblings    : 2
        core id     : 1
        cpu cores   : 2
        apicid      : 1
        initial apicid  : 1
        fpu     : yes
        fpu_exception   : yes
        cpuid level : 20
        wp      : yes
        flags       : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts xtopology tsc_reliable nonstop_tsc aperfmperf unfair_spinlock pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch ida arat epb xsaveopt pln pts dtherm invpcid_single fsgsbase bmi1 hle avx2 smep bmi2 invpcid rtm rdseed adx
        bogomips    : 4190.29
        clflush size    : 64
        cache_alignment : 64
        address sizes   : 42 bits physical, 48 bits virtual
        power management:

        processor   : 2
        vendor_id   : GenuineIntel
        cpu family  : 6
        model       : 79
        model name  : Intel(R) Xeon(R) CPU E5-4620 v4 @ 2.10GHz
        stepping    : 1
        microcode   : 184549409
        cpu MHz     : 2095.148
        cache size  : 25600 KB
        physical id : 1
        siblings    : 2
        core id     : 0
        cpu cores   : 2
        apicid      : 2
        initial apicid  : 2
        fpu     : yes
        fpu_exception   : yes
        cpuid level : 20
        wp      : yes
        flags       : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts xtopology tsc_reliable nonstop_tsc aperfmperf unfair_spinlock pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch ida arat epb xsaveopt pln pts dtherm invpcid_single fsgsbase bmi1 hle avx2 smep bmi2 invpcid rtm rdseed adx
        bogomips    : 4190.29
        clflush size    : 64
        cache_alignment : 64
        address sizes   : 42 bits physical, 48 bits virtual
        power management:

        processor   : 3
        vendor_id   : GenuineIntel
        cpu family  : 6
        model       : 79
        model name  : Intel(R) Xeon(R) CPU E5-4620 v4 @ 2.10GHz
        stepping    : 1
        microcode   : 184549409
        cpu MHz     : 2095.148
        cache size  : 25600 KB
        physical id : 1
        siblings    : 2
        core id     : 1
        cpu cores   : 2
        apicid      : 3
        initial apicid  : 3
        fpu     : yes
        fpu_exception   : yes
        cpuid level : 20
        wp      : yes
        flags       : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts xtopology tsc_reliable nonstop_tsc aperfmperf unfair_spinlock pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch ida arat epb xsaveopt pln pts dtherm invpcid_single fsgsbase bmi1 hle avx2 smep bmi2 invpcid rtm rdseed adx
        bogomips    : 4190.29
        clflush size    : 64
        cache_alignment : 64
        address sizes   : 42 bits physical, 48 bits virtual
        power management:

        processor   : 4
        vendor_id   : GenuineIntel
        cpu family  : 6
        model       : 79
        model name  : Intel(R) Xeon(R) CPU E5-4620 v4 @ 2.10GHz
        stepping    : 1
        microcode   : 184549409
        cpu MHz     : 2095.148
        cache size  : 25600 KB
        physical id : 2
        siblings    : 2
        core id     : 0
        cpu cores   : 2
        apicid      : 4
        initial apicid  : 4
        fpu     : yes
        fpu_exception   : yes
        cpuid level : 20
        wp      : yes
        flags       : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts xtopology tsc_reliable nonstop_tsc aperfmperf unfair_spinlock pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch ida arat epb xsaveopt pln pts dtherm invpcid_single fsgsbase bmi1 hle avx2 smep bmi2 invpcid rtm rdseed adx
        bogomips    : 4190.29
        clflush size    : 64
        cache_alignment : 64
        address sizes   : 42 bits physical, 48 bits virtual
        power management:

        processor   : 5
        vendor_id   : GenuineIntel
        cpu family  : 6
        model       : 79
        model name  : Intel(R) Xeon(R) CPU E5-4620 v4 @ 2.10GHz
        stepping    : 1
        microcode   : 184549409
        cpu MHz     : 2095.148
        cache size  : 25600 KB
        physical id : 2
        siblings    : 2
        core id     : 1
        cpu cores   : 2
        apicid      : 5
        initial apicid  : 5
        fpu     : yes
        fpu_exception   : yes
        cpuid level : 20
        wp      : yes
        flags       : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts xtopology tsc_reliable nonstop_tsc aperfmperf unfair_spinlock pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch ida arat epb xsaveopt pln pts dtherm invpcid_single fsgsbase bmi1 hle avx2 smep bmi2 invpcid rtm rdseed adx
        bogomips    : 4190.29
        clflush size    : 64
        cache_alignment : 64
        address sizes   : 42 bits physical, 48 bits virtual
        power management:

        processor   : 6
        vendor_id   : GenuineIntel
        cpu family  : 6
        model       : 79
        model name  : Intel(R) Xeon(R) CPU E5-4620 v4 @ 2.10GHz
        stepping    : 1
        microcode   : 184549409
        cpu MHz     : 2095.148
        cache size  : 25600 KB
        physical id : 3
        siblings    : 2
        core id     : 0
        cpu cores   : 2
        apicid      : 6
        initial apicid  : 6
        fpu     : yes
        fpu_exception   : yes
        cpuid level : 20
        wp      : yes
        flags       : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts xtopology tsc_reliable nonstop_tsc aperfmperf unfair_spinlock pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch ida arat epb xsaveopt pln pts dtherm invpcid_single fsgsbase bmi1 hle avx2 smep bmi2 invpcid rtm rdseed adx
        bogomips    : 4190.29
        clflush size    : 64
        cache_alignment : 64
        address sizes   : 42 bits physical, 48 bits virtual
        power management:

        processor   : 7
        vendor_id   : GenuineIntel
        cpu family  : 6
        model       : 79
        model name  : Intel(R) Xeon(R) CPU E5-4620 v4 @ 2.10GHz
        stepping    : 1
        microcode   : 184549409
        cpu MHz     : 2095.148
        cache size  : 25600 KB
        physical id : 3
        siblings    : 2
        core id     : 1
        cpu cores   : 2
        apicid      : 7
        initial apicid  : 7
        fpu     : yes
        fpu_exception   : yes
        cpuid level : 20
        wp      : yes
        flags       : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts xtopology tsc_reliable nonstop_tsc aperfmperf unfair_spinlock pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch ida arat epb xsaveopt pln pts dtherm invpcid_single fsgsbase bmi1 hle avx2 smep bmi2 invpcid rtm rdseed adx
        bogomips    : 4190.29
        clflush size    : 64
        cache_alignment : 64
        address sizes   : 42 bits physical, 48 bits virtual
        power management:
        ```

