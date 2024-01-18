@echo off
echo [[94mSTART[0m] Boot to File

if exist C:\WinPork\wp\var\lwpch.b (
  mkdir C:\WinPork\logs
  doskey /history > "C:\WinPork\logs\%DATE%_%TIME%.wplog"
)

set /p set /p confirmfileboot="[[91mCAUTION[0m] Using fileboot incorrectly can brick your computer! It is highly recommended to have a failsafe at hand (I.E. using 'skcp' or having a Windows installation disk). Are you sure you want to continue? Type 'confirm' in full to continue. "

if confirmfileboot=="confirm" (
	echo [[1;95mINFO[0m] Fileboot will now reboot Windows and open %1...
	@reg import C:\winpork\reg\winporksetupmaintainer.reg
	@reg add HKLM\SYSTEM\Setup /v CmdLine /t REG_SZ /d %1 /f
	shutdown -r -t 0 -f
) else (
	echo [[91mFAIL[0m] User cancelled command, or command timed out.
	exit /b 0
)