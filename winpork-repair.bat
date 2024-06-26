@echo off
title WinPork RTE Initializer

REM Insert WinPork Version here, winpork.wpver is deprecated.
set wp_ver=OpenPorkerOS-WPRTE-1.3

echo WinPork RTE succesfully booted up on version %wp_ver% > C:\winpork-logs\bootlog_%date%_%time%.winpork
echo [[92mSUCCESS[0m] WinPork RTE bootup on version %wp_ver%
echo System Timestamp: %date% %time%
echo=
powershell write-host -fore White -back Magenta Welcome to WinPork!
echo=

echo [[94mSTART[0m] Activating WinPork auto-disable on reboot...
echo [[96mPERFORM[0m] WinPork startup regkey cleanup...
reg import C:\winpork\reg\winporksetupcloser.reg
setx quitreason "0xC0000139"
echo [[92mSUCCESS[0m] WinPork disables at reboot!

echo [[96mPERFORM[0m] Importing predefined files and directories to file system...
xcopy "C:\WinPork\.wp\*" "C:\WinPork\wp\" /E /C /I /Q /H /R /K /Y
xcopy "C:\WinPork\addons\*" "C:\WinPork\aliases\.mod" /E /C /I /Q /H /R /K /Y

echo [[94mSTART[0m] Preparing WinPork commands...
echo [[96mPERFORM[0m] Recognising WinPork command aliases...
echo [[96mPERFORM[0m] Mounting community-made Commands...
set "PATH=%PATH%;C:\WinPork\aliases"

if not exist C:\WinPork\wp\var\boot\wps_nml.b (
set "PATH=%PATH%;C:\WinPork\aliases\.mod"
	goto continuesavloc
) else (
  echo [[33mWARN[0m] Settings dictated that no community-made Commands should be mounted, skipping...
  goto continuesavloc
)
:continuesavloc

echo [[96mPERFORM[0m] Recognising addon command aliases...

REM List of all addons that should be loaded!
set "PATH=%PATH%;C:\WinPork\addons\nircmd"

set "PATH=%PATH%;C:\WinPork\addons\adb"
adb devices

echo [[92mSUCCESS[0m] Prepared WinPork commands!

echo [[96mPERFORM[0m] Size window with parms [cols=225 lines=60]...
mode con: cols=208 lines=54 
nircmd.exe win -style ititle "WinPork RTE" 0x00C00000
nircmd.exe win -style ititle "WinPork RTE" 0x00040000
nircmd.exe win max ititle "WinPork RTE"
nircmd.exe win settopmost ititle "WinPork RTE" 1

echo [[96mPERFORM[0m] WinPork UCID Verification Check...
< C:\WinPork\wp\aether\ucid.wp ( 
    set /p wpUCID=
  )

echo WPUCID = %wpUCID%

echo [[96mPERFORM[0m] Check for full dirtree...
if exist C:\WinPork\wp\sys\dtr.b (
	goto continuedirtree
) else (
	xcopy C:\WinPork\templates\wp C:\WinPork\wp /E /C /I /Q /H /R /K /Y
	copy nul C:\WinPork\wp\sys\dtr.b
	
	setlocal enabledelayedexpansion

	rem Clear existing symbolic links
	del /q "C:\WinPork\wp\dsk\*"

	rem Loop through drive letters from A to Z
	for %%I in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
		rem Determine the link name based on the drive letter
		if "%%I"=="A" (
			set linkName=fdA
		) else if "%%I"=="B" (
			set linkName=fdB
		) else if "%%I"=="C" (
			set linkName=sysdC
		) else (
			set linkName=ext%%I
		)

		rem Create the symbolic link
		mklink "C:\WinPork\wp\dsk\!linkName!" "%%I:\"
	)

	echo [SUCCESS] Symbolic links created for drives A: through Z:

	@attrib +r +h +s C:\WinPork\wp\desktop.ini
	@attrib +s C:\WinPork\wp\

	endlocal
	goto continuedirtree
)

:continuedirtree
echo [[92mSUCCESS[0m] WinPork Storage system ready!

echo [[96mPERFORM[0m] Checking for WinPork bootfile...
if exist C:\WinPork\wp\sys\bootr.d (
	echo [[92mSUCCESS[0m] Bootfiles found, continuing...
	goto continueboot
) else (
	@cmd /k "C:\WinPork\wpsetup.bat"
	goto continueboot
)
:continueboot

echo [[94mSTART[0m] Loading WinPork settings...
if exist C:\WinPork\wp\sys\setpfl.b (
  goto continuesettings
) else (
  echo [[33mWARN[0m] No settings files have been detected, returning to default settings...
  copy nul C:\WinPork\wp\var\wps_lwpch.b
  REM copy nul C:\WinPork\wp\var\boot\wps_dwws.b
  REM copy nul C:\WinPork\wp\var\boot\wps_nSLr.b
  REM copy nul C:\WinPork\wp\var\boot\wps_uWPt.b
  REM copy nul C:\WinPork\wp\var\boot\wps_pab.b
  REM copy nul C:\WinPork\wp\var\boot\wps_nml.b
  REM copy nul C:\WinPork\wp\var\boot\chk\wps_SOSc.b
  REM copy nul C:\WinPork\wp\var\boot\chk\wps_SCPUc.b
  REM copy nul C:\WinPork\wp\var\boot\chk\wps_SRAMc.b
  REM copy nul C:\WinPork\wp\var\boot\chk\wps_Snetc.b
  copy nul C:\WinPork\wp\var\boot\wps_ufsm.b
  REM copy nul C:\WinPork\wp\var\pref\wps_wallpaper.loc
  if not exist C:\WinPork\wp\var\boot\chk\minram.int (
	echo 16777216 > C:\WinPork\wp\var\boot\chk\minram.int
  )

  if not exist C:\WinPork\wp\var\boot\rooted.b (
	copy nul C:\WinPork\wp\root.root
	attrib +r +h +s C:\WinPork\wp\root.root
	echo C:\WinPork\wp\ > C:\WinPork\wp\sys\wp.loc
	attrib +r +h +s C:\WinPork\wp\sys\wp.loc
  )

  < C:\WinPork\wp\var\boot\chk\minram.int (
    set /p MINRAM=
  )
  
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
REM set wpsettings_UseFullScreenMode="true"

copy nul C:\WinPork\wp\sys\setpfl.b

goto continuesettings
)
:continuesettings
echo [[92mSUCCESS[0m] WinPork Settings loaded!

if not exist C:\WinPork\wp\var\boot\chk\wps_SOSc.b (
echo [[96mPERFORM[0m] WinPork Operating System Check...
wmic os get ostype, buildnumber, osarchitecture, oslanguage, status, lastbootuptime, version, windowsdirectory
goto continueOS
) else (
echo [[33mWARN[0m] Settings dictated that Operating System should not be checked, skipping...
goto continueOS
)
:continueOS

if not exist C:\WinPork\wp\var\boot\chk\wps_SCPUc.b (
echo [[96mPERFORM[0m] WinPork CPU Check...
wmic cpu get deviceid, numberofcores, maxclockspeed
goto continueCPU
) else (
echo [[33mWARN[0m] Settings dictated that CPU should not be checked, skipping...
goto continueCPU
)
:continueCPU

if not exist C:\WinPork\wp\var\boot\chk\wps_SRAMc.b (
echo [[94mSTART[0m] WinPork Memory preparation...

echo [[96mPERFORM[0m] Checking available storage space for Memory...
setlocal enabledelayedexpansion

REM Replace "C:" with the drive or directory you want to check
set "drive=C:\WinPork\wp\sys\core\RAM\"

for /f "tokens=2,3" %%a in ('dir !drive! ^| find /i "bytes free"') do (
    set "freeSpace=%%a"
    set "unit=%%b"
)

echo Free space on %drive%: %freeSpace% %unit% bytes
endlocal

@schtasks /create /tn "DeleteMemoryOnShutdown" /sc ONSTART /ru "System" /tr "C:\WinPork\schtasks\delmem.bat" /f

echo [[96mPERFORM[0m] Checking system writing rights for Memory...
@fsutil file createnew "C:\WinPork\wp\sys\core\RAM\memtester.wpmem" 16777216
@del "C:\WinPork\wp\sys\core\RAM\memtester.wpmem" /f

echo [[96mPERFORM[0m] Creating empty Memory file...
@fsutil file createnew "C:\WinPork\wp\sys\core\RAM\core.mem" 0
@attrib +r +h "C:\WinPork\wp\sys\core\RAM\core.mem"

echo [[92mSUCCESS[0m] WinPork Memory file ready!
goto continueRAM
) else (
echo [[33mWARN[0m] Settings dictated that RAM should not be checked, skipping...
goto continueRAM
)
:continueRAM

echo [[94mSTART[0m] Preparing WinPork Storage system...
mkdir C:\WinPork\wp\aether
@attrib +h "C:\WinPork\wp\aether"
if exist C:\WinPork\wp (
    goto continuewpstorage
) else (
    echo [[33mWARN[0m] No storage system has been detected, creating a new one...
    mkdir C:\WinPork\wp
)
:continuewpstorage

echo [[96mPERFORM[0m] Making SavLoc Read-Only...
@attrib +r +h "C:\WinPork\wp\savloc.wpmem"
@attrib +r +h "C:\WinPork\wp\aether"

if not exist C:\WinPork\wp\var\boot\chk\wps_nSLr.b (
  echo [[96mPERFORM[0m] Loading Saved locations from WinPork Memory File...
  < C:\WinPork\wp\savloc.wpmem (
    rem  
    rem  
    set /p WP_LOC=
    set /p WINROOT=
    set /p LASTUSER=
  )
  goto continuesavloc
) else (
  echo [[33mWARN[0m] Settings dictated that no saved locations should be read, skipping...
  goto continuesavloc
)
:continuesavloc

echo [[94mSTART[0m] Network check...
echo [[96mPERFORM[0m] Local loopback test to check network card health...
if not exist C:\WinPork\wp\var\boot\chk\wps_Snetc.b (
	@ping 127.0.0.1

	if %errorlevel% == 0 (
		echo [[92mSUCCESS[0m] Network card ready!
		goto :continuenetwork
	) else (
		echo [[91mFAIL[0m] Local loopback returned one or multiple packet losses, consider replacing your network card.
		timeout /t 5
		goto :continuenetwork
	)
)
:continuenetwork

if not exist "C:\WinPork\wp\var\boot\wps_dwws.b" (
	powershell -File "C:\WinPork\welcome.ps1"
	rem goto continuewelcomescreen
)
:continuewelcomescreen

if exist C:\WinPork\wp\var\boot\wps_pab.b (
	PAUSE
)

echo [[36mSOLO-PERFORM[0m] WinPork boot finisher...
@cmd /k "C:\winpork\winpork-boot-finisher.bat"