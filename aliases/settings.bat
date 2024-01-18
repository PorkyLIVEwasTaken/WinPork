@echo off
setlocal enabledelayedexpansion

goto command%1%
 
REM set wpsettings_LogWinPorkCommandHistory="true"
REM set wpsettings_DisableWinPorkWelcomeScreen="false"
REM set wpsettings_NoSavLocRead="false"
REM set wpsettings_UseWP_Theme="true"
REM set wpsettings_PauseAfterBoot="false"
REM set wpsettings_NoModLoading="false"
REM set wpsettings_SkipOS_check="false"
REM set wpsettings_SkipCPU_check="false"
REM set wpsettings_SkipRAM_check="false"
REM set wpsettings_SkipNetworkCheck="false"

REM copy nul C:\WinPork\wp\var\wps_lwpch.b
REM copy nul C:\WinPork\wp\var\boot\wps_dwws.b
REM copy nul C:\WinPork\wp\var\boot\wps_nSLr.b
REM copy nul C:\WinPork\wp\var\boot\wps_uWPt.b
REM copy nul C:\WinPork\wp\var\boot\wps_pab.b
REM copy nul C:\WinPork\wp\var\boot\wps_nml.b
REM copy nul C:\WinPork\wp\var\boot\chk\wps_SOSc.b
REM copy nul C:\WinPork\wp\var\boot\chk\wps_SCPUc.b
REM copy nul C:\WinPork\wp\var\boot\chk\wps_SRAMc.b
REM copy nul C:\WinPork\wp\var\boot\chk\wps_Snetc.b
REM copy nul C:\WinPork\wp\sys\bootr.d

:command
echo [[94mSTART[0m] Settings Wizard

:c1
choice /m "Do you wish to enable (Y) or disable (N) logging the WinPork Command History?"
goto :1%errorlevel%
:11
@copy nul "C:\WinPork\wp\var\wps_lwpch.b"
goto c2
:12
@del "C:\WinPork\wp\var\wps_lwpch.b" /q
goto c2



:c2
choice /m "Do you wish to enable (Y) or disable (N) the WinPork welcome screen?"
goto :2%errorlevel%
:21
@del "C:\WinPork\wp\var\boot\wps_dwws.b" /q
goto c3
:22
@copy nul "C:\WinPork\wp\var\boot\wps_dwws.b"
goto c3



:c3
choice /m "Do you wish to enable (Y) or disable (N) SavLoc reading?"
goto :3%errorlevel%
:31
@del "C:\WinPork\wp\var\boot\wps_nSLr.b" /q
goto c4
:32
@copy nul "C:\WinPork\wp\var\boot\wps_nSLr.b"
goto c4

:c4
choice /m "Do you wish to enable (Y) or disable (N) the WinPork theme?"
goto :4%errorlevel%
:41
@copy nul "C:\WinPork\wp\var\boot\wps_uWPt.b"
goto c5
:42
@del "C:\WinPork\wp\var\boot\wps_uWPt.b" /q
goto c5



:c5
choice /m "Do you wish to enable (Y) or disable (N) pausing after boot?"
goto :5%errorlevel%
:51
@copy nul "C:\WinPork\wp\var\boot\wps_pab.b"
goto c6
:52
@del "C:\WinPork\wp\var\boot\wps_pab.b" /q
goto c6



:c6
choice /m "Do you wish to enable (Y) or disable (N) loading community-made scripts?"
goto :6%errorlevel%
:61
@del "C:\WinPork\wp\var\boot\wps_nml.b" /q
goto c7
:62
@copy nul "C:\WinPork\wp\var\boot\wps_nml.b"
goto c7



:c7
choice /m "Do you wish to enable (Y) or disable (N) skipping the Operating System on boot?"
goto :7%errorlevel%
:71
@copy nul "C:\WinPork\wp\var\boot\chk\wps_SOSc.b"
goto c8
:72
@del "C:\WinPork\wp\var\boot\chk\wps_SOSc.b" /q
goto c8



:c8
choice /m "Do you wish to enable (Y) or disable (N) skipping the CPU on boot?"
goto :8%errorlevel%
:81
@copy nul "C:\WinPork\wp\var\boot\chk\wps_SCPUc.b"
goto c9
:82
@del "C:\WinPork\wp\var\boot\chk\wps_SCPUc.b" /q
goto c9



:c9
choice /m "Do you wish to enable (Y) or disable (N) skipping the RAM on boot?"
goto :9%errorlevel%
:91
@copy nul "C:\WinPork\wp\var\boot\chk\wps_SRAMc.b"
goto c10
:92
@del "C:\WinPork\wp\var\boot\chk\wps_SRAMc.b" /q
goto c10



:c10
choice /m "Do you wish to enable (Y) or disable (N) skipping the Network Card on boot?"
goto :10%errorlevel%
:101
@copy nul "C:\WinPork\wp\var\boot\chk\wps_Snetc.b"
goto c11
:102
@del "C:\WinPork\wp\var\boot\chk\wps_Snetc.b" /q
goto c11



:c11

echo [[92mSUCCESS[0m] Completed Settings Wizard!
endlocal
exit /b 0



:command-reset
copy nul C:\WinPork\wp\var\wps_lwpch.b
del C:\WinPork\wp\var\boot\wps_dwws.b /q
del C:\WinPork\wp\var\boot\wps_nSLr.b /q
copy nul C:\WinPork\wp\var\boot\wps_uWPt.b
del C:\WinPork\wp\var\boot\wps_pab.b /q
del C:\WinPork\wp\var\boot\wps_nml.b /q
del C:\WinPork\wp\var\boot\chk\wps_SOSc.b /q
del C:\WinPork\wp\var\boot\chk\wps_SCPUc.b /q
del C:\WinPork\wp\var\boot\chk\wps_SRAMc.b /q
del C:\WinPork\wp\var\boot\chk\wps_Snetc.b /q
echo [[92mSUCCESS[0m] WinPork Settings have been reset to default values!
exit /b 0