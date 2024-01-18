@echo off
echo [[94mSTART[0m] Preparing WinPork command center...
echo [[96mPERFORM[0m] Move current dir to C:\...
cd C:\
echo [[96mPERFORM[0m] Size window with parms [cols=100 lines=50]...
mode con: cols=100 lines=50
echo [[96mPERFORM[0m] Rewrite prompt to string [WINPORK $P$$]...
prompt WINPORK $P$$
echo [[96mPERFORM[0m] Set window title [WinPork Run As Companion]...
title WinPork Run As Companion
echo [[92mSUCCESS[0m] Prepared WinPork command center!
echo=
cls
powershell write-host -fore White -back Magenta Welcome to WinPork!
echo=
echo Welcome to WinPork RTE!
echo=
echo The programs included with the WinPork system are free software; the exact distribution terms for each program are described in the individual files in C:\WinPork\LICENSE.
echo WinPork comes with ABSOLUTELY NO WARRANTY, and the creators are NOT responsible for any damages done by using WinPork, to the extend permitted by applicable law.
echo=
echo [[33mWARN[0m] Not all commands might be available through WinPork Run As Companion!
echo Type "nogui" for a list of available WinPork commands.