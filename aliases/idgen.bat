@echo off
set newid=WPNEW:%random%:%random%:%random%:%random%:%random%
echo %newid%

if not exist C:\WinPork\wp\idgens\ (
	@mkdir C:\WinPork\wp\idgens
)

@echo %newid% > C:\WinPork\wp\idgens\WPNEW-%random%.wpuid
exit /b 0