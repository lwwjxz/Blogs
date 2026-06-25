[官方文档](https://help.aliyun.com/zh/sls/machine-group-and-collection-configuration-association-guide?spm=5176.30275541.J_ZGek9Blx07Hclc3Ddt9dg.84.4f4e2f3dO30pw5&scm=20140722.S_help@@%E6%96%87%E6%A1%A3@@2929843._.ID_help@@%E6%96%87%E6%A1%A3@@2929843-RL_slsuser~UND~defined~UND~id-LOC_2024SPAllResult-OR_ser-PAR1_0abb7ee217823542328518333ec348-V_4-PAR3_o-RE_new13-P0_1-P1_0)


```
# 配置阿里云账号id
RUN mkdir -p /etc/ilogtail/users/
RUN touch /etc/ilogtail/users/23232323  
# 上报所有机器组，可以配置多个机器组但必须保证已经在sls控制台上新增了同样名称的机器组
RUN mkdir -p /etc/ilogtail/
RUN echo -e "group1\ngroup2" >> /etc/ilogtail/user_defined_id
```
