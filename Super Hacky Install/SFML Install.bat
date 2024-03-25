@echo off

Rem Download, Install, and Extract SFML to the DEFAULT REPOSITORY FILE -----------------------------------------------
if not exist C:%homepath%\Downloads\SFML.zip powershell -Command "Invoke-WebRequest -Uri https://www.sfml-dev.org/files/SFML-2.5.1-windows-vc15-64-bit.zip -OutFile C:%homepath%\Downloads\SFML.zip"
if not exist C:%homepath%\source\repos\SFML-2.5.1\readme.md powershell -Command "Expand-Archive C:%homepath%\Downloads\SFML.zip C:%homepath%\source\repos"

Rem Ask for NAME of Solution in which to Install SFML ----------------------------------------------------------------
set /p NAME=Enter the name of your solution EXACTLY: 

Rem Copy Include and Lib Folders to Solution Directory ---------------------------------------------------------------
if exist "C:%homepath%\source\repos\%NAME%\lib\ogg.lib" goto :dll
xcopy /E /I C:%homepath%\source\repos\SFML-2.5.1\lib "C:%homepath%\source\repos\%NAME%\lib"
xcopy /E /I C:%homepath%\source\repos\SFML-2.5.1\include "C:%homepath%\source\repos\%NAME%\include"

:dll
Rem Copy dll's to x64 Debug and Release Folders ----------------------------------------------------------------------
if exist "C:%homepath%\source\repos\%NAME%\x64\Debug\openal32.dll" goto :path
copy C:%homepath%\source\repos\SFML-2.5.1\bin\openal32.dll "C:%homepath%\source\repos\%NAME%\x64\Debug\"
copy C:%homepath%\source\repos\SFML-2.5.1\bin\sfml-system-d-2.dll "C:%homepath%\source\repos\%NAME%\x64\Debug\"
copy C:%homepath%\source\repos\SFML-2.5.1\bin\sfml-graphics-d-2.dll "C:%homepath%\source\repos\%NAME%\x64\Debug\"
copy C:%homepath%\source\repos\SFML-2.5.1\bin\sfml-window-d-2.dll "C:%homepath%\source\repos\%NAME%\x64\Debug\"
copy C:%homepath%\source\repos\SFML-2.5.1\bin\sfml-audio-d-2.dll "C:%homepath%\source\repos\%NAME%\x64\Debug\"
copy C:%homepath%\source\repos\SFML-2.5.1\bin\sfml-network-d-2.dll "C:%homepath%\source\repos\%NAME%\x64\Debug\"
copy C:%homepath%\source\repos\SFML-2.5.1\bin\openal32.dll "C:%homepath%\source\repos\%NAME%\x64\Release\"
copy C:%homepath%\source\repos\SFML-2.5.1\bin\sfml-system-2.dll "C:%homepath%\source\repos\%NAME%\x64\Release\"
copy C:%homepath%\source\repos\SFML-2.5.1\bin\sfml-graphics-2.dll "C:%homepath%\source\repos\%NAME%\x64\Release\"
copy C:%homepath%\source\repos\SFML-2.5.1\bin\sfml-window-2.dll "C:%homepath%\source\repos\%NAME%\x64\Release\"
copy C:%homepath%\source\repos\SFML-2.5.1\bin\sfml-audio-2.dll "C:%homepath%\source\repos\%NAME%\x64\Release\"
copy C:%homepath%\source\repos\SFML-2.5.1\bin\sfml-network-2.dll "C:%homepath%\source\repos\%NAME%\x64\Release\"

