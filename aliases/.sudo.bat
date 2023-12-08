@echo off

set logonusernamebackup=%logonusername%
set logonusername=su

echo AS SUDO:
%1%

set logonusername=%logonusernamebackup%
echo <nul
set logonusernamebackup="null"

exit /b 0