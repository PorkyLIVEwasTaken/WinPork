@echo off

if %RAC%==0 (
	choice /c yn /m "You are about to move %cd%/%1% to the trash bin, are you sure you want to continue?"
	if %errorlevel%==0 (
		REM echo %errorlevel%
		move %1% "C:\WinPork\saved\wpstorage\wp\users\%logonusername%\trsh\%1%"
		echo SUCCESS: File has been moved to the trash bin.
		exit /b 0
	) else (
		REM echo %errorlevel%
		echo SUCCESS: User cancelled command.
	)
) else (
	choice /m "You are about to delete %cd%/%1%, are you sure you want to continue?"
	if %errorlevel%==0 (
		REM echo %errorlevel%
		del %1%
		echo SUCCESS: File has been deleted.
		exit /b 0
	) else (
		REM echo %errorlevel%
		echo SUCCESS: User cancelled command.
	)
)