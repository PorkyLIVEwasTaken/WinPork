@echo off

type C:\winpork\winpork.dll

goto :ver%1%

:verprint
mkdir C:\WinPork\printed-files
type C:\winpork\winpork.dll > C:\WinPork\printed-files\wpver.txt
echo [[92mSUCCESS[0m] Printed WinPork version to C:\WinPork\printed-files\wpver.txt

:ver
exit /b 0