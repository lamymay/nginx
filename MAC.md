


chmod a+x kill_by_port

//http://127.0.0.1:80001
//http://y8hapn.natappfree.cc
//kill_by_port

又:
    这是找到的脚本， 和你发我的一样， 应该也要赋权限就能执行了

又:
    chmod a+x kill_by_port


#!/bin/bash
read -p "输入 你要kill的端口号: " a

for i in `lsof -i:$a | awk '{print $2}' | grep -v 'PID'`;do kill -9 $i;done



1、查询端口
lsof -i :端口
2、杀掉端口
kill -9 进程ID
