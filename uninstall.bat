@echo off
goto check_Permissions

:check_Permissions
    net session >nul 2>&1
    if %errorLevel% == 0 (
        goto admin
    ) else (
        goto user
    )

:admin
C:%homepath%\vcpkg\vcpkg remove sfml:x64-windows
rmdir C:%homepath%\vcpkg /S /Q
rmdir %LOCALAPPDATA%\vcpkg /S /Q
"%ProgramFiles%\Git\unins000.exe"
rmdir "%ProgramFiles%\Git" /S /Q
goto end

:user
C:%homepath%\vcpkg\vcpkg remove sfml:x64-windows
rmdir C:%homepath%\vcpkg /S /Q
rmdir %LOCALAPPDATA%\vcpkg /S /Q
%LOCALAPPDATA%\Programs\Git\unins000.exe
rmdir %LOCALAPPDATA%\Programs\Git /S /Q
goto end

:end
PAUSE