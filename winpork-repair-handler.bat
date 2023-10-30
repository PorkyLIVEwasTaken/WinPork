@echo off
title WinPork RTE Initializer

setlocal

set "RegKey=HKLM\SOFTWARE\WinPork"

rem Use the "reg" command to check if the key exists
reg query "%RegKey%" >nul 2>&1

if %errorlevel% equ 0 (
    echo The registry key %RegKey% exists.
	goto :continuesettingreg
) else (
    echo The registry key %RegKey% does not exist, importing WinPork Settings template...
	reg import C:\WinPork\reg\WinPorkSettingsTemplate.reg
	goto :continuesettingreg
)
:continuesettingreg
endlocal

set WP_LOC=%SystemDrive%\WinPork\
set WINROOT=%SystemDrive%
set LASTUSER=%UserProfile%

(
  echo %WP_LOC%
  echo %WINROOT%
  echo %LASTUSER%
) > C:\WinPork\saved\savloc.wpmem

reg import C:\winpork\reg\winporksetupmaintainer.reg

shutdown -r -t 7 -f -c "Your computer will be restarted to boot up WinPork RTE."