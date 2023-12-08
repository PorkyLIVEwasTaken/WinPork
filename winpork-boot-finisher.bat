@echo off
echo [[94mSTART[0m] Preparing WinPork command center...
echo [[96mPERFORM[0m] Move current dir to C:\...
cd C:\
echo [[96mPERFORM[0m] Size window with parms [cols=225 lines=60]...
mode con: cols=208 lines=54 
echo [[96mPERFORM[0m] Rewrite prompt to string [WINPORK $P$$]...
prompt WINPORK $P$$

if %wpsettings_UseWP_Theme% == "true" (
	echo [[96mPERFORM[0m] Apply theme [fd]...
	color fd
) else (
	echo [[33mWARN[0m] Settings dictated that the Windows CMD theme should be used, skipping...
)

echo [[96mPERFORM[0m] Set window title [WinPork RTE]...
title WinPork RTE
echo [[92mSUCCESS[0m] Prepared WinPork command center!
cls



echo [[96mPERFORM[0m] Log in system...
title WinPork RTE (Use ALT+F4 to reboot to Windows...)
:usernotexist
set /p logonusername=Username: 
if exist C:\WinPork\wp\users\%logonusername% (
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
< "C:\WinPork\wp\users\%logonusername%\shdw\passwd.wpshdw" set /p verifypassword=

if %logonpassword% == %verifypassword% (
    goto logoncontinue
) else (
    echo Incorrect password!
	goto :incorrectpassword
)

< "C:\WinPork\wp\users\%logonusername%\shdw\uuid.wpuser" set /p wpUUID=

:logoncontinue
cls
title WinPork RTE
powershell write-host -fore White -back Magenta Welcome to WinPork!
echo Type "nogui" for a list of available WinPork commands.