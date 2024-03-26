@echo off
rem ^^^ this disables the script literally putting every line into the console,
rem echo is also like print, the @ signifies that a line shouldn't be echoed, and that line essentially prepends all commands with an @
rem 'rem' is the comment "character"
rem Variables are accessed by surrounding them in % signs. I've denoted existing environment variables by capitalizing the first letter,
rem while not doing that for my own. I don't think any of the variables are actually case sensitive.

rem 'set' is how you assign variables, everything is technically a string unless otherwise specified, so the quote surrounding both the
rem variable name and the value actually signifies that there are likely confusing characters in the value, like a space for example
rem would break it. Most of these probably don't need the quotes. The ones with variables defining them just COULD, so gotta be careful.

set "winLibsDownloadLink=https://github.com/brechtsanders/winlibs_mingw/releases/download/13.1.0-16.0.5-11.0.0-msvcrt-r5/winlibs-x86_64-posix-seh-gcc-13.1.0-mingw-w64msvcrt-11.0.0-r5.zip"
set "winLibsDownloadLoc=C:%HomePath%\Downloads\winlibs.zip"
set "winLibsLoc=C:\mingw64"

if not exist %winLibsLoc% (
  rem checking if the folder exists. Works on files and folders. Can also use the * symbol to denote a pattern match.
  rem An example of the * pattern is: "C:\Python*" would find a folder in C: called Python 3.11.
  if not exist "%winLibsDownloadLoc%" (
    echo Downloading winlibs from %winLibsDownloadLink%...
    powershell -Command "Invoke-WebRequest -Uri %winLibsDownloadLink% -OutFile %winLibsDownloadLoc%"
    rem the above command is structured as: application {options} {arguments}. Most if not all commands are structured this way.
    rem Options can usually go before or after the arguments, because they have something denoting them, like a slash or a dash.
    rem in this case, powershell is the application (powershell.exe) where the .exe is ommited, the option is -Command, which
    rem denotes that we're using a powershell command, and the arguments are one string, the command, which is a powershell
    rem command that downloads a file from a link, specifying where it should go, and what it should be named.
  )
  echo Extracting the zip...
  powershell -Command "Expand-Archive %winLibsDownloadLoc% C:\\"
  rem powershell commmand to unzip a file.
  echo Remember to add %winLibsLoc%\bin to your system path!
)

set "sfmlDownloadLink=https://www.sfml-dev.org/files/SFML-2.6.1-windows-gcc-13.1.0-mingw-64-bit.zip"
set "sfmlDownloadLoc=C:%HomePath%\Downloads\sfml.zip"
set "sfmlTempLoc=%Temp%"
rem Things in temp get deleted when the system restarts. We put SFML there, and move the requisite files.
set "sfmlFinLoc=%winLibsLoc%\include"
set "sfmlUnzip=SFML-2.6.1"

if not exist "%sfmlFinLoc%\SFML" (
  if not exist "%sfmlDownloadLoc%" (
    echo Downloading SFML from %sfmlDownloadLink%...
    powershell -Command "Invoke-WebRequest -Uri %sfmlDownloadLink% -OutFile %sfmlDownloadLoc%"
  )
  echo Extracting the zip...
  powershell -Command "Expand-Archive %sfmlDownloadLoc% %sfmlTempLoc%"
  move %sfmlTempLoc%\%sfmlUnzip%\include\SFML %winLibsLoc%\include\SFML >nul
  rem move moves files or folders, and can rename folders too. the >nul pipes the
  rem stdout into nothing so the command is quiet unless it errors. 2>nul would also silence the errors.
  rem the >nul is actually an implicit 1>nul. 1 is stdout, 2 is errout.
  move %sfmlTempLoc%\%sfmlUnzip%\bin\* %winLibsLoc%\bin >nul
  move %sfmlTempLoc%\%sfmlUnzip%\lib\* %winLibsLoc%\lib >nul
  del %sfmlTempLoc%\%sfmlUnzip% >nul
)