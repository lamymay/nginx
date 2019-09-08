@echo off
REM 后续命令使用的是：UTF-8编码
chcp 65001
echo 测试杀死名port 443 的所有进程


setlocal enabledelayedexpansion
for /f "delims=  tokens=1" %%i in ('netstat -aon ^| findstr "443"') do (
set a=%%i
goto js
)
:js
taskkill /f /pid "!a:~71,5!"

echo \n OK \n 按任意键退出
pause>nul