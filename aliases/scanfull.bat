@echo off

echo [[94mSTART[0m] Full system scan and repair...

if %RAC% == 1 (
	echo [[33mWARN[0m] Although this might be able to fix problems your computer is experiencing in Run As Companion, it is still strongly recommended to run "scanfull" in RTE instead.
)

choice /m "This can revert all changes made to protected system files, without any further warnings. This will also restart your computer to check and repair disk errors. Do you wish to continue?"
goto :checkvulnerable%errorlevel%

echo [[91mFAIL[0m] Cancelled Windows Registry Repair
exit /b 0

:checkvulnerable1
echo [[96mPERFORM[0m] System File Check (sfc /scannow)...
sfc /scannow
echo [[96mPERFORM[0m] Health Restoration of Windows Image (DISM /Online /Cleanup-Image /RestoreHealth)...
C:\Windows\system32\DISM.exe /Online /Cleanup-image /Restorehealth
echo [[96mPERFORM[0m] Preparations for disk error checking (chkdsk /f)...
chkdsk /f
echo [[1;95mINFO[0m] Please allow the Check Disk to run after your computer has restarted.
echo [[96mPERFORM[0m] Reparations on boot configuration data (bcdboot C:\Windows)...
bcdboot C:\Windows
echo [[96mPERFORM[0m] Reparations on Master Boot Record (bootrec /fixmbr & bootrec /fixboot)...
bootrec /fixmbr
bootrec /fixboot
echo [[96mPERFORM[0m] Scan and reparations of the Windows Operating System (bootrec /scanos)...
bootrec /scanos
echo [[96mPERFORM[0m] Full rebuild of boot files in case previous attempts failed (bootrec /rebuildbcd)...
bootrec /rebuildbcd

echo [[96mPERFORM[0m] Loading WinPork backup Windows Registry keys and values...
reg import C:\winpork\regbackup\winpork-cmdpol-local-backup.reg
reg import C:\winpork\regbackup\winpork-exefile-backup.reg
reg import C:\winpork\regbackup\winpork-explorerpol-backup.reg
reg import C:\winpork\regbackup\winpork-syspol-backup.reg
reg import C:\winpork\regbackup\winpork-winlogon-backup.reg
reg import C:\winpork\regbackup\winpork-winpol-local-backup.reg

echo [[92mSUCCESS[0m] Full system scan and repair completed!

echo [[96mPERFORM[0m] Save of WinPork settings...
(
  echo [WINPORK RTE SETTINGS]
  echo This file houses all the settings WinPork uses. Edit with caution!
  echo=
  echo Enables the logging of the command history of WinPork in a .winpork file.
  echo %wpsettings_LogWinPorkCommandHistory%
) > C:\WinPork\saved\settings\settings.wpsettings

echo [[96mPERFORM[0m] Preparations for WinPork reboot...
echo User issued envreset > C:\winpork-logs\envresetlog.winpork
echo The WinPork Repair Tool Environment will be resetted shortly...
@reg import C:\winpork\reg\winporksetupmaintainer.reg
shutdown -r -t 0 -f
exit /b 0

:checkvulnerable2
echo [[91mFAIL[0m] Cancelled Windows Scan & Repair
exit /b 0