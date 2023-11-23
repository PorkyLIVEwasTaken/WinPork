@echo off
echo [[94mSTART[0m] WinPork Environment Reset

if %RAC% == 1 (
	goto :RAC
)

if %wpsettings_LogWinPorkCommandHistory%=="true" (
  mkdir C:\WinPork\logs
  doskey /history > "C:\WinPork\logs\%DATE%_%TIME%.wplog"
)

echo [[1;95mINFO[0m] The WinPork Repair Tool Environment will be resetted shortly...
@reg import C:\winpork\reg\winporksetupmaintainer.reg
shutdown -r -t 0 -f
exit /b 0

:RAC
echo [[91mFAIL[0m] This command is not available in Run As Companion!
exit /b 0