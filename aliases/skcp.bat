@echo off
echo [[94mSTART[0m] Sticky Key Command Prompt Toggler

goto :arg1_%1%

:arg1_
choice /m "Do you wish to enable (Y) or disable (N) the option to open the Command Prompt after the SHIFT-key has been pressed 5 times?"
goto :check%errorlevel%

:arg1_y
:check1
xcopy C:\WinPork\replacers\skcp\cmd.exe C:\Windows\System32\sethc.exe /y /r
echo [[92mSUCCESS[0m] Pressing the SHIFT-key 5 times now opens the Command Prompt.
exit /b 0

:arg1_n
:check2
xcopy C:\WinPork\replacers\skcp\sethc.exe C:\Windows\System32\sethc.exe /y /r
echo [[92mSUCCESS[0m] Pressing the SHIFT-key 5 times now opens the Sticky Keys Confirmation.
exit /b 0