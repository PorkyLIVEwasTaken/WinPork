@echo off
echo [[94mSTART[0m] WinPork User Wizard

if %RAC%==1 (
	goto :RAC
)

REM 1=NORMAL/quick
REM 2=Username
REM 3=HasPassword{y/N}
REM 4=IsAdmin?{y/N}

goto :mode%1

:mode
echo Logged in as %logonusername%
exit /b 0

:modenewuser
:modeadduser
setlocal enabledelayedexpansion
set /p username="[[1;95mQUEST[0m] What would you like to be the name of the new user? "
set /p password="[[1;95mQUEST[0m] What would you like to be the password of the new user? "

mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\cnfg
mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\docs
mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\home
mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\imgs
mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\root
mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\shdw
mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\trsh
mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\vids
mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\msic
set wp_verification=WPRTE:%random%:%random%:%random%:%random%:%random%
echo %wp_verification% > "C:\WinPork\saved\wpstorage\wp\users\%username%\shdw\uuid.wpuser"
@echo %password% > "C:\WinPork\saved\wpstorage\wp\users\%username%\shdw\passwd.wpshdw"
@attrib +r +h C:\WinPork\saved\wpstorage\wp\users\%username%\shdw/passwd.wpshdw
@attrib +r +h C:\WinPork\saved\wpstorage\wp\users\%username%\shdw/uuid.wpuser
echo [[92mSUCCESS[0m] User %username% has been created.
endlocal
exit /b 0

:modesetpasswd
setlocal enabledelayedexpansion
set /p password="[[1;95mQUEST[0m] What would you like to be the password of the new user? "
@echo %password% > C:\WinPork\saved\wpstorage\wp\users\%logonusername%\shdw\passwd.wpshdw
@attrib +r +h C:\WinPork\saved\wpstorage\wp\users\%logonusername%\shdw\passwd.wpshdw
echo [[92mSUCCESS[0m] Password for user %logonusername% has been changed.
endlocal
exit /b 0

:modedeluser
if %logonusername% == su (
set /p username="[[1;95mQUEST[0m] What is the name of the user that has to be deleted? "
if %username% == su (
    echo [[91mFAIL[0m] You cannot delete the Super-User!
) else (
choice /m "Are you sure you want to delete this user? " /d N /t 10 /c NY
if %errorlevel% == 1 (
        echo [[91mFAIL[0m] User cancelled command, or command timed out.
) else (
    rmdir /s /q C:\WinPork\saved\wpstorage\wp\users\%username%
    echo [[92mSUCCESS[0m] User %username% has been removed.
)
)
) else (
    echo [[91mFAIL[0m] You need to be logged in as the Super-User to do this!
)

:modeconvuser
set /p username="[[1;95mQUEST[0m] What is the name of the user that needs to be converted to a Windows account? "
if %username% == su (
    echo [[91mFAIL[0m] The Super-User cannot be converted to a Windows account!
) else (
    echo [[94mSTART[0m] Convert User (WinPork -> Windows)
	net user /add %username%
	
	mklink /D "C:\Users\%username%\Desktop" "C:\Users\Default\Desktop"
    mklink /D "C:\Users\%username%\Documents" "C:\Users\Default\Documents"
    mklink /D "C:\Users\%username%\Downloads" "C:\Users\Default\Downloads"
    mklink /D "C:\Users\%username%\Music" "C:\Users\Default\Music"
    mklink /D "C:\Users\%username%\Pictures" "C:\Users\Default\Pictures"
	mklink /D "C:\Users\%username%\Videos" "C:\Users\Default\Videos"
	
	xcopy "C:\WinPork\saved\wpstorage\wp\users\%username%\cnfg\" "C:\Users\%username%\Desktop\wp-config\" /e /i /h /c /k /y
	xcopy "C:\WinPork\saved\wpstorage\wp\users\%username%\docs\" "C:\Users\%username%\Documents\" /e /i /h /c /k /y
	xcopy "C:\WinPork\saved\wpstorage\wp\users\%username%\home\" "C:\Users\%username%\Desktop\" /e /i /h /c /k /y
	xcopy "C:\WinPork\saved\wpstorage\wp\users\%username%\imgs\" "C:\Users\%username%\Pictures\" /e /i /h /c /k /y
	xcopy "C:\WinPork\saved\wpstorage\wp\users\%username%\msic\" "C:\Users\%username%\Music\" /e /i /h /c /k /y
	xcopy "C:\WinPork\saved\wpstorage\wp\users\%username%\root\" "C:\Users\%username%\" /e /i /h /c /k /y
	xcopy "C:\WinPork\saved\wpstorage\wp\users\%username%\shdw\" "C:\Users\%username%\.shadow\" /e /i /h /c /k /y
	@attrib +r +h "C:\users\%username%\.shadow"
	xcopy "C:\WinPork\saved\wpstorage\wp\users\%username%\vids\" "C:\Users\%username%\Videos\" /e /i /h /c /k /y
	
	echo [[92mSUCCESS[0m] User %username% has been converted to a Windows account.
	exit /b 0
)





:RAC
goto :modeRAC%1

:modeRACnewuser
:modeRACadduser
setlocal enabledelayedexpansion
set /p username="[[1;95mQUEST[0m] What would you like to be the name of the new user? "
set /p password="[[1;95mQUEST[0m] What would you like to be the password of the new user? "

mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\cnfg
mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\docs
mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\home
mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\imgs
mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\root
mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\shdw
mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\trsh
mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\vids
mkdir C:\WinPork\saved\wpstorage\wp\users\%username%\msic
set wp_verification=WPRAC:%random%:%random%:%random%:%random%:%random%
echo %wp_verification% > "C:\WinPork\saved\wpstorage\wp\users\%username%\shdw\uuid.wpuser"
@echo %password% > "C:\WinPork\saved\wpstorage\wp\users\%username%\shdw\passwd.wpshdw"
@attrib +r +h C:\WinPork\saved\wpstorage\wp\users\%username%\shdw/passwd.wpshdw
@attrib +r +h C:\WinPork\saved\wpstorage\wp\users\%username%\shdw/uuid.wpuser
echo [[92mSUCCESS[0m] User %username% has been created.
endlocal
exit /b 0

:modeRACsetpasswd
setlocal enabledelayedexpansion
set /p password="[[1;95mQUEST[0m] What would you like to be the password of the new user? "
@echo %password% > C:\WinPork\saved\wpstorage\wp\users\%logonusername%\shdw\passwd.wpshdw
@attrib +r +h C:\WinPork\saved\wpstorage\wp\users\%logonusername%\shdw\passwd.wpshdw
echo [[92mSUCCESS[0m] Password for user %logonusername% has been changed.
endlocal
exit /b 0

:modeRACdeluser
if %logonusername% == su (
set /p username="[[1;95mQUEST[0m] What is the name of the user that has to be deleted? "
if %username% == su (
    echo [[91mFAIL[0m] You cannot delete the Super-User!
) else (
choice /m "Are you sure you want to delete this user? " /d N /t 10 /c NY
if %errorlevel% == 1 (
        echo [[91mFAIL[0m] User cancelled command, or command timed out.
) else (
    rmdir /s /q C:\WinPork\saved\wpstorage\wp\users\%username%
    echo [[92mSUCCESS[0m] User %username% has been removed.
)
)
) else (
    echo [[91mFAIL[0m] You need to be logged in as the Super-User to do this!
)

:modeRACconvuser
set /p username="[[1;95mQUEST[0m] What is the name of the user that needs to be converted to a Windows account? "
if %username% == su (
    echo [[91mFAIL[0m] The Super-User cannot be converted to a Windows account!
) else (
    echo [[94mSTART[0m] Convert User (WinPork -> Windows)
	net user /add %username%
	
	mklink /D "C:\Users\%username%\Desktop" "C:\Users\Default\Desktop"
    mklink /D "C:\Users\%username%\Documents" "C:\Users\Default\Documents"
    mklink /D "C:\Users\%username%\Downloads" "C:\Users\Default\Downloads"
    mklink /D "C:\Users\%username%\Music" "C:\Users\Default\Music"
    mklink /D "C:\Users\%username%\Pictures" "C:\Users\Default\Pictures"
	mklink /D "C:\Users\%username%\Videos" "C:\Users\Default\Videos"
	
	xcopy "C:\WinPork\saved\wpstorage\wp\users\%username%\cnfg\" "C:\Users\%username%\Desktop\wp-config\" /e /i /h /c /k /y
	xcopy "C:\WinPork\saved\wpstorage\wp\users\%username%\docs\" "C:\Users\%username%\Documents\" /e /i /h /c /k /y
	xcopy "C:\WinPork\saved\wpstorage\wp\users\%username%\home\" "C:\Users\%username%\Desktop\" /e /i /h /c /k /y
	xcopy "C:\WinPork\saved\wpstorage\wp\users\%username%\imgs\" "C:\Users\%username%\Pictures\" /e /i /h /c /k /y
	xcopy "C:\WinPork\saved\wpstorage\wp\users\%username%\msic\" "C:\Users\%username%\Music\" /e /i /h /c /k /y
	xcopy "C:\WinPork\saved\wpstorage\wp\users\%username%\root\" "C:\Users\%username%\" /e /i /h /c /k /y
	xcopy "C:\WinPork\saved\wpstorage\wp\users\%username%\shdw\" "C:\Users\%username%\.shadow\" /e /i /h /c /k /y
	@attrib +r +h "C:\users\%username%\.shadow"
	xcopy "C:\WinPork\saved\wpstorage\wp\users\%username%\vids\" "C:\Users\%username%\Videos\" /e /i /h /c /k /y
	
	echo [[92mSUCCESS[0m] User %username% has been converted to a Windows account.
	exit /b 0
)