@echo off

copy nul "%cd%\%1%"
echo [[1;95mINFO[0m] Use the opened notepad to edit your file. Save the file when closing.
notepad "%cd%\%1%"