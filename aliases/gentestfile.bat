@echo off
echo [[94mSTART[0m] Test File Generator

@mkdir "C:\winpork\Generated Test Files"
@fsutil file createnew "C:\winpork\Generated Test Files\winpork.gtf" %1

echo [[92mSUCCESS[0m] Generated Test File of %1 bytes in C:\winpork\Generated Test Files