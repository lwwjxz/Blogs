1.  查找文件，统计文件数量，通配符执行shell文件。  

```shell
cd /data/workplus/Server || { echo '目录/data/workplus/Server不存在'; exit 1 ;}
# 当前工作目录
findDirStr="find . -maxdepth 1 -name \"$APP-*\" -type d"
echo $findDirStr
dirCount=$(echo $findDirStr "| wc -l" | sh)
echo $dirCount
if test 1 -eq "$dirCount" -o 0 -eq "$dirCount" 
then echo "找到$dirCount个目标目录"
else
	echo "异常:预期找到0个或1个目标目录，但是找到了$dirCount个"
	exit 1
fi

if test 1 -eq "$dirCount" 
then
	echo stop老的服务
	sh $APP-*/bin/stop.sh || { echo 'stop 原服务异常';}
	echo 删除原目录
	echo $findDirStr ' -exec rm -rf {} \;' | sh
else
	echo ""
fi

echo 开始解压新项目
tar -zxvf $APP-*.tar.gz

sh $APP-*/bin/start.sh || { echo "start服务异常"; exit 1;}

```
