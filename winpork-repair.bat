@echo off
title WinPork 8.1x64 Repair Tool Initializer

echo WinPork 8.1x64 Repair Tool Environment succesfully booted up on version 2.0 > C:\winpork-logs\bootlog.winpork
echo [[92mSUCCESS[0m] WinPork RTE bootup on version 2.0
echo=
powershell write-host -fore White -back Magenta Welcome to WinPork!
echo=

echo [[94mSTART[0m] Preparing WinPork commands...
echo [[96mPERFORM[0m] Recognising WinPork command aliases...
set PATH=%PATH%;C:\WinPork\aliases
echo [[92mSUCCESS[0m] Prepared WinPork commands!

echo [[96mPERFORM[0m] Loading WinPork settings...
if exist C:\WinPork\saved\settings.wpsettings (
  < C:\WinPork\saved\settings.wpsettings ( 
    set /p LogWinPorkCommandHistory=
    set /p DisableWinPorkWelcomeScreen=
    set /p NoSavLocRead=
  )
  goto continuesettings
) else (
  echo [[33mWARN[0m] No settings file has been detected, creating a new one...
  (
    echo true
    echo false
    echo false
  ) > C:\WinPork\saved\settings.wpsettings
set LogWinPorkCommandHistory="true"
set DisableWinPorkWelcomeScreen="false"
set NoSavLocRead="false"
  goto continuesettings
)
:continuesettings

if /i "%NoSavLocRead%"=="false" (
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

if "%DisableWinPorkWelcomeScreen%"=="false" (
  powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('Welcome to WinPork RTE! This repair tool is meant to be used as a last resort if your computer no longer functions (properly). This tool is NOT meant to be used for standard command prompt usage or registry editing; if this is the case, please use the normal Windows Environment instead.','WinPork RTE','OK',[System.Windows.Forms.MessageBoxIcon]::Information);}"
  goto continuewelcomescreen
)
:continuewelcomescreen

echo [[36mSOLO-PERFORM[0m] WinPork boot finisher...
@cmd /k "C:\winpork\winpork-boot-finisher.bat"