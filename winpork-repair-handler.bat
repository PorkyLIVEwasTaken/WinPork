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
) > C:\WinPork\wp\savloc.wpmem

reg import C:\winpork\reg\winporksetupmaintainer.reg

if exist C:\WinPork\wp\aether\ucid.wp (
	goto :continueucid
) else (
	set wp_cverification=WP000:%random%:%random%:%random%:%random%:%random%
	goto :continueucid
)

:continueucid

powershell -Command Set-ExecutionPolicy -ExecutionPolicy Bypass

echo %wp_cverification% > "C:\WinPork\wp\aether\ucid.wp"
@attrib +r +h "C:\WinPork\wp\aether\ucid.wp"

shutdown -r -t 7 -f -c "Your computer will be restarted to boot up WinPork RTE."