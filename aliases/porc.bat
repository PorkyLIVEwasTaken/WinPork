@echo off
setlocal enabledelayedexpansion

rem Parse command and call appropriate function
if "%1" == "install" (
    call :install %*
) else if "%1" == "uninstall" (
    call :uninstall %*
) else if "%1" == "run" (
    call :run %*
) else if "%1" == "list" (
    call :list %*
) else if "%1" == "new" (
    call :new %*
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
echo [[96mPERFORM[0m] Installing files from %2 to %3...
powershell -command "(New-Object Net.WebClient).DownloadFileAsync('%2', 'C:\WinPork\aliases\.mod\%3.bat')"
REM bitsadmin /transfer "PorcJob" /download /priority normal "%2" "C:\WinPork\aliases\.mod\%3.bat"
echo [[92mSUCCESS[0m] Succesfully installed %2 to %3!

exit /b 0

:uninstall
rem Uninstallation logic
rem Syntax: porc.bat uninstall source_directory

rem Check if source and destination directories are provided
if "%2" == "" (
    echo Source directory not provided.
    exit /b 1
)

rem Uninstall file
echo [[96mPERFORM[0m] Uninstalling %2...
del "C:\WinPork\aliases\.mod\%2.bat"
echo [[92mSUCCESS[0m] Succesfully uninstalled %2!
exit /b 0

:run
rem Implementation for run command
C:\WinPork\aliases\.mod\%2
exit /b 0

:list
rem Implementation for list command
dir "C:\WinPork\aliases\.mod" /b
exit /b 0

:new
copy nul C:\WinPork\aliases\.mod\%1.bat
notepad.exe C:\WinPork\aliases\.mod\%1.bat
exit /b 0