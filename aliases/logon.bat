@echo off
cls
echo [[96mPERFORM[0m] Log in system...
:usernotexist
set /p logonusername=Username: 
if exist C:\WinPork\saved\wpstorage\wp\users\%logonusername% (
    goto :usernameexists
) else (
    echo User does not exist!
    goto :usernotexist
)
:usernameexists

:incorrectpassword
set /p logonpassword=Password: 

set "verifypassword="

rem Read the content of the file into the variable
< "C:\WinPork\saved\wpstorage\wp\users\%logonusername%\shdw\passwd.wpshdw" set /p verifypassword=

if %logonpassword% == %verifypassword% (
    cls
    powershell write-host -fore White -back Magenta Welcome to WinPork!
    echo Type "nogui" for a list of available WinPork commands.
    exit /b 0
) else (
    echo Incorrect password!
	goto :incorrectpassword
)