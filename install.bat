@echo off
if not exist C:%homepath%\AppData\Local\Programs\Git\git-cmd.exe echo Downloading Git-CMD... && powershell -Command "Invoke-WebRequest -Uri https://github.com/git-for-windows/git/releases/download/v2.37.3.windows.1/Git-2.37.3-64-bit.exe -OutFile C:%homepath%\Downloads\gitinstall.exe"
if not exist C:%homepath%\AppData\Local\Programs\Git\git-cmd.exe echo Pick all defaults for the git installation: && C:%homepath%\Downloads\gitinstall.exe && pause
if not exist C:%homepath%\vcpkg\vcpkg.exe echo Cloning vcpkg... && cd C:%homepath% && C:%homepath%\AppData\Local\Programs\Git\cmd\git clone https://github.com/microsoft/vcpkg && pause
if not exist C:%homepath%\vcpkg\vcpkg.exe cd C:%homepath%\vcpkg && bootstrap-vcpkg.bat
cd C:%homepath%\vcpkg
vcpkg install sfml:x64-windows
vcpkg integrate install
pause