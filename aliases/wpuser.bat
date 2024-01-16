@echo off
echo [[94mSTART[0m] WinPork User Wizard

if %RAC% == 1 (
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
set /p wpusername="[[1;95mQUEST[0m] What would you like to be the name of the new user? "
set /p password="[[1;95mQUEST[0m] What would you like to be the password of the new user? "

mkdir C:\WinPork\wp\users\%wpusername%\cnfg
mkdir C:\WinPork\wp\users\%wpusername%\docs
mkdir C:\WinPork\wp\users\%wpusername%\home
mkdir C:\WinPork\wp\users\%wpusername%\imgs
mkdir C:\WinPork\wp\users\%wpusername%\root
mkdir C:\WinPork\wp\users\%wpusername%\shdw
mkdir C:\WinPork\wp\users\%wpusername%\trsh
mkdir C:\WinPork\wp\users\%wpusername%\vids
mkdir C:\WinPork\wp\users\%wpusername%\msic
set wp_verification=WPRTE:%random%:%random%:%random%:%random%:%random%
echo %wp_verification% > "C:\WinPork\wp\users\%wpusername%\shdw\uuid.wpuser"
@echo %password% > "C:\WinPork\wp\users\%wpusername%\shdw\passwd.wpshdw"
REM @attrib +r +h C:\WinPork\wp\users\%wpusername%\shdw/passwd.wpshdw
REM @attrib +r +h C:\WinPork\wp\users\%wpusername%\shdw/uuid.wpuser
echo [[92mSUCCESS[0m] User %wpusername% has been created.
endlocal
exit /b 0

:modesetpasswd
setlocal enabledelayedexpansion
set /p password="[[1;95mQUEST[0m] What would you like to be the password of the new user? "
@del C:\WinPork\wp\users\%logonusername%\shdw\passwd.wpshdw /f /a:h
@echo %password% > C:\WinPork\wp\users\%logonusername%\shdw\passwd.wpshdw
@attrib +r +h C:\WinPork\wp\users\%logonusername%\shdw\passwd.wpshdw
echo [[92mSUCCESS[0m] Password for user %logonusername% has been changed.
endlocal
exit /b 0

:modedeluser
if "%logonusername%" == "su" ( 
set /p wpusername="[[1;95mQUEST[0m] What is the name of the user that has to be deleted? "
if "%wpusername%" == "su" (
    echo [[91mFAIL[0m] You cannot delete the Super-User!
) else (
choice /m "Are you sure you want to delete this user? " /d N /t 10 /c NY
if %errorlevel% == 1 (
        echo [[91mFAIL[0m] User cancelled command, or command timed out.
		exit /b 0
) else (
    rmdir /s /q C:\WinPork\wp\users\%wpusername%
    echo [[92mSUCCESS[0m] User %wpusername% has been removed.
	exit /b 0
)
)
) else (
    echo [[91mFAIL[0m] You need to be logged in as the Super-User to do this!
	exit /b 0
)

:modeconvuser
set /p wpusername="[[1;95mQUEST[0m] What is the name of the user that needs to be converted to a Windows account? "
if "%wpusername%" == "su" (
    echo [[91mFAIL[0m] The Super-User cannot be converted to a Windows account!
	exit /b 0
) else (
    echo [[94mSTART[0m] Convert User (WinPork to Windows)
	net user /add %wpusername%
	
	mklink /D "C:\Users\%wpusername%\Desktop" "C:\Users\Default\Desktop"
    mklink /D "C:\Users\%wpusername%\Documents" "C:\Users\Default\Documents"
    mklink /D "C:\Users\%wpusername%\Downloads" "C:\Users\Default\Downloads"
    mklink /D "C:\Users\%wpusername%\Music" "C:\Users\Default\Music"
    mklink /D "C:\Users\%wpusername%\Pictures" "C:\Users\Default\Pictures"
	mklink /D "C:\Users\%wpusername%\Videos" "C:\Users\Default\Videos"
	
	xcopy "C:\WinPork\wp\users\%wpusername%\cnfg\" "C:\Users\%wpusername%\Desktop\wp-config\" /e /i /h /c /k /y
	xcopy "C:\WinPork\wp\users\%wpusername%\docs\" "C:\Users\%wpusername%\Documents\" /e /i /h /c /k /y
	xcopy "C:\WinPork\wp\users\%wpusername%\home\" "C:\Users\%wpusername%\Desktop\" /e /i /h /c /k /y
	xcopy "C:\WinPork\wp\users\%wpusername%\imgs\" "C:\Users\%wpusername%\Pictures\" /e /i /h /c /k /y
	xcopy "C:\WinPork\wp\users\%wpusername%\msic\" "C:\Users\%wpusername%\Music\" /e /i /h /c /k /y
	xcopy "C:\WinPork\wp\users\%wpusername%\root\" "C:\Users\%wpusername%\" /e /i /h /c /k /y
	xcopy "C:\WinPork\wp\users\%wpusername%\shdw\" "C:\Users\%wpusername%\.shadow\" /e /i /h /c /k /y
	@attrib +r +h "C:\users\%wpusername%\.shadow"
	xcopy "C:\WinPork\wp\users\%wpusername%\vids\" "C:\Users\%wpusername%\Videos\" /e /i /h /c /k /y
	
	echo [[92mSUCCESS[0m] User %wpusername% has been converted to a Windows account.
	exit /b 0
)





:RAC
goto :modeRAC%1

:modeRAC
echo Logged in as %username%
exit /b 0

:modeRACnewuser
:modeRACadduser
setlocal enabledelayedexpansion
set /p wpusername="[[1;95mQUEST[0m] What would you like to be the name of the new user? "
set /p password="[[1;95mQUEST[0m] What would you like to be the password of the new user? "

mkdir C:\WinPork\wp\users\%wpusername%\cnfg
mkdir C:\WinPork\wp\users\%wpusername%\docs
mkdir C:\WinPork\wp\users\%wpusername%\home
mkdir C:\WinPork\wp\users\%wpusername%\imgs
mkdir C:\WinPork\wp\users\%wpusername%\root
mkdir C:\WinPork\wp\users\%wpusername%\shdw
mkdir C:\WinPork\wp\users\%wpusername%\trsh
mkdir C:\WinPork\wp\users\%wpusername%\vids
mkdir C:\WinPork\wp\users\%wpusername%\msic
set wp_verification=WPRAC:%random%:%random%:%random%:%random%:%random%
echo %wp_verification% > "C:\WinPork\wp\users\%wpusername%\shdw\uuid.wpuser"
@echo %password% > "C:\WinPork\wp\users\%wpusername%\shdw\passwd.wpshdw"
@attrib +r +h C:\WinPork\wp\users\%wpusername%\shdw/passwd.wpshdw
@attrib +r +h C:\WinPork\wp\users\%wpusername%\shdw/uuid.wpuser
echo [[92mSUCCESS[0m] User %wpusername% has been created.
endlocal
exit /b 0

:modeRACsetpasswd
setlocal enabledelayedexpansion
set /p password="[[1;95mQUEST[0m] What would you like to be the password of the new user? "
@del C:\WinPork\wp\users\%logonusername%\shdw\passwd.wpshdw /f /a:h
@echo %password% > C:\WinPork\wp\users\%logonusername%\shdw\passwd.wpshdw
@attrib +r +h C:\WinPork\wp\users\%logonusername%\shdw\passwd.wpshdw
echo [[92mSUCCESS[0m] Password for user %logonusername% has been changed.
endlocal
exit /b 0

:modeRACdeluser
set /p wpusername="[[1;95mQUEST[0m] What is the name of the user that has to be deleted? "
if "%wpusername%" == "su" (
    echo [[91mFAIL[0m] You cannot delete the Super-User!
) else ( 
choice /m "Are you sure you want to delete this user? " /d N /t 10 /c NY
if %errorlevel% == 1 (
        echo [[91mFAIL[0m] User cancelled command, or command timed out.
		exit /b 0
) else (
    rmdir /s /q C:\WinPork\wp\users\%wpusername%
    echo SUCCESS: User %wpusername% has been removed.
	exit /b 0
)
)

:modeRACconvuser
set /p wpusername="[[1;95mQUEST[0m] What is the name of the user that needs to be converted to a Windows account? "
if "%wpusername%" == "su" (
    echo [[91mFAIL[0m] The Super-User cannot be converted to a Windows account!
	exit /b 0
) else (
    echo [[94mSTART[0m] Convert User (WinPork to Windows)
	net user /add %wpusername%
	
	mklink /D "C:\Users\%wpusername%\Desktop" "C:\Users\Default\Desktop"
    mklink /D "C:\Users\%wpusername%\Documents" "C:\Users\Default\Documents"
    mklink /D "C:\Users\%wpusername%\Downloads" "C:\Users\Default\Downloads"
    mklink /D "C:\Users\%wpusername%\Music" "C:\Users\Default\Music"
    mklink /D "C:\Users\%wpusername%\Pictures" "C:\Users\Default\Pictures"
	mklink /D "C:\Users\%wpusername%\Videos" "C:\Users\Default\Videos"
	
	xcopy "C:\WinPork\wp\users\%wpusername%\cnfg\" "C:\Users\%wpusername%\Desktop\wp-config\" /e /i /h /c /k /y
	xcopy "C:\WinPork\wp\users\%wpusername%\docs\" "C:\Users\%wpusername%\Documents\" /e /i /h /c /k /y
	xcopy "C:\WinPork\wp\users\%wpusername%\home\" "C:\Users\%wpusername%\Desktop\" /e /i /h /c /k /y
	xcopy "C:\WinPork\wp\users\%wpusername%\imgs\" "C:\Users\%wpusername%\Pictures\" /e /i /h /c /k /y
	xcopy "C:\WinPork\wp\users\%wpusername%\msic\" "C:\Users\%wpusername%\Music\" /e /i /h /c /k /y
	xcopy "C:\WinPork\wp\users\%wpusername%\root\" "C:\Users\%wpusername%\" /e /i /h /c /k /y
	xcopy "C:\WinPork\wp\users\%wpusername%\shdw\" "C:\Users\%wpusername%\.shadow\" /e /i /h /c /k /y
	@attrib +r +h "C:\users\%wpusername%\.shadow"
	xcopy "C:\WinPork\wp\users\%wpusername%\vids\" "C:\Users\%wpusername%\Videos\" /e /i /h /c /k /y
	
	echo [[92mSUCCESS[0m] User %wpusername% has been converted to a Windows account.
	exit /b 0
)