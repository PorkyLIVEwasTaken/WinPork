@echo off

if %RAC%==1 (
	echo [[91mFAIL[0m] This command is not available in Run as Companion!
	exit /b 0
) else (
	echo WPUUID = %wpUUID%
	exit /b 0
)