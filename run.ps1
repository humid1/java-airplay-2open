# 使用前先将以下路径改为你自己的安装路径

$env:JAVA_HOME = 'D:\qjp\jdk\jdk-21.0.10'         # 改为你的 JDK 安装路径
$env:Path = "E:\qjp\Programs\gstreamer\1.0\msvc_x86_64\bin;$env:Path"  # 改为你的 GStreamer bin 目录

.\gradlew.bat --stop 2>$null
.\gradlew.bat bootRun
