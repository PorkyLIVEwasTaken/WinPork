@echo off
powershell write-host -fore White -back Magenta WinPork Setup
title WinPork Setup
echo [[96mPERFORM[0m] Super-User Check...
if exist C:\WinPork\saved\wpstorage\wp\users\su (
    @attrib +r +h "C:\WinPork\saved\wpstorage\wp\users\su\shdw\passwd.wpshdw"
	@attrib +r +h "C:\WinPork\saved\aether\sudo.passwd"
	echo [[92mSUCCESS[0m] Super-User ready!
) else (
	echo [[33mWARN[0m] Super-User is missing, creating a new one...
	mkdir C:\WinPork\saved\wpstorage\wp\users\su\cnfg
	mkdir C:\WinPork\saved\wpstorage\wp\users\su\docs
	mkdir C:\WinPork\saved\wpstorage\wp\users\su\home
	mkdir C:\WinPork\saved\wpstorage\wp\users\su\imgs
	mkdir C:\WinPork\saved\wpstorage\wp\users\su\root
	mkdir C:\WinPork\saved\wpstorage\wp\users\su\shdw
	mkdir C:\WinPork\saved\wpstorage\wp\users\su\trsh
	mkdir C:\WinPork\saved\wpstorage\wp\users\su\vids
	mkdir C:\WinPork\saved\wpstorage\wp\users\su\msic
	set wp_su_verification="WPRTE:%random%:%random%:%random%:%random%:%random%"
	echo %wp_su_verification% > "C:\WinPork\saved\wpstorage\wp\users\su\shdw\uuid.wpuser"
	echo=
	echo Enter a new password for the Super-User. 
	echo The Super-User has some elevated permissions, and is the default user. This user cannot be removed through WinPork.
	echo If you forget the password of the Super-User, you can no longer log in as the Super-User, so pick a password that you will remember!
	echo=
	set /p sudopassword=Please enter a new password for the Super-User:
	echo [[92mSUCCESS[0m] Super-User has been created.
	@echo %sudopassword% > "C:\WinPork\saved\wpstorage\wp\users\su\shdw\passwd.wpshdw"
	@echo %sudopassword% > "C:\WinPork\saved\aether\sudo.passwd"
	@attrib +r +h "C:\WinPork\saved\wpstorage\wp\users\su\shdw\uuid.wpuser"
	@attrib +r +h "C:\WinPork\saved\aether\sudo.passwd"

	echo [[96mPERFORM[0m] Creation of first User...
	echo Enter a username for a secondary user.
	echo This secondary user is a lower-privileged user for standard usage, which does not require the use of the Super-User.
	set /p wpusername=What would you like to be the name of the new user? 
	
	echo Enter the password for this secondary user.
	echo If you forget the password of any secondary user, you can log into the Super-User to reset the password for this User.
	set /p password=What would you like to be the password of the new user? 
	mkdir C:\WinPork\saved\wpstorage\wp\users\%wpusername%\cnfg
	mkdir C:\WinPork\saved\wpstorage\wp\users\%wpusername%\docs
	mkdir C:\WinPork\saved\wpstorage\wp\users\%wpusername%\home
	mkdir C:\WinPork\saved\wpstorage\wp\users\%wpusername%\imgs
	mkdir C:\WinPork\saved\wpstorage\wp\users\%wpusername%\root
	mkdir C:\WinPork\saved\wpstorage\wp\users\%wpusername%\shdw
	mkdir C:\WinPork\saved\wpstorage\wp\users\%wpusername%\trsh
	mkdir C:\WinPork\saved\wpstorage\wp\users\%wpusername%\vids
	mkdir C:\WinPork\saved\wpstorage\wp\users\%wpusername%\msic
	set wp_verification=WPRTE:%random%:%random%:%random%:%random%:%random%
	echo %wp_verification% > "C:\WinPork\saved\wpstorage\wp\users\%wpusername%\shdw\uuid.wpuser"
	@echo %password% > "C:\WinPork\saved\wpstorage\wp\users\%wpusername%\shdw\passwd.wpshdw"
	@attrib +r +h C:\WinPork\saved\wpstorage\wp\users\%wpusername%\shdw/passwd.wpshdw
	@attrib +r +h C:\WinPork\saved\wpstorage\wp\users\%wpusername%\shdw/uuid.wpuser
	echo [[92mSUCCESS[0m] User %wpusername% has been created.
)

copy nul C:\WinPork\saved\wpstorage\wp\sys\bootr.d
@cmd /k "C:\WinPork\winpork-repair.bat"