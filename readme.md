  这是我研一的时候，用bash写的一个脚本,  
用来将POSCAR文件按需求，  
固定所需要的原子坐标， 
需要POSCAR文件，  
算完后会输出new-poscar  
使用方法： 在文件夹中同时有poscar 和result.sh  
执行
```
./result.sh
```
##在下面的代码为主函数，需要根据自己的需求改
```
judge1=0.1
judge2=0.2
 ```

其中
```
judge1=0.1
 ```
表示，在z坐标为0~0.1的范围内，原子全部F F F固定   

 ```
judge2=0.2    
 ```
表示
在z坐标为0.1~0.2的范围内，原子全部F F F 固定   
那么剩下的0.2~1的范围内，原子全部T T T 固定   

也就是说根据，judge1，judge2将原子分为了三类
```
for((i=1;i<=$atoms;i++))
do
	zz=` sed -n ${i}p poscar1 |awk '{print $3}'`
	if [ $(echo "$zz < $judge1" |bc) -eq 1 ]
	then
		sed -i "${i}s/$/\ \ \ F\ \ F\ \ F/g" poscar1
	else
		if [ $(echo "$zz < $judge2" |bc) -eq 1 ]
		then
			sed -i "${i}s/$/\ \ \ F\ \ F\ \ T/g" poscar1
		else
			sed -i "${i}s/$/\ \ \ T\ \ T\ \ T/g" poscar1
		fi
	fi
done
```
根据自己的需求改，代码中的
```
sed -i "${i}s/$/\ \ \ F\ \ F\ \ F/g" poscar1
```
这句修改在原子后添加什么

另外对于linux下的文件，最好在linux下使用vi编辑命令修改相关内容，  
虽然在windows下使用EditPlus、notepad++的FTP插件可以方便对Linux下文件进行编辑，  
但这也很有可能会使得修改后上传上去的文件格式发生变化从而导致相关服务报错。  
当然，如果修改的内容过于繁杂，为了提高工作效率，可以在windows下进行编辑，  
但上传后建议用如下命令转换一下文件格式   
```
sed -i 's/^M//g' POSCAR
```
本脚本第一句已经包含这个命令
