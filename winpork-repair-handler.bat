@echo off
title WinPork RTE Initializer

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