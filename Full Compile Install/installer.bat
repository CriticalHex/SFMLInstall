@echo off
rem ^^^ this disables the script literally putting every line into the console,
rem echo is also like print, the @ signifies that a line shouldn't be echoed, and that line essentially prepends all commands with an @
rem (rem) is the comment "character"
net session 1>nul 2>&1
rem this: runs an admin only command, pipes the stdout (1) into nul, and the stderr (2) into 1, making nothing output.
rem you don't need to specify the 1 for nul, I do here to explain it
if %ErrorLevel% == 0 ( set admin=true ) else ( set admin=false )
rem this checks if the last run command errored, using the existing ErrorLevel
rem variable. Variables are accessed by surrounding them in % signs. I've denoted existing environment variables by capitalizing the first letter,
rem while not doing that for my own. I don't think any of the variables are actually case sensitive.

rem (set) is how you assign variables, everything is technically a string, so the quote surrounding the variable name and the value actually signifies
rem that there are likely confusing characters in the value, like a space for example would break it. Most of these probably don't need the quotes.
set "gitDownloadLink=https://github.com/git-for-windows/git/releases/download/v2.44.0.windows.1/Git-2.44.0-64-bit.exe"
set "gitDownloadLoc=C:%HomePath%\Downloads\gitinstaller.exe"
rem but gitStartLoc does, because Start Menu has a space. And the ones with variables defining them just COULD, so gotta be careful.
set "adminGitStartLoc=C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Git"
set "noAdminGitStartLoc=C:\Users\kubas\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Git"
set "adminGitLoc=%ProgramFiles%\Git\cmd\git.exe"
set "noAdminGitLoc=%LocalAppData%\Programs\Git\cmd\git.exe"

set "sfmlGitLink=https://github.com/SFML/SFML.git"
set "sfmlCloneLoc=C:\temp\SFML"
rem things in temp get deleted when the system restarts. This script will build SFML from here, and move the requisite files.
set "sfmlInstallLoc=C:\mingw64\include\SFML"

if %admin% == true (
  rem checking if the folder exists. Works on files and folders. Can also use the * symbol to denote a pattern match.
  rem An example of the * pattern is: "C:\Python*" would find a folder in C: called Python 3.11.
  if not exist "%adminGitStartLoc%" (
    if not exist "%gitDownloadLoc%" (
      echo Downloading git from %gitDownloadLink%...
      powershell -Command "Invoke-WebRequest -Uri %gitDownloadLink% -OutFile %gitDownloadLoc%"
      rem the above command is structured as: application {options} {arguments}. Most if not all commands are structured this way.
      rem Options can usually go before or after the arguments, because they have something denoting them, like a slash or a dash.
      rem in this case, powershell is the application (powershell.exe) where the .exe is ommited, the option is -Command, which
      rem denotes that we're using a powershell command, and the arguments are one string, the command, which is a powershell
      rem command that downloads a file from a link, specifying where it should go, and what it should be named.
    )
    if not exist "%adminGitLoc%" (
      echo Pick all defaults for the git installation!
      "%gitDownloadLoc%"
    )
    if not exist %sfmlInstallLoc% ( "%adminGitLoc%" clone %sfmlGitLink% %sfmlCloneLoc% )
  ) 
) else (
  if not exist "%noAdminGitStartLoc%" (
    if not exist "%gitDownloadLoc%" (
      echo Downloading git from %gitDownloadLink%...
      powershell -Command "Invoke-WebRequest -Uri %gitDownloadLink% -OutFile %gitDownloadLoc%"
    )
    if not exist "%noAdminGitLoc%" (
      echo Pick all defaults for the git installation!
      "%gitDownloadLoc%"
    )
    if not exist %sfmlInstallLoc% ( "%noAdminGitLoc%" clone %sfmlGitLink% %sfmlCloneLoc% )
  )
)
rem if git complains that SFML already exists, don't worry about it. I'm checking if the full install worked
rem to clone, not whether or not I already cloned.


set "w64DownloadLink=https://github.com/skeeto/w64devkit/releases/download/v1.21.0/w64devkit-1.21.0.zip"
set "w64DownloadLoc=C:%HomePath%\Downloads\web64devkit.zip"
set "webKitLoc=C:\mingw64"

