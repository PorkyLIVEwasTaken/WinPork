@echo off
title WinPork 10x64 RAC Initializer

mkdir C:\winpork-logs

echo WinPork 8.1x64 Repair Tool Environment succesfully booted up on version 2.0 > C:\winpork-logs\bootlog.winpork
echo [[92mSUCCESS[0m] WinPork RTE bootup on version 2.0 (Run As Companion)
echo=
powershell write-host -fore White -back Magenta Welcome to WinPork!
echo=

echo [[94mSTART[0m] Preparing WinPork commands...
echo [[96mPERFORM[0m] Recognising WinPork command aliases...
set PATH=%PATH%;C:\WinPork\aliases
echo [[92mSUCCESS[0m] Prepared WinPork commands!

@cmd /k "C:\winpork\winpork-rac-finisher.bat"