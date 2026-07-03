@echo off
REM 使用前先将以下路径改为你自己的安装路径

set JAVA_HOME=D:\qjp\jdk\jdk-21.0.10
set Path=E:\qjp\Programs\gstreamer\1.0\msvc_x86_64\bin;%Path%

call .\gradlew.bat --stop 2>nul
call .\gradlew.bat bootRun
pause
