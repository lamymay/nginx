@echo off
REM 后续命令使用的是：UTF-8编码
chcp 65001
echo 测试杀死名字为"nginx.EXE"的所有进程
nginx -s quit
echo \n OK \n 按任意键退出
pause
