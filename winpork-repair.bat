@echo off
title WinPork RTE Initializer

echo WinPork RTE succesfully booted up on version 2.0 > C:\winpork-logs\bootlog_%date%_%time%.winpork
echo [[92mSUCCESS[0m] WinPork RTE bootup on version 2.0
echo=
powershell write-host -fore White -back Magenta Welcome to WinPork!
echo=

echo [[94mSTART[0m] Preparing WinPork commands...
echo [[96mPERFORM[0m] Recognising WinPork command aliases...
set PATH=%PATH%;C:\WinPork\aliases
echo [[92mSUCCESS[0m] Prepared WinPork commands!

echo [[96mPERFORM[0m] Loading WinPork settings...

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

if exist C:\WinPork\saved\settings.wpsettings (
  < C:\WinPork\saved\settings.wpsettings ( 
    set /p wpsettings_LogWinPorkCommandHistory=
    set /p wpsettings_DisableWinPorkWelcomeScreen=
    set /p wpsettings_NoSavLocRead=
	set /p wpsettings_PreventSaveFolderCreation=
  )
  goto continuesettings
) else (
  echo [[33mWARN[0m] No settings file has been detected, creating a new one...
  (
    echo true
    echo false
    echo false
	echo false
  ) > C:\WinPork\saved\settings.wpsettings
set wpsettings_LogWinPorkCommandHistory="true"
set wpsettings_DisableWinPorkWelcomeScreen="false"
set wpsettings_NoSavLocRead="false"
set wpsettings_PreventSaveFolderCreation="false"
  goto continuesettings
)
:continuesettings

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

echo [[94mSTART[0m] Activating WinPork auto-disable on reboot...
echo [[96mPERFORM[0m] WinPork startup regkey cleanup...
reg import C:\winpork\reg\winporksetupcloser.reg
echo [[92mSUCCESS[0m] WinPork disables at reboot!

if "%wpsettings_DisableWinPorkWelcomeScreen%"=="false" (
  powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Welcome to WinPork RTE! This repair tool is meant to be used as a last resort if your computer no longer functions (properly). This tool is NOT meant to be used for standard command prompt usage or registry editing; if this is the case, please use the normal Windows Environment instead.','WinPork RTE','OK',[System.Windows.Forms.MessageBoxIcon]::Information);}"
  goto continuewelcomescreen
)
:continuewelcomescreen

echo [[36mSOLO-PERFORM[0m] WinPork boot finisher...
@cmd /k "C:\winpork\winpork-boot-finisher.bat"