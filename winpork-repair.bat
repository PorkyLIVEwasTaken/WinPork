@echo off
title WinPork RTE Initializer

REM Insert WinPork Version here, winpork.wpver is deprecated.
set wp_ver=1.0

echo WinPork RTE succesfully booted up on version %wp_ver% > C:\winpork-logs\bootlog_%date%_%time%.winpork
echo [[92mSUCCESS[0m] WinPork RTE bootup on version %wp_ver%
echo System Timestamp: %date% %time%
echo=
powershell write-host -fore White -back Magenta Welcome to WinPork!
echo=

echo [[96mPERFORM[0m] WinPork UCID Verification Check...
< C:\WinPork\saved\aether\ucid.wp ( 
    set /p wpUCID=
  )

echo WPUCID = %wpUCID%

echo [[94mSTART[0m] Preparing WinPork commands...
echo [[96mPERFORM[0m] Recognising WinPork command aliases...
set PATH=%PATH%;C:\WinPork\aliases
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
@fsutil file createnew "C:\WinPork\saved\memtester.wpmem" 1048576
@del "C:\WinPork\saved\memtester.wpmem" /f

echo [[96mPERFORM[0m] Creating empty Memory file...
@fsutil file createnew "C:\WinPork\saved\memory.wpmem" 0
@attrib +r +h "C:\WinPork\saved\memory.wpmem"

echo [[92mSUCCESS[0m] WinPork Memory file ready!

echo [[94mSTART[0m] Preparing WinPork Storage system...
mkdir C:\WinPork\saved\aether
@attrib +h "C:\WinPork\saved\aether"
if exist C:\WinPork\saved\wpstorage\wp (
    goto continuewpstorage
) else (
    echo [[33mWARN[0m] No storage system has been detected, creating a new one...
    mkdir C:\WinPork\saved\wpstorage\wp
	attrib +h "C:\WinPork\saved\wpstorage\"
)
:continuewpstorage

echo [[96mPERFORM[0m] Mounting community-made Commands...
mklink /D C:\WinPork\.mods C:\WinPork\aliases

echo [[92mSUCCESS[0m] WinPork Storage system ready!

echo [[94mSTART[0m] Loading WinPork settings...
if exist C:\WinPork\saved\settings.wpsettings (
  < C:\WinPork\saved\settings.wpsettings ( 
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
  ) > C:\WinPork\saved\settings.wpsettings
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

echo [[96mPERFORM[0m] Super-User Check...
if exist C:\WinPork\saved\wpstorage\wp\users\su (
    @attrib +r +h "C:\WinPork\saved\wpstorage\wp\users\su\shdw\passwd.wpshdw"
	@attrib +r +h "C:\WinPork\saved\aether\sudo.passwd"
	echo [[92mSUCCESS[0m] Super-User ready!
) else (
	echo [[33mWARN[0m] Super-User is missing, creating a new one...
	mkdir C:\WinPork\saved\wpstorage\wp\users\su\cnfg
	mkdir C:\WinPork\saved\wpstorage\wp\users\su\docs
	mkdir C:\WinPork\saved\wpstorage\wp\users\su\home
	mkdir C:\WinPork\saved\wpstorage\wp\users\su\imgs
	mkdir C:\WinPork\saved\wpstorage\wp\users\su\root
	mkdir C:\WinPork\saved\wpstorage\wp\users\su\shdw
	mkdir C:\WinPork\saved\wpstorage\wp\users\su\trsh
	mkdir C:\WinPork\saved\wpstorage\wp\users\su\vids
	mkdir C:\WinPork\saved\wpstorage\wp\users\su\msic
	set wp_su_verification="WPRTE:%random%:%random%:%random%:%random%:%random%"
	echo %wp_su_verification% > "C:\WinPork\saved\wpstorage\wp\users\su\shdw\uuid.wpuser"
	echo [[92mSUCCESS[0m] Super-User has been created.
	echo=
	set /p sudopassword=Please enter a new password for the Super-User:
	@echo %sudopassword% > "C:\WinPork\saved\wpstorage\wp\users\su\shdw\passwd.wpshdw"
	@echo %sudopassword% > "C:\WinPork\saved\aether\sudo.passwd"
	@attrib +r +h "C:\WinPork\saved\wpstorage\wp\users\su\shdw\uuid.wpuser"
	@attrib +r +h "C:\WinPork\saved\aether\sudo.passwd"
)

echo [[96mPERFORM[0m] Making SavLoc Read-Only...
@attrib +r +h "C:\WinPork\saved\savloc.wpmem"
@attrib +r +h "C:\WinPork\saved\aether"

if /i "%wpsettings_NoSavLocRead%"=="false" (
  echo [[96mPERFORM[0m] Loading Saved locations from WinPork Memory File...
  < C:\WinPork\saved\savloc.wpmem (
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

echo [[94mSTART[0m] Activating WinPork auto-disable on reboot...
echo [[96mPERFORM[0m] WinPork startup regkey cleanup...
reg import C:\winpork\reg\winporksetupcloser.reg
echo [[92mSUCCESS[0m] WinPork disables at reboot!

if "%wpsettings_DisableWinPorkWelcomeScreen%"=="false" (
  powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Welcome to WinPork RTE! This repair tool is meant to be used as a last resort if your computer no longer functions (properly). This tool is NOT meant to be used for standard command prompt usage or registry editing; if this is the case, please use the normal Windows Environment instead.','WinPork RTE','OK',[System.Windows.Forms.MessageBoxIcon]::Information);}"
  goto continuewelcomescreen
)
:continuewelcomescreen

if "%wpsettings_PauseAfterBoot%"=="true" (
	PAUSE
)

echo [[36mSOLO-PERFORM[0m] WinPork boot finisher...
@cmd /k "C:\winpork\winpork-boot-finisher.bat"