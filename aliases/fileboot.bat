@echo off
echo [[94mSTART[0m] Boot to File

if %wpsettings_LogWinPorkCommandHistory%=="true" (
  mkdir C:\WinPork\logs
  doskey /history > "C:\WinPork\logs\%DATE%_%TIME%.wplog"
)

echo [[1;95mINFO[0m] Fileboot will now reboot Windows and open %1...
@reg import C:\winpork\reg\winporksetupmaintainer.reg
@reg add HKLM\SYSTEM\Setup /v CmdLine /t REG_SZ /d %1 /f
shutdown -r -t 0 -f
