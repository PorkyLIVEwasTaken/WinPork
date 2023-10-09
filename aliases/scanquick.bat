@echo off
echo [[94mSTART[0m] Quick System Scan

choice /m "This can revert all changes made to protected system files, without any further warnings. Do you wish to continue?"
goto :checkvulnerable%errorlevel%

echo [[91mFAIL[0m] Cancelled Windows Registry Repair
exit /b 0

:checkvulnerable1
echo [[96mPERFORM[0m] System File Check (sfc /scannow)...
sfc /scannow
echo [[96mPERFORM[0m] Health Restoration of Windows Image (DISM /Online /Cleanup-Image /RestoreHealth)...
C:\Windows\system32\DISM.exe /Online /Cleanup-image /Restorehealth

echo [[92mSUCCESS[0m] Quick system scan and repair completed!
exit /b 0

:checkvulnerable2
echo [[91mFAIL[0m] Cancelled Windows Scan & Repair
exit /b 0