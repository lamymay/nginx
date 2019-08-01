@echo off
REM 后续命令使用的是：UTF-8编码
chcp 65001
echo 测试杀死名字为"nginx.EXE"的所有进程
taskkill /fi "imagename eq nginx.EXE" /f

echo  OK poer by 'taskkill /fi "imagename eq nginx.EXE" /f'

nginx.exe -t

nginx.exe

pause
