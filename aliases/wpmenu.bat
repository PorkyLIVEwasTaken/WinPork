@echo off
echo [[94mSTART[0m] WinPork Context Menu Option Toggler

goto :arg1_%1%

:arg1_
choice /m "Do you wish to enable (Y) or disable (N) the 'Boot WinPork' option in the context menu?"
goto :check%errorlevel%

:arg1_y
:check1
reg import C:\WinPork\reg\winporkcontextmenu.reg
echo [[92mSUCCESS[0m] The 'Boot WinPork' context menu option has been enabled.
exit /b 0

:arg1_n
:check2
reg delete HKEY_CLASSES_ROOT\Directory\background\shell\Z001BDW
echo [[92mSUCCESS[0m] The 'Boot WinPork' context menu option has been enabled.
exit /b 0