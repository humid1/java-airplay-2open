# Java AirPlay Server

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](http://opensource.org/licenses/MIT)

Based on java-airplay, combining the following sub-projects into one:
- java-airplay-lib
- java-airplay-server
- java-airplay-server-examples

All code in one place for easier development and debugging.

## Disclaimer

1. **Educational Purpose Only**: This project is intended solely for learning, research, and technical exchange. **Commercial use or any illegal purpose is strictly prohibited.**
2. **User Responsibility**: Any legal consequences arising from the use of this software shall be borne by the user.
3. **No Warranty**: This software is provided "as is" without any express or implied warranty.
4. **Intellectual Property**: AirPlay is a trademark or registered trademark of Apple Inc. This project is not affiliated with, endorsed, or sponsored by Apple Inc.

## Prerequisites

### Required Software

| Component | Version | Notes |
|---|---|---|
| **JDK** | 17+ (recommended 21) | Download: [Adoptium Temurin](https://adoptium.net/) |
| **Gradle** | 8.5+ | Bundled via `gradlew.bat` (auto-downloaded, configured with mirror) |
| **GStreamer** (optional) | 1.28+ | Default player implementation, [download](https://gstreamer.freedesktop.org/download/#windows) choose **MSVC x86_64**, add `bin` to `PATH` |
| **FFmpeg** (optional) | any | Add `ffplay` directory to `PATH` |
| **VLC** (optional) | any | For testing only, unstable playback |

> The original project used Java 17 + Gradle 7.6. This fork has been upgraded to **JDK 21 + Gradle 8.5** with Alibaba Cloud Maven mirror configured for better network access in China.

### Quick Start Scripts

Two scripts are provided in the project root directory:

**PowerShell** — `run.ps1`:
```powershell
.\run.ps1
```

**CMD** — `run.bat`:
```cmd
run.bat
```

The scripts will:
1. Set `JAVA_HOME` to your JDK path
2. Add GStreamer's `bin` to `PATH` for native DLL loading
3. Stop old Gradle Daemon to avoid environment variable caching issues
4. Run `gradlew bootRun`

> **You must edit the script first** to set your own `JAVA_HOME` and GStreamer paths.

#### Manual Execution

**PowerShell:**
```powershell
$env:JAVA_HOME = 'your-jdk-path'         # e.g. D:\jdk\jdk-21
$env:Path = "your-gstreamer\bin;$env:Path"  # e.g. D:\gstreamer\1.0\msvc_x86_64\bin
.\gradlew.bat bootRun
```

**CMD:**
```cmd
set JAVA_HOME=your-jdk-path
set Path=your-gstreamer\bin;%Path%
.\gradlew.bat bootRun
```

## How to Run

### From Source

```shell
cd ./java-airplay
./gradlew bootRun
```

### Pre-built JAR

Download the latest release

```shell
java -jar java-airplay-server-{version}.jar
```

### Build Executable JAR

Use Gradle's `bootJar` task to build a Fat JAR (with all dependencies):

```shell
.\gradlew.bat :player:app:bootJar
```

Output: `player\app\build\libs\java-airplay-server-{version}.jar`

```shell
java -jar player\app\build\libs\java-airplay-server-1.0.7.jar
```

> Make sure `JAVA_HOME` points to JDK 21 and GStreamer is on `PATH` when running the JAR.

## Configuration

Create `application.properties` in the working directory

### Available Properties

```properties
# airplay
airplay.serverName=srzhka
airplay.width=1280
airplay.height=720
airplay.fps=24
# player (gstreamer, ffmpeg, vlc, h264-dump)
player.implementation=gstreamer
player.menu.enabled=true
player.gstreamer.swing=true
```

## Players

### GStreamer

Supports both video and audio (alac + aac_eld) streams <br>
GStreamer installation required (see https://github.com/gstreamer-java/gst1-java-core)

### FFmpeg

Supports video stream only; aac_eld requires ffmpeg compiled with `--enable-libfdk-aac` <br>
FFmpeg installation required, ffplay must be on PATH

### VLC

Playback stops after a few seconds <br>
VLC installation required

### h264-dump

Saves video stream to dump.h264 file

---

Based on [serezhka/java-airplay](https://github.com/serezhka/java-airplay)
