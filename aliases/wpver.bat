@echo off

type C:\winpork\winpork.wpver

goto :ver%1%

:verprint
mkdir C:\WinPork\printed-files
type C:\winpork\winpork.wpver > C:\WinPork\printed-files\wpver.txt
echo [[92mSUCCESS[0m] Printed WinPork version to C:\WinPork\printed-files\wpver.txt

:ver
exit /b 0