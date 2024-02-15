@echo off
echo=
powershell write-host -fore White -back Magenta WinPork Setup
echo=
title WinPork Setup
echo [[96mPERFORM[0m] Super-User Check...
if exist C:\WinPork\wp\users\su (
    @attrib +r +h "C:\WinPork\wp\users\su\shdw\passwd.wpshdw"
	@attrib +r +h "C:\WinPork\wp\aether\sudo.passwd"
	echo [[92mSUCCESS[0m] Super-User ready!
) else (
	setlocal enabledelayedexpansion
	echo [[33mWARN[0m] Super-User is missing, creating a new one...
	xcopy C:\WinPork\templates\su C:\WinPork\wp\users\su /E /C /I /Q /H /R /K /Y
	set wp_su_verification="WPRTE:%random%:%random%:%random%:%random%:%random%"
	echo !wp_su_verification! > "C:\WinPork\wp\users\su\shdw\uuid.wpuser"
	echo=
	echo Enter a new password for the Super-User. 
	echo The Super-User has some elevated permissions, and is the default user. This user cannot be removed through WinPork.
	echo If you forget the password of the Super-User, you can no longer log in as the Super-User, so pick a password that you will remember!
	echo=
	set /p sudopassword=Please enter a new password for the Super-User:
	echo [[92mSUCCESS[0m] Super-User has been created.
	@echo !sudopassword! > "C:\WinPork\wp\users\su\shdw\passwd.wpshdw"
	@echo !sudopassword! > "C:\WinPork\wp\aether\sudo.passwd"
	@attrib +r +h "C:\WinPork\wp\aether\sudo.passwd"

	echo [[96mPERFORM[0m] Creation of first User...
	echo Enter a username for a secondary user.
	echo This secondary user is a lower-privileged user for standard usage, which does not require the use of the Super-User.
	echo Type "skip" to skip this step completely.
	set /p wp_newusername=What would you like to be the name of the new user? 
	
	if !wp_newusername!=="skip" (
		goto :continuesetup1
	) else (
	echo Enter the password for this secondary user.
		echo If you forget the password of any secondary user, you can log into the Super-User to reset the password for this User.
		set /p password=What would you like to be the password of the new user? 
		xcopy C:\WinPork\templates\user C:\WinPork\wp\users\!wp_newusername! /E /C /I /Q /H /R /K /Y 
		set wp_verification=WPRTE:%random%:%random%:%random%:%random%:%random%
		echo !wp_verification! > "C:\WinPork\wp\users\!wp_newusername!\shdw\uuid.wpuser"
		@echo !password! > "C:\WinPork\wp\users\!wp_newusername!\shdw\passwd.wpshdw"
		@attrib +r +h C:\WinPork\wp\users\!wp_newusername!\shdw\passwd.wpshdw
		@attrib +r +h C:\WinPork\wp\users\!wp_newusername!\shdw\uuid.wpuser
		echo [[92mSUCCESS[0m] User !wp_newusername! has been created.
		goto :continuesetup1
		endlocal
	)
)
:continuesetup1

copy nul C:\WinPork\wp\sys\bootr.d

if /%RAC% == 1 (
	@cmd /k "C:\WinPork\winpork-repair-rac.bat"
) else (
	@cmd /k "C:\WinPork\winpork-repair.bat"
)