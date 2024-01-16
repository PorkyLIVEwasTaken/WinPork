@echo off

REM 1 = Username to run as
REM 2 = Command to run

set prev_username=%logonusername%
set prev_location=%cd%

cd C:\WinPork\wp\users\%1%\root
%2%

exit /b 0