@echo off
echo [[94mSTART[0m] Cursor Suppression Toggler

goto :arg1_%1%

:arg1_
choice /m "Do you wish to show the cursor in WinPork?"
goto :check%errorlevel%

:arg1_y
:check1
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableCursorSuppression /t REG_DWORD /d 0 /f
echo [[92mSUCCESS[0m] Cursor should now be shown.
exit /b 0

:arg1_n
:check2
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableCursorSuppression /t REG_DWORD /d 1 /f
echo [[92mSUCCESS[0m] Cursor should now be hidden.
exit /b 0

:arg1_force
reg add HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableCursorSuppression /t REG_DWORD /d 0 /f
explorer
echo [[92mSUCCESS[0m] Cursor should now be shown. (A restart might be required to hide the cursor again.)
exit /b 0