@echo off
echo [[94mSTART[0m] WinPork Extension Toggler

goto :arg1_%1%

:arg1_
choice /m "Do you wish to enable the .winpork extension?"
goto :check%errorlevel%

:arg1_y
:check1
assoc .winpork=txtfile
echo [[92mSUCCESS[0m] The .winpork extension will now be recognized by Windows.
exit /b 0

:arg1_n
:check2
assoc .winpork=
echo [[92mSUCCESS[0m] The .winpork extension will no longer be recognized by Windows.
exit /b 0

:check
echo [[91mFAIL[0m] Invalid argument
exit /b 0