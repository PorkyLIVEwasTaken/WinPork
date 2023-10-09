@echo off
echo [[94mSTART[0m] Administrator Account Toggler

goto :arg1_%1%

:arg1_
choice /m "Do you wish to enable or disable the Administrator account?"
goto check%errorlevel%

:arg1_y
:check1
@net user Administrator /ACTIVE:YES
echo [[92mSUCCESS[0m] The Administrator user has been enabled.
exit /b 0

:arg1_n
:check2
@net user Administrator /ACTIVE:NO
echo [[92mSUCCESS[0m] The Administrator user has been disabled.
exit /b 0