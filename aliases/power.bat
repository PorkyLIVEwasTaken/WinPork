@echo off

goto mode%1%

:mode
choice /c ORSFKX /m "Do you want to shutdown (O), or reboot to Windows (R), to Safe Mode (S), to Firmware (F) or to WinPork (K)? (Cancel = X)"
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

set quitreason=SHUTDOWN
doskey /history > "C:\WinPork\wp\logs\%QUITREASON%_%OS%_%OSARCH%_%NUMBER_OF_PROCESSORS%_%WP_VER%_%RAC%_%RANDOM%.log"

shutdown /s /f /t 0
exit /b 0



:modereboot
:moderestart
:mode-r
:gui2
echo [[94mSTART[0m] Reboot to Windows

echo [[1;95mINFO[0m] The system will be rebooted into Windows shortly...

set quitreason=RESTART_WINDOWS
doskey /history > "C:\WinPork\wp\logs\%QUITREASON%_%OS%_%OSARCH%_%NUMBER_OF_PROCESSORS%_%WP_VER%_%RAC%_%RANDOM%.log"

shutdown /r /f /t 0
exit /b 0

:mode-safe
:mode-s
:gui3
echo [[94mSTART[0m] Reboot to Windows Safe Mode

echo [[1;95mINFO[0m] The system will be rebooted into Windows Safe Mode shortly...

set quitreason=RESTART_SAFE_MODE
doskey /history > "C:\WinPork\wp\logs\%QUITREASON%_%OS%_%OSARCH%_%NUMBER_OF_PROCESSORS%_%WP_VER%_%RAC%_%RANDOM%.log"

bcdedit /set {current} safeboot minimal
reg import C:\winpork\reg\winporksafemodeoff.reg
shutdown /r /f /t 0
exit /b 0

:mode-firmware
:mode-fw
:gui4
echo [[94mSTART[0m] Reboot to Firmware
echo [[1;95mINFO[0m] The system will be rebooted to firmware shortly...

set quitreason=RESTART_FIRMWARE
doskey /history > "C:\WinPork\wp\logs\%QUITREASON%_%OS%_%OSARCH%_%NUMBER_OF_PROCESSORS%_%WP_VER%_%RAC%_%RANDOM%.log"

reg import C:\winpork\reg\winporksafemodeoff.reg
shutdown /r /fw /f /t 0
exit /b 0

:mode-k
:gui5
echo [[94mSTART[0m] Reboot to WinPork
echo [[1;95mINFO[0m] The system will be rebooted to WinPork shortly...

set quitreason=RESTART_WINPORK
doskey /history > "C:\WinPork\wp\logs\%QUITREASON%_%OS%_%OSARCH%_%NUMBER_OF_PROCESSORS%_%WP_VER%_%RAC%_%RANDOM%.log"

reg import C:\winpork\reg\winporksetupmaintainer.reg
shutdown /r /f /t 0
exit /b 0



:gui6
exit /b 0