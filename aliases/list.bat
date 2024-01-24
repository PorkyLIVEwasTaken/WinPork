@echo off
echo Raw list of available commands:
REM for %f% in (*.bat) do type %f
dir C:\WinPork\aliases /b /p
exit /b 0