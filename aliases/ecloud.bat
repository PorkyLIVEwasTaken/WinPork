@echo off
setlocal enabledelayedexpansion

rem Parse command and call appropriate function
if "%1" == "download" (
    call :install %*
REM ) else if "%1" == "remove" (
REM    call :uninstall %*
REM ) else if "%1" == "list" (
REM    call :list %*
 ) else (
    echo [[91mFAIL[0m] Unknown command: %1
    exit /b 1
)

exit /b 0

:install
rem Installation logic
rem Syntax: porc.bat install source_url destination_name (This assumes we are ONLY downloading new commands)

rem Check if source and destination directories are provided
if "%2" == "" (
    echo [[91mFAIL[0m] Source directory not provided.
    exit /b 1
)
if "%3" == "" (
    echo [[91mFAIL[0m] Destination directory not provided.
    exit /b 1
)

rem Copy files from source directory to destination directory
echo [[96mPERFORM[0m] Downloading files from %2 to %3...
powershell -command "(New-Object Net.WebClient).DownloadFile('%2', '%3')"
echo [[92mSUCCESS[0m] Succesfully downloaded %2 to %3!

exit /b 0

:uninstall
rem Uninstallation logic
rem Syntax: porc.bat uninstall source_directory

rem Check if source and destination directories are provided
if "%2" == "" (
    echo Source directory not provided.
    exit /b 1
)
