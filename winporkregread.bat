@echo off

setlocal enabledelayedexpansion
:: Define a function to check a registry value and set an environment variable based on its value
:CheckRegistryValue
set "RegKey=%~1"
set "ValueName=%~2"
:: Use the "reg" command to query the registry value
for /f "tokens=2*" %%A in ('reg query "%RegKey%" /v "%ValueName%" 2^>nul ^| find "%ValueName%"') do (
    set "RegValue=%%B"
)
if defined RegValue (
    echo The registry value %RegKey%\%ValueName% exists and has the value: %RegValue%
    if %RegValue%"==0x0 (
        set "wpsettings_%ValueName%"="false"
		goto :regnextstep1
    ) else if "%RegValue%"==1x0 (
        set "wpsettings_%ValueName%"="true"
		goto :regnextstep1
    ) else (
        set "wpsettings_%ValueName%=undefined"
		goto :regnextstep1
    )
	:regnextstep1
	goto :regnextstep2
) else (
    echo The registry value %RegKey%\%ValueName% does not exist.
	goto :regnextstep2
)
:regnextstep2
:: Return to the caller
exit /b