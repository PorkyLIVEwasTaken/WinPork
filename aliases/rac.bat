@echo off
echo [[94mSTART[0m] Run As Companion Reboot

if %RAC% == 1 (
	goto :RAC
)

if exist C:\WinPork\wp\var\lwpch.b (
  mkdir C:\WinPork\logs
  doskey /history > "C:\WinPork\logs\%DATE%_%TIME%.wplog"
)

echo [[96mPERFORM[0m] Initializing Run As Companion...
reg import "C:\WinPork\reg\WinPorkRAC.reg"

echo [[1;95mINFO[0m] Rebooting...
shutdown -r -f -t 0

exit /b 0

:RAC
echo [[91mFAIL[0m] This command is not available in Run As Companion!
exit /b 0