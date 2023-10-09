@echo off

curl --head --location "%1%" | findstr Location
exit /b 0