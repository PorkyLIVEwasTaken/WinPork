@echo off

echo [[96mPERFORM[0m] Size window with parms [cols=225 lines=60]...
mode con: cols=208 lines=54 
nircmd.exe win -style ititle "WinPork RTE" 0x00C00000
nircmd.exe win -style ititle "WinPork RTE" 0x00040000
nircmd.exe win max ititle "WinPork RTE"
echo [[92mSUCCESS[0m] Switched to Fullscreen Mode!

exit /b 0