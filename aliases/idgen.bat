@echo off
set newid=WPNEW:%random%:%random%:%random%:%random%:%random%
echo %newid%

if not exist C:\WinPork\saved\idgens\ (
	@mkdir C:\WinPork\saved\idgens
)

@echo %newid% > C:\WinPork\saved\idgens\WPNEW-%random%.wpuid
exit /b 0