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
echo [[33mWARN[0m] Not all commands might be available through WinPork Run As Companion!
echo=
echo Type "nogui" for a list of available WinPork commands.