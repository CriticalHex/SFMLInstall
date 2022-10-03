@echo off
if not exist %LOCALAPPDATA%\Programs\Git\cmd\git.exe echo Downloading Git-CMD... && powershell -Command "Invoke-WebRequest -Uri https://github.com/git-for-windows/git/releases/download/v2.37.3.windows.1/Git-2.37.3-64-bit.exe -OutFile C:%HOMEPATH%\Downloads\gitinstall.exe"
if not exist %LOCALAPPDATA%\Programs\Git\cmd\git.exe echo Pick all defaults for the git installation: && C:%HOMEPATH%\Downloads\gitinstall.exe
cd C:%HOMEPATH%
if not exist C:%HOMEPATH%\vcpkg\vcpkg.exe echo Cloning vcpkg... && %LOCALAPPDATA%\Programs\Git\cmd\git.exe clone https://github.com/microsoft/vcpkg
cd vcpkg
if not exist C:%HOMEPATH%\vcpkg\vcpkg.exe echo Wait for bootstrap... && call bootstrap-vcpkg.bat
vcpkg install sfml:x64-windows
vcpkg integrate install
PAUSE