:path
Rem Tell VS2019 Where Libraries and Include Are :( -------------------------------------------------------------------
REM Debug 32----------------------------------------------------------------------------------------------------------
set "SetLine=      <AdditionalIncludeDirectories>$(SolutionDir)\include;%%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>"
set ReplaceLine=91
set /A ContinueLine=%ReplaceLine%
set /A ContinueLine-=1
set InFile=C:%homepath%\source\repos\%NAME%\%NAME%.vcxproj
set TempFile=Temp.vcxproj
if exist "%TempFile%" del "%TempFile%"

setlocal enabledelayedexpansion
set /A Cnt=1
for /F "tokens=* usebackq delims=" %%a in ("%InFile%") do (
   >>"%TempFile%" echo.%%a
   set /A Cnt+=1
   if !Cnt! GEQ %ReplaceLine% GOTO :ExitLoop
   )
:ExitLoop

echo !SetLine!>>"%TempFile%"
more +%ContinueLine% < "%InFile%">> "%TempFile%"
copy /y "%TempFile%" "%InFile%"
del "%TempFile%"
endlocal

set "SetLine1=      <AdditionalLibraryDirectories>$(SolutionDir)\lib;%%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>"
set "SetLine2=      <AdditionalDependencies>sfml-system-d.lib;sfml-graphics-d.lib;sfml-window-d.lib;sfml-audio-d.lib;sfml-network-d.lib;%%(AdditionalDependencies)</AdditionalDependencies>"
set ReplaceLine=96
set /A ContinueLine=%ReplaceLine%
set /A ContinueLine-=1
set InFile=C:%homepath%\source\repos\%NAME%\%NAME%.vcxproj
set TempFile=Temp.vcxproj
if exist "%TempFile%" del "%TempFile%"

setlocal enabledelayedexpansion
set /A Cnt=1
for /F "tokens=* usebackq delims=" %%a in ("%InFile%") do (
   >>"%TempFile%" echo.%%a
   set /A Cnt+=1
   if !Cnt! GEQ %ReplaceLine% GOTO :ExitLoop
   )
:ExitLoop

echo !SetLine1!>>"%TempFile%"
echo !SetLine2!>>"%TempFile%"
more +%ContinueLine% < "%InFile%">> "%TempFile%"
copy /y "%TempFile%" "%InFile%"
del "%TempFile%"
endlocal
REM Release 32 -------------------------------------------------------------------------------------------------------
set "SetLine=      <AdditionalIncludeDirectories>$(SolutionDir)\include;%%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>"
set ReplaceLine=108
set /A ContinueLine=%ReplaceLine%
set /A ContinueLine-=1
set InFile=C:%homepath%\source\repos\%NAME%\%NAME%.vcxproj
set LineFile=Lines.txt
set TempFile=Temp.vcxproj
if exist "%TempFile%" del "%TempFile%"

setlocal enabledelayedexpansion
set /A Cnt=1
for /F "tokens=* usebackq delims=" %%a in ("%InFile%") do (
   >>"%TempFile%" echo.%%a
   set /A Cnt+=1
   if !Cnt! GEQ %ReplaceLine% GOTO :ExitLoop
   )
:ExitLoop

echo !SetLine!>>"%TempFile%"
more +%ContinueLine% < "%InFile%">> "%TempFile%"
copy /y "%TempFile%" "%InFile%"
del "%TempFile%"
endlocal

set "SetLine1=      <AdditionalLibraryDirectories>$(SolutionDir)\lib;%%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>"
set "SetLine2=      <AdditionalDependencies>sfml-system.lib;sfml-graphics.lib;sfml-window.lib;sfml-audio.lib;sfml-network.lib;%%(AdditionalDependencies)</AdditionalDependencies>"
set ReplaceLine=115
set /A ContinueLine=%ReplaceLine%
set /A ContinueLine-=1
set InFile=C:%homepath%\source\repos\%NAME%\%NAME%.vcxproj
set TempFile=Temp.vcxproj
if exist "%TempFile%" del "%TempFile%"

setlocal enabledelayedexpansion
set /A Cnt=1
for /F "tokens=* usebackq delims=" %%a in ("%InFile%") do (
   >>"%TempFile%" echo.%%a
   set /A Cnt+=1
   if !Cnt! GEQ %ReplaceLine% GOTO :ExitLoop
   )
:ExitLoop

echo !SetLine1!>>"%TempFile%"
echo !SetLine2!>>"%TempFile%"
more +%ContinueLine% < "%InFile%">> "%TempFile%"
copy /y "%TempFile%" "%InFile%"
del "%TempFile%"
endlocal
REM Debug 64----------------------------------------------------------------------------------------------------------
set "SetLine=      <AdditionalIncludeDirectories>$(SolutionDir)\include;%%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>"
set ReplaceLine=125
set /A ContinueLine=%ReplaceLine%
set /A ContinueLine-=1
set InFile=C:%homepath%\source\repos\%NAME%\%NAME%.vcxproj
set LineFile=Lines.txt
set TempFile=Temp.vcxproj
if exist "%TempFile%" del "%TempFile%"

setlocal enabledelayedexpansion
set /A Cnt=1
for /F "tokens=* usebackq delims=" %%a in ("%InFile%") do (
   >>"%TempFile%" echo.%%a
   set /A Cnt+=1
   if !Cnt! GEQ %ReplaceLine% GOTO :ExitLoop
   )
:ExitLoop

echo !SetLine!>>"%TempFile%"
more +%ContinueLine% < "%InFile%">> "%TempFile%"
copy /y "%TempFile%" "%InFile%"
del "%TempFile%"
endlocal

set "SetLine1=      <AdditionalLibraryDirectories>$(SolutionDir)\lib;%%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>"
set "SetLine2=      <AdditionalDependencies>sfml-system-d.lib;sfml-graphics-d.lib;sfml-window-d.lib;sfml-audio-d.lib;sfml-network-d.lib;%%(AdditionalDependencies)</AdditionalDependencies>"
set ReplaceLine=130
set /A ContinueLine=%ReplaceLine%
set /A ContinueLine-=1
set InFile=C:%homepath%\source\repos\%NAME%\%NAME%.vcxproj
set TempFile=Temp.vcxproj
if exist "%TempFile%" del "%TempFile%"

setlocal enabledelayedexpansion
set /A Cnt=1
for /F "tokens=* usebackq delims=" %%a in ("%InFile%") do (
   >>"%TempFile%" echo.%%a
   set /A Cnt+=1
   if !Cnt! GEQ %ReplaceLine% GOTO :ExitLoop
   )
:ExitLoop

echo !SetLine1!>>"%TempFile%"
echo !SetLine2!>>"%TempFile%"
more +%ContinueLine% < "%InFile%">> "%TempFile%"
copy /y "%TempFile%" "%InFile%"
del "%TempFile%"
endlocal
REM Release 64--------------------------------------------------------------------------------------------------------
set "SetLine=      <AdditionalIncludeDirectories>$(SolutionDir)\include;%%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>"
set ReplaceLine=142
set /A ContinueLine=%ReplaceLine%
set /A ContinueLine-=1
set InFile=C:%homepath%\source\repos\%NAME%\%NAME%.vcxproj
set LineFile=Lines.txt
set TempFile=Temp.vcxproj
if exist "%TempFile%" del "%TempFile%"

setlocal enabledelayedexpansion
set /A Cnt=1
for /F "tokens=* usebackq delims=" %%a in ("%InFile%") do (
   >>"%TempFile%" echo.%%a
   set /A Cnt+=1
   if !Cnt! GEQ %ReplaceLine% GOTO :ExitLoop
   )
:ExitLoop

echo !SetLine!>>"%TempFile%"
more +%ContinueLine% < "%InFile%">> "%TempFile%"
copy /y "%TempFile%" "%InFile%"
del "%TempFile%"
endlocal

set "SetLine1=      <AdditionalLibraryDirectories>$(SolutionDir)\lib;%%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>"
set "SetLine2=      <AdditionalDependencies>sfml-system.lib;sfml-graphics.lib;sfml-window.lib;sfml-audio.lib;sfml-network.lib;%%(AdditionalDependencies)</AdditionalDependencies>"
set ReplaceLine=149
set /A ContinueLine=%ReplaceLine%
set /A ContinueLine-=1
set InFile=C:%homepath%\source\repos\%NAME%\%NAME%.vcxproj
set TempFile=Temp.vcxproj
if exist "%TempFile%" del "%TempFile%"

setlocal enabledelayedexpansion
set /A Cnt=1
for /F "tokens=* usebackq delims=" %%a in ("%InFile%") do (
   >>"%TempFile%" echo.%%a
   set /A Cnt+=1
   if !Cnt! GEQ %ReplaceLine% GOTO :ExitLoop
   )
:ExitLoop

echo !SetLine1!>>"%TempFile%"
echo !SetLine2!>>"%TempFile%"
more +%ContinueLine% < "%InFile%">> "%TempFile%"
copy /y "%TempFile%" "%InFile%"
del "%TempFile%"
endlocal
pause