@echo off
C:%homepath%\vcpkg\vcpkg remove sfml:x64-windows
rmdir C:%homepath%\vcpkg /S /Q
rmdir C:%homepath%\AppData\Local\vcpkg /S /Q
C:%homepath%\AppData\Local\Programs\Git\unins000.exe
rmdir C:%homepath%\AppData\Local\Programs\Git /S /Q
pause