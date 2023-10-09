@echo off
echo [[94mSTART[0m] Verbose Logon Toggler

goto :arg1_%1%

:arg1_
choice /m "Do you wish to enable (Y) or disable (N) the verbose login messages?"
goto :check%errorlevel%

:arg1_y
:check1
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v VerboseStatus /t REG_DWORD /d 1 /f
echo [[92mSUCCESS[0m] Enabled verbose login messages.
exit /b 0

:arg1_n
:check2
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v VerboseStatus /t REG_DWORD /d 0 /f
echo [[92mSUCCESS[0m] Disabled verbose login messages.
exit /b 0