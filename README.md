[**English**](README_EN.md) | **中文**

# Java AirPlay Server

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](http://opensource.org/licenses/MIT)

基于 `java-airplay` 构建，将以下子项目整合为一体：
- `java-airplay-lib`
- `java-airplay-server`
- `java-airplay-server-examples`

所有代码放在一起便于开发和调试。

## 免责声明

1. **学习研究目的**：本项目仅用于学习、研究和技术交流，**严禁用于任何商业用途或非法目的**。
2. **用户自负责任**：使用本软件产生的任何法律后果由使用者自行承担。
3. **无担保**：本软件按"原样"提供，不提供任何明示或暗示的保证。
4. **知识产权**：AirPlay 是 Apple Inc. 的商标或注册商标。本项目不隶属于 Apple Inc.，也未获得其认可或赞助。

## 环境要求

### 需要安装的内容

| 组件 | 版本要求 | 说明 |
|---|---|---|
| **JDK** | 17+（推荐 21） | 下载：[Adoptium Temurin](https://adoptium.net/) |
| **Gradle** | 8.5+ | 使用项目自带的 `gradlew.bat` 自动下载（已配置镜像加速） |
| **GStreamer**（可选） | 1.28+ | 默认播放器实现，[下载](https://gstreamer.freedesktop.org/download/#windows) 选择 **MSVC x86_64**，安装后将 `bin` 目录加入 `PATH` |
| **FFmpeg**（可选） | 任意版本 | 需将 `ffplay` 所在目录加入 `PATH` |
| **VLC**（可选） | 任意版本 | 仅用于测试，播放不稳定 |

> 原项目基于 Java 17 + Gradle 7.6，本分支已升级至 **JDK 21 + Gradle 8.5**，并配置了阿里云 Maven 镜像，国内网络可正常构建。

### 快速启动脚本

项目根目录提供了两个启动脚本（二选一）：

**PowerShell 用户** 使用 `run.ps1`：
```powershell
.\run.ps1
```

**CMD 用户** 双击或执行 `run.bat`：
```cmd
run.bat
```

脚本会自动完成以下操作：
1. 设置 `JAVA_HOME` 为 JDK 路径
2. 将 GStreamer 的 `bin` 目录加入 `PATH`，使 JVM 能加载原生 DLL
3. 停止旧的 Gradle Daemon，避免环境变量缓存问题
4. 执行 `gradlew bootRun` 启动应用

> **使用前必须先修改脚本**，将 `JAVA_HOME` 和 GStreamer 路径改为你自己的安装路径。

#### 手动执行（不依赖脚本）

**PowerShell：**
```powershell
$env:JAVA_HOME = '你的JDK安装路径'      # 例如 D:\jdk\jdk-21
$env:Path = "你的GStreamer\bin目录;$env:Path"  # 例如 D:\gstreamer\1.0\msvc_x86_64\bin
.\gradlew.bat bootRun
```

**CMD：**
```cmd
set JAVA_HOME=你的JDK安装路径
set Path=你的GStreamer\bin目录;%Path%
.\gradlew.bat bootRun
```

## 运行方式

### 从源码运行

```shell
git clone <your-repo-url>
cd java-airplay
./gradlew bootRun
```

### 使用预构建包

下载最新发布版本

```shell
java -jar java-airplay-server-{version}.jar
```

### 构建可执行 JAR

使用 Gradle 的 `bootJar` 任务打包为 Fat JAR（包含所有依赖）：

```shell
.\gradlew.bat :player:app:bootJar
```

打包后的 JAR 位于 `player\app\build\libs\java-airplay-server-{version}.jar`，可直接运行：

```shell
java -jar player\app\build\libs\java-airplay-server-1.0.7.jar
```

> 运行 JAR 时同样需要设置 `JAVA_HOME` 为 JDK 21，并确保 GStreamer 已在 `PATH` 中。

## 配置

在工作目录下创建 `application.properties` 文件

### 可用配置项

```properties
# airplay
airplay.serverName=srzhka
airplay.width=1280
airplay.height=720
airplay.fps=24
# 播放器实现（gstreamer、ffmpeg、vlc、h264-dump）
player.implementation=gstreamer
player.menu.enabled=true
player.gstreamer.swing=true
```

## 播放器

### GStreamer

支持视频和音频（alac + aac_eld）流 <br>
需要安装 GStreamer（参见 [gst1-java-core](https://github.com/gstreamer-java/gst1-java-core)）

### FFmpeg

仅支持视频流，aac_eld 音频需要编译 ffmpeg 时启用 `--enable-libfdk-aac` <br>
需要安装 FFmpeg，且 ffplay 必须位于 PATH 中

### VLC

播放几秒后停止 <br>
需要安装 VLC

### h264-dump

将视频流保存到 dump.h264 文件中

---

基于 [serezhka/java-airplay](https://github.com/serezhka/java-airplay) 修改
