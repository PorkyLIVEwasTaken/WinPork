@echo off

if %RAC%==0 (
	choice /m "You are about to move %cd%/%1% to the trash bin, are you sure you want to continue?"
	if %errorlevel%==1 (
		move "%cd%/%1%" "C:\WinPork\saved\wpstorage\wp\users\%logonusername%\trsh\%1%"
		exit /b 0
	) else (
		echo [[91mFAIL[0m] User cancelled command.
	)
) else (
	choice /m "You are about to delete %cd%/%1%, are you sure you want to continue?"
	if %errorlevel%==1 (
		del "%cd%/%1%"
		exit /b 0
	) else (
		echo [[91mFAIL[0m] User cancelled command.
	)
)