@echo off
title WinPork RAC Initializer

REM Insert WinPork Version here, winpork.wpver is deprecated.
set wp_ver=1.0

echo WinPork RAC succesfully booted up on version %wp_ver% > C:\winpork-logs\bootlog_%date%_%time%.winpork
echo [[92mSUCCESS[0m] WinPork RAC bootup on version %wp_ver%
echo System Timestamp: %date% %time%
echo=
powershell write-host -fore White -back Magenta Welcome to WinPork!
echo=

if exist C:\WinPork\wp\aether\ucid.wp (
	goto :continueucid
) else (
	set wp_cverification=WP000:%random%:%random%:%random%:%random%:%random%
	goto :continueucid
)
:continueucid

echo [[96mPERFORM[0m] WinPork UCID Verification Check...
< C:\WinPork\wp\aether\ucid.wp ( 
    set /p wpUCID=
  )

echo WPUCID = %wpUCID%

echo [[94mSTART[0m] Preparing WinPork commands...
echo [[96mPERFORM[0m] Recognising WinPork command aliases...
set PATH=%PATH%;C:\WinPork\aliases;C:\WinPork\aliases\.mod
echo [[96mPERFORM[0m] Mounting community-made Commands...
echo [[92mSUCCESS[0m] Prepared WinPork commands!

echo [[96mPERFORM[0m] Loading WinPork settings...

REM This was an attempt to put the WinPork settings in the registry, you can try to make it work :P

REM setlocal
REM set "RegKey=HKLM\SOFTWARE\WinPork"
REM REM Use the "reg" command to check if the key exists
REM reg query "%RegKey%" >nul 2>&1
REM if %errorlevel% equ 0 (
    REM echo The registry key %RegKey% exists.
	REM goto :continuesettingreg
REM ) else (
    REM echo The registry key %RegKey% does not exist, importing WinPork Settings template...
	REM reg import C:\WinPork\reg\WinPorkSettingsTemplate.reg
	REM goto :continuesettingreg
REM )
REM :continuesettingreg
REM endlocal

REM PAUSE

REM :: Call the function with different registry values
REM @call C:\WinPork\winporkregread.bat "HKLM\SOFTWARE\WinPork" "DisableWinPorkWelcomeScreen"
REM @call C:\WinPork\winporkregread.bat "HKLM\SOFTWARE\WinPork" "LogWinPorkCommandHistory"
REM @call C:\WinPork\winporkregread.bat "HKLM\SOFTWARE\WinPork" "NoSavLocRead"
REM @call C:\WinPork\winporkregread.bat "HKLM\SOFTWARE\WinPork" "PreventSaveFolderCreation"
REM :: Display the environment variables
REM echo wpsettings_DisableWinPorkWelcomeScreen is %wpsettings_DisableWinPorkWelcomeScreen%
REM echo wpsettings_LogWinPorkCommandHistory is %wpsettings_LogWinPorkCommandHistory%
REM echo wpsettings_NoSavLocRead is %wpsettings_NoSavLocRead%
REM echo wpsettings_PreventSaveFolderCreation is %wpsettings_PreventSaveFolderCreation%
REM endlocal

REM PAUSE

echo [[96mPERFORM[0m] WinPork Operating System Check...
wmic os get ostype, buildnumber, osarchitecture, oslanguage, status, lastbootuptime, version, windowsdirectory

echo [[96mPERFORM[0m] WinPork CPU Check...
wmic cpu get deviceid, numberofcores, maxclockspeed

echo [[94mSTART[0m] WinPork Memory preparation...

echo [[96mPERFORM[0m] Checking available storage space for Memory...
setlocal enabledelayedexpansion

REM Replace "C:" with the drive or directory you want to check
set "drive=C:\WinPork\saved\"

for /f "tokens=2,3" %%a in ('dir !drive! ^| find /i "bytes free"') do (
    set "freeSpace=%%a"
    set "unit=%%b"
)

echo Free space on %drive%: %freeSpace% %unit% bytes
endlocal

@schtasks /create /tn "DeleteMemoryOnShutdown" /sc ONSTART /ru "System" /tr "C:\WinPork\schtasks\delmem.bat" /f

echo [[96mPERFORM[0m] Checking system writing rights for Memory...
@fsutil file createnew "C:\WinPork\wp\memtester.wpmem" 1048576
@del "C:\WinPork\wp\memtester.wpmem" /f

echo [[96mPERFORM[0m] Creating empty Memory file...
@fsutil file createnew "C:\WinPork\wp\memory.wpmem" 0
@attrib +r +h "C:\WinPork\wp\memory.wpmem"

echo [[92mSUCCESS[0m] WinPork Memory file ready!

echo [[94mSTART[0m] Preparing WinPork Storage system...
mkdir C:\WinPork\wp\aether
@attrib +h "C:\WinPork\wp\aether"
if exist C:\WinPork\wp (
    goto continuewpstorage
) else (
    echo [[33mWARN[0m] No storage system has been detected, creating a new one...
    mkdir C:\WinPork\wp
	attrib +h "C:\WinPork\wp\"
)
:continuewpstorage

echo [[96mPERFORM[0m] Check for full dirtree...
if exist C:\WinPork\wp\sys\dtr.b (
	goto :continuedirtree
) else (
	mkdir C:\WinPork\wp\acid
	mkdir C:\WinPork\wp\app
	mkdir C:\WinPork\wp\cfg
	mkdir C:\WinPork\wp\dev
	mkdir C:\WinPork\wp\dev\workbench
	mkdir C:\WinPork\wp\dsk
	mkdir C:\WinPork\wp\lib
	mkdir C:\WinPork\wp\lib\docs
	mkdir C:\WinPork\wp\lib\imgs
	mkdir C:\WinPork\wp\lib\msic
	mkdir C:\WinPork\wp\lib\vids
	mkdir C:\WinPork\wp\sys
	mkdir C:\WinPork\wp\var
	xcopy nul C:\WinPork\wp\sys\dtr.b
	
	setlocal enabledelayedexpansion

	rem Clear existing symbolic links
	del /q "C:\WinPork\wp\dsk\*"

	rem Loop through drive letters from A to Z
	for %%I in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
		rem Determine the link name based on the drive letter
		if "%%I"=="A" (
			set linkName=fdA
		) else if "%%I"=="B" (
			set linkName=fdB
		) else if "%%I"=="C" (
			set linkName=sysdC
		) else (
			set linkName=ext%%I
		)

		rem Create the symbolic link
		mklink "C:\WinPork\wp\dsk\!linkName!" "%%I:\"
	)

	echo [SUCCESS] Symbolic links created for drives A: through Z:
	endlocal
)

:continuedirtree
echo [[92mSUCCESS[0m] WinPork Storage system ready!

echo [[94mSTART[0m] Loading WinPork settings...
if exist C:\WinPork\wp\settings.wpsettings (
  < C:\WinPork\wp\settings.wpsettings ( 
    set /p wpsettings_LogWinPorkCommandHistory=
    set /p wpsettings_DisableWinPorkWelcomeScreen=
    set /p wpsettings_NoSavLocRead=
	set /p wpsettings_PreventSaveFolderCreation=
	set /p wpsettings_UseWP_Theme=
	set /p wpsettings_PauseAfterBoot=
  )
  goto continuesettings
) else (
  echo [[33mWARN[0m] No settings file has been detected, creating a new one...
  (
    echo true
    echo false
    echo false
	echo false
	echo true
	echo false
  ) > C:\WinPork\wp\settings.wpsettings
set wpsettings_LogWinPorkCommandHistory="true"
set wpsettings_DisableWinPorkWelcomeScreen="false"
set wpsettings_NoSavLocRead="false"
set wpsettings_PreventSaveFolderCreation="false"
set wpsettings_UseWP_Theme="true"
set wpsettings_PauseAfterBoot="true"
  goto continuesettings
)
:continuesettings
echo [[92mSUCCESS[0m] WinPork Settings loaded!

echo [[96mPERFORM[0m] Checking for WinPork bootfile...
if exist C:\WinPork\wp\sys\bootr.d (
	echo [[92mSUCCESS[0m] Bootfiles found, continuing...
	goto :continueboot
) else (
	@cmd /k "C:\WinPork\wpsetup.bat"
)
:continueboot

echo [[96mPERFORM[0m] Making SavLoc Read-Only...
@attrib +r +h "C:\WinPork\wp\savloc.wpmem"
@attrib +r +h "C:\WinPork\wp\aether"

if /i "%wpsettings_NoSavLocRead%"=="false" (
  echo [[96mPERFORM[0m] Loading Saved locations from WinPork Memory File...
  < C:\WinPork\wp\savloc.wpmem (
    rem  
    rem  
    set /p WP_LOC=
    set /p WINROOT=
    set /p LASTUSER=
  )
  goto continuesavloc
) else (
  echo [[33mWARN[0m] Settings dictated that no saved locations should be read, skipping...
  goto continuesavloc
)
:continuesavloc

echo [[94mSTART[0m] Network check...
echo [[96mPERFORM[0m] Local loopback test to check network card health...
@ping 127.0.0.1

if %errorlevel% == 0 (
	echo [[92mSUCCESS[0m] Network card ready!
	goto :continuenetwork
) else (
	echo [[91mFAIL[0m] Local loopback returned one or multiple packet losses, consider replacing your network card.
	timeout /t 5
	goto :continuenetwork
)
:continuenetwork

set RAC=0

if "%wpsettings_PauseAfterBoot%"=="true" (
	PAUSE
)

echo [[94mSTART[0m] Checking if WinPork has VMWare-host...
setlocal enabledelayedexpansion

set "vmwareDetected=false"

for /f "skip=3 tokens=2 delims= " %%i in ('ipconfig /all ^| find "Physical Address"') do (
    set "macAddress=%%i"
    set "macPrefix=!macAddress:~0,8!"

    rem Check for common VMware MAC address prefixes
    if /i "!macPrefix!"=="00:50:56" (
        set "vmwareDetected=true"
    )
)

if !vmwareDetected! == "true" (
    echo VMware detected.
    rem Add your commands for when VMware is detected
	
) else (
    echo Not running on VMware.
    rem Add your commands for when VMware is not detected
)

endlocal

echo [[36mSOLO-PERFORM[0m] WinPork boot finisher...

@cmd /k "C:\winpork\winpork-rac-finisher.bat"