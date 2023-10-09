@echo off

if %LogWinPorkCommandHistory%==true (
  mkdir C:\WinPork\logs
  doskey /history > "C:\WinPork\logs\%DATE%_%TIME%.wplog"
)

goto mode%1

:mode
:modenormal
echo [[94mSTART[0m] Reboot to Windows

echo [[1;95mINFO[0m] The system will be rebooted shortly...
shutdown -r -t 0 -f
exit /b 0

:modesafe
echo [[94mSTART[0m] Reboot to Windows Safe Mode

echo [[1;95mINFO[0m] The system will be rebooted into Windows Safe Mode shortly...
bcdedit /set {current} safeboot minimal
reg import C:\winpork\reg\winporksafemodeoff.reg
shutdown /r /f /t 0
exit /b 0