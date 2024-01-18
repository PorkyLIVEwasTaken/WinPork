@echo off

if exist C:\WinPork\wp\var\lwpch.b (
  mkdir C:\WinPork\logs
  doskey /history > "C:\WinPork\logs\%DATE%_%TIME%.wplog"
)

goto mode%1%

:mode
choice /c ORKSX /m "Do you want to shutdown (O), reboot (R), reboot WinPork (K), or reboot to Safe Mode (S)? (Cancel = X)"
goto gui%errorlevel%
exit /b 0

:mode-gui
shutdown /i
exit /b 0

:modeoff
:modeshutdown
:modepoweroff
:mode-s
:gui1
echo [[94mSTART[0m] Shutdown

echo [[1;95mINFO[0m] The system will be shut down shortly...

shutdown /s /f /t 0
exit /b 0



:modereboot
:moderestart
:mode-r
:gui2
echo [[94mSTART[0m] Reboot to Windows

echo [[1;95mINFO[0m] The system will be rebooted into Windows shortly...
shutdown /r /f /t 0
exit /b 0

:mode-safe
:mode-s
:gui3
echo [[94mSTART[0m] Reboot to Windows Safe Mode

echo [[1;95mINFO[0m] The system will be rebooted into Windows Safe Mode shortly...
bcdedit /set {current} safeboot minimal
reg import C:\winpork\reg\winporksafemodeoff.reg
shutdown /r /f /t 0
exit /b 0

:mode-firmware
:mode-fw
echo [[94mSTART[0m] Reboot to Firmware
echo [[1;95mINFO[0m] The system will be rebooted to firmware shortly...
reg import C:\winpork\reg\winporksafemodeoff.reg
shutdown /r /fw /f /t 0
exit /b 0

:mode-k
echo [[94mSTART[0m] Reboot to WinPork
echo [[1;95mINFO[0m] The system will be rebooted to WinPork shortly...
shutdown /r /fw /f /t 0
exit /b 0



:gui4
exit /b 0