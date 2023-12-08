@echo off

copy "%cd%\%1%" "C:\WinPork\wp\lib\%2%\%1%"
echo [[92mSUCCESS[0m] Shared the specified file!
exit /b 0