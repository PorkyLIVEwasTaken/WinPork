@echo off
echo [[94mSTART[0m] User Removal

net user %1 /delete
echo [[92mSUCCESS[0m] User %1 has been deleted