if not exist %webKitLoc% (
  if not exist "%w64DownloadLoc%" (
    echo Downloading w64devkit very slowly from %w64DownloadLink%...
    powershell -Command "Invoke-WebRequest -Uri %w64DownloadLink% -OutFile %w64DownloadLoc%"
  )
  echo Extracting the zip...
  powershell -Command "Expand-Archive %w64DownloadLoc% C:\\"
  rem powershell commmand to unzip a file.
  move C:\w64devkit %webKitLoc% >nul
  rem (move) does a few things, it can move files, and rename them, which is what's happening here.
  echo Remember to add %webKitLoc%\bin to your system path!
)

set "cmakeDownloadLink=https://github.com/Kitware/CMake/releases/download/v3.29.0-rc4/cmake-3.29.0-rc4-windows-x86_64.zip"
set "cmakeDownloadLoc=C:%HomePath%\Downloads\CMake.zip"
set "cmakeLoc=C:\CMake"
set "cmakeUnzip=C:\cmake-3.29.0-rc4-windows-x86_64"

if not exist "%cmakeLoc%" (
  if not exist "%cmakeDownloadLoc%" (
    echo Downloading cmake very slowly from %cmakeDownloadLink%...
    powershell -Command "Invoke-WebRequest -Uri %cmakeDownloadLink% -OutFile %cmakeDownloadLoc%"
  )
  echo Extracting the zip...
  powershell -Command "Expand-Archive %cmakeDownloadLoc% C:\\"
  move %cmakeUnzip% %cmakeLoc% >nul
  echo You should also add %cmakeLoc%\CMake to your system path!
)

rem these all have to be set outside the if statement, batch sucks, and setting and using variables
rem in one if statement doesn't work because it executes the entire block at once. There is a way around this,
rem "setlocal enabledelayedexpansion", but I don't want to use it, because I don't TOTALLY understand it

set "PATH=%PATH%;%webKitLoc%\bin"
rem temporarliy add to system path, as CMake needs the compiler there.

rem define build flags for SFML
set "buildType=-DCMAKE_BUILD_TYPE=Release"
set "installLoc=-DCMAKE_INSTALL_PREFIX=%webKitLoc%\include"
rem   ^^^ didn't work, leaving it there anyway
set "sharedLibs=-DBUILD_SHARED_LIBS=TRUE"
set "buildExamples=-DSFML_BUILD_EXAMPLES=FALSE"
set "buildDocs=-DSFML_BUILD_DOC=FALSE"
rem I'd like to build docs I think, but needs doxygen and I don't feel like it
set "buildAudio=-DSFML_BUILD_AUDIO=TRUE"
set "buildGraphics=-DSFML_BUILD_GRAPHICS=TRUE"
set "buildWindow=-DSFML_BUILD_WINDOW=TRUE"
set "buildNetwork=-DSFML_BUILD_NETWORK=TRUE"
set "useSysDeps=-DSFML_USE_SYSTEM_DEPS=FALSE"

set "make=%webKitLoc%\bin\mingw32-make.exe"
set "cmake=%cmakeLoc%\bin\cmake.exe"

set "sfmlBinS=%sfmlCloneLoc%\build\bin\*"
set "sfmlLibS=%sfmlCloneLoc%\build\lib\*"
set "sfmlIncludeS=%sfmlCloneLoc%\include\SFML"
set "sfmlBinD=%webKitLoc%\bin"
set "sfmlLibD=%webKitLoc%\lib"
set "sfmlIncludeD=%webKitLoc%\include"

set "cwd=%cd%"

if not exist %sfmlInstallLoc% (
  cd %sfmlCloneLoc%
  if not exist "%sfmlCloneLoc%\build" (
    mkdir build
  )
  cd build
  rem %cmake% -G"MinGW Makefiles" %buildType% %installLoc% %sharedLibs% %buildExamples% %buildDocs% %buildAudio% %buildGraphics% %buildWindow% %buildNetwork% %useSysDeps% -S%sfmlCloneLoc% -B%sfmlCloneLoc%\build
  rem %cmake% -G"MinGW Makefiles" -S%sfmlCloneLoc% -B%sfmlCloneLoc%\build
  %cmake% ..
  cmake --build . --config Release
  cd %cwd%
  move %sfmlBinS% %sfmlBinD% >nul
  move %sfmlLibS% %sfmlLibD% >nul
  move %sfmlIncludeS% %sfmlIncludeD% >nul
)

