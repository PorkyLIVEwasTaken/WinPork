@echo off
echo [[94mSTART[0m] WinPork User Wizard

REM 1=NORMAL/quick
REM 2=Username
REM 3=HasPassword{y/N}
REM 4=IsAdmin?{y/N}

goto :mode%1

:modeadduser
set /p username="[[1;95mQUEST[0m] What would you like to be the name of the new user? "

mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\cnfg
mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\docs
mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\home
mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\imgs
mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\root
mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\shdw
mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\trsh
mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\vids
mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\msic
echo [[92mSUCCESS[0m] User %username% has been created.
exit /b 0



:modedeluser
set /p username="[[1;95mQUEST[0m] What is the name of the user that has to be deleted? "
choice /m "Are you sure you want to delete this user? " /d N /t 10

if %errorlevel% == 1 (
    rmdir C:\WinPork\saved\wpstorage\wp\users\%username%
	echo [[92mSUCCESS[0m] User %username% has been removed.
) else (
    echo [[91mFAIL[0m] User cancelled command, or command timed out.
)