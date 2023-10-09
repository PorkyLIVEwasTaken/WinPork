@echo off
echo [[94mSTART[0m] Wait task

goto :quick_%2%

:quick_
set /p waitsec="[[1;95mQUEST[0m] How long do you want WinPork to wait for in seconds? "
timeout /t %waitsec% /nobreak
exit /b 0

:quick_quick
:quick_q
timeout /t %1% /nobreak
exit /b 0