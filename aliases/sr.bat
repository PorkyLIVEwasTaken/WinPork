@echo off
cls
powershell write-host -fore White -back Magenta Welcome to WinPork!

if %RAC% == 1 (
	echo [[33mWARN[0m] Not all commands might be available through WinPork Run As Companion!
)

echo Type "nogui" for a list of available WinPork commands.