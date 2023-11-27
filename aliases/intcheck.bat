@echo off
echo [[94mSTART[0m] Pinging WinPork Internet Check Address for internet check...
tracert https://wp-intcheck.porkify.net/
echo [[92mSUCCESS[0m] Completed Internet Check!
exit /b 0