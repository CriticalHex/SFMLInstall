@echo off
if exist "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Git" ( set "GIT=true" ) else set "GIT=false"
net session >nul 2>&1
if %errorLevel% == 0 (
    goto admin
) else (
    goto user
)

:admin
    echo You are an Admin!
    if %GIT% == false (
        if not exist C:%HOMEPATH%\Downloads\gitinstall.exe echo Downloading Git-CMD... && powershell -Command "Invoke-WebRequest -Uri https://github.com/git-for-windows/git/releases/download/v2.37.3.windows.1/Git-2.37.3-64-bit.exe -OutFile C:%HOMEPATH%\Downloads\gitinstall.exe"
        echo Pick all defaults for the git installation. && C:%HOMEPATH%\Downloads\gitinstall.exe
        cd C:%HOMEPATH%
        if not exist vcpkg\bootstrap-vcpkg.bat echo Cloning vcpkg... && "%ProgramFiles%\Git\cmd\git.exe" clone https://github.com/microsoft/vcpkg
    ) else (
        if not exist vcpkg\bootstrap-vcpkg.bat echo Cloning vcpkg... && git clone https://github.com/microsoft/vcpkg
    )
    goto finish

:user
    echo You are not an Admin!
    if %GIT% == false (
        if not exist C:%HOMEPATH%\Downloads\gitinstall.exe echo Downloading Git-CMD... && powershell -Command "Invoke-WebRequest -Uri https://github.com/git-for-windows/git/releases/download/v2.37.3.windows.1/Git-2.37.3-64-bit.exe -OutFile C:%HOMEPATH%\Downloads\gitinstall.exe"
        echo Pick all defaults for the git installation. && C:%HOMEPATH%\Downloads\gitinstall.exe
        cd C:%HOMEPATH%
        if not exist vcpkg\bootstrap-vcpkg.bat echo Cloning vcpkg... && %LOCALAPPDATA%\Programs\Git\cmd\git.exe clone https://github.com/microsoft/vcpkg
    ) else (
        cd C:%HOMEPATH%
        if not exist vcpkg\bootstrap-vcpkg.bat echo Cloning vcpkg... && git clone https://github.com/microsoft/vcpkg
    )
    goto finish

    PAUSE
:finish
    cd vcpkg
    if not exist vcpkg.exe call bootstrap-vcpkg.bat
    vcpkg install sfml:x64-windows
    vcpkg integrate install
    PAUSE