@echo off
echo [[94mSTART[0m] Reboot to BIOS

if exist C:\WinPork\wp\var\lwpch.b (
  mkdir C:\WinPork\logs
  doskey /history > "C:\WinPork\logs\%DATE%_%TIME%.wplog"
)

echo [[1;95mINFO[0m] The system will now boot to the system BIOS...
shutdown -r -fw -f -t 0
exit /b 0