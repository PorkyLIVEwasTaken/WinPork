@echo off
setlocal enabledelayedexpansion

doskey history > C:\WinPork\wp\logs\%DATE%.log
echo [[92mSUCCESS[0m] Dumped WinPork log!

exit /b 0