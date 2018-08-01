1. 查看当前公司用版本号。  
`db.runCommand({"buildInfo":1}) `   结果:`3.0.15`        
1. 部署replica-set模式。    
1. 建表。   
1. 导入数据。   
1. 重启。   









1. replica-set模式primary挂了，secondary会自动将一个成员升级为primary。   
