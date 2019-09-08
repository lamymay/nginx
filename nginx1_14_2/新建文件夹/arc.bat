
@echo off

rem 这是单行注释，本行将不会显示，类似java中的 '//',只会输出下面是输出 hello world 字符串，
rem 类似 printf 函数，有时候也可以用于获取变量的字符串的值

rem 下面这个是用来阻止自动程序退出的，类似于程序挂起的功能，
rem 为的是双击运行这个程序时不会一闪而过看不到输出结果


rem 在中文windows系统中，如果一个文本文件是utf-8编码的，那么在cmd.exe命令行窗口（所谓的dos窗口）中不能正确显示文件中的内容。在默认情况下，命令行窗口中使用的代码页是中文或者美国的，即编码是中文字符集或者西文字符集。
rem 如果想正确显示UTF-8字符，可以按照以下步骤操作：
rem 1、打开CMD.exe命令行窗口
rem 2、通过 chcp命令改变代码页，UTF-8的代码页为65001

rem 后续命令使用的是：UTF-8编码
rem chcp 65001

rem chcp 65001  就是换成UTF-8代码页
rem chcp 936 可以换回默认的GBK
rem chcp 437 是美国英语  


echo hello world
echo 中文测试

pause



