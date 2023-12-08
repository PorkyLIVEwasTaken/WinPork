@echo off

if %RAC%==1 (
	echo [[91mFAIL[0m] This command is not available in Run as Companion!
	exit /b 0
) else (
	< "C:\WinPork\wp\users\%logonusername%\shdw\uuid.wpuser" set /p wpUUID=
	echo WPUUID = %wpUUID%
	exit /b 0
)