@echo off
echo [[94mSTART[0m] Power computer off

if exist C:\WinPork\wp\var\lwpch.b (
  mkdir C:\WinPork\logs
  doskey /history > "C:\WinPork\logs\%DATE%_%TIME%.wplog"
)

echo [[1;95mINFO[0m] The system will shut down now...
shutdown -s -t 0 -f
exit /b 0