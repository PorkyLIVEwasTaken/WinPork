@echo off
setlocal enabledelayedexpansion

goto :type%1%

:typecall
goto %2
:-debug
	adb shell input keyevent KEYCODE_CALL
	timeout /t 1 /nobreak
	adb shell input text '*#0*#'
	endlocal
	exit /b 0

:-imei
	adb shell input keyevent KEYCODE_CALL
	timeout /t 1 /nobreak
	adb shell input text '*#06#'
	endlocal
	exit /b 0

:-stats
	adb shell input keyevent KEYCODE_CALL
	timeout /t 1 /nobreak
	adb shell input text '*#*#4636#*#*'
	endlocal
	exit /b 0

:-sar
	adb shell input keyevent KEYCODE_CALL
	timeout /t 1 /nobreak
	adb shell input text '#07#'
	endlocal
	exit /b 0

:-swhwi
	adb shell input keyevent KEYCODE_CALL
	timeout /t 1 /nobreak
	adb shell input text '*#12580*369#'
	endlocal
	exit /b 0

:-mac
	adb shell input keyevent KEYCODE_CALL
	timeout /t 1 /nobreak
	adb shell input text '*#*#232338#*#*'
	endlocal
	exit /b 0

:-cal
	adb shell input keyevent KEYCODE_CALL
	timeout /t 1 /nobreak
	adb shell input text '*#*#225#*#*'
	endlocal
	exit /b 0

:-playservdiag
	adb shell input keyevent KEYCODE_CALL
	timeout /t 1 /nobreak
	adb shell input text '*#*#426#*#*'
	endlocal
	exit /b 0

:-gpstest
	adb shell input keyevent KEYCODE_CALL
	timeout /t 1 /nobreak
	adb shell input text '*#*#1472365#*#*'
	endlocal
	exit /b 0

:-callerid
	adb shell input keyevent KEYCODE_CALL
	timeout /t 1 /nobreak
	adb shell input text '*31#'
	endlocal
	exit /b 0

:-2callnotif
	adb shell input keyevent KEYCODE_CALL
	timeout /t 1 /nobreak
	adb shell input text '*43#'
	endlocal
	exit /b 0

:-battery
	adb shell input keyevent KEYCODE_CALL
	timeout /t 1 /nobreak
	adb shell input text '*#0228#'
	endlocal
	exit /b 0

:-camhw
	adb shell input keyevent KEYCODE_CALL
	timeout /t 1 /nobreak
	adb shell input text '##34971539##'
	endlocal
	exit /b 0

:-lbp
	adb shell input keyevent KEYCODE_CALL
	timeout /t 1 /nobreak
	adb shell input text '##0283##'
	endlocal
	exit /b 0

:-signal
	adb shell input keyevent KEYCODE_CALL
	timeout /t 1 /nobreak
	adb shell input text '3001#12345#'
	endlocal
	exit /b 0

:-cfs
	adb shell input keyevent KEYCODE_CALL
	timeout /t 1 /nobreak
	adb shell input text '*#67#'
	endlocal
	exit /b 0

:-factory_reset
if %3==-confirm (
	adb shell input keyevent KEYCODE_CALL
	timeout /t 1 /nobreak
	adb shell input text '*#*#7780#*#*'
	endlocal
	exit /b 0
) else (
	echo As this is a factory reset number, you are required to use "phone call factory_reset -confirm".
	endlocal
	exit /b 0
)

adb shell am start -a android.intent.action.CALL -d tel:%2%
endlocal
exit /b 0

:typehangup
adb shell input keyevent KEYCODE_ENDCALL
endlocal
exit /b 0

:typesms
adb shell am start -a android.intent.action.SENDTO -d sms:%2   --es sms_body '' --ez exit_on_sent false
@timeout /t 1 /nobreak
adb shell input text '%3'
@timeout /t 1 /nobreak
if %4==-send (
	echo Request send SMS
	adb shell input keyevent KEYCODE_TAB
	adb shell input keyevent KEYCODE_TAB
	adb shell input keyevent KEYCODE_ENTER
) else (
	echo No SMS request
)
endlocal
exit /b 0

:typereboot
adb reboot %2%
endlocal
exit /b 0

:typeinput
adb shell input text '%2%'
endlocal
exit /b 0

:typekey
adb shell input keyevent KEYCODE_%2%
endlocal
exit /b 0

:typehome
adb shell input keyevent KEYCODE_HOME
endlocal
exit /b 0

:typenotif
adb shell input keyevent KEYCODE_NOTIFICATION
endlocal
exit /b 0

:typemail
adb shell input keyevent KEYCODE_ENVELOPE
endlocal
exit /b 0

:typebrowser
adb shell input keyevent KEYCODE_EXPLORER
endlocal
exit /b 0

:typecontacts
adb shell input keyevent KEYCODE_CONTACTS
endlocal
exit /b 0

:typecalc
adb shell input keyevent KEYCODE_CALCULATOR
endlocal
exit /b 0

:typecal
adb shell input keyevent KEYCODE_CALENDAR
endlocal
exit /b 0

:typeswitch
adb shell input keyevent KEYCODE_APP_SWITCH
goto %2

:clear

if not "%5"=="" (
	for /l %%i in (1,1,%5) do (
	   adb shell input swipe 200 600 500 600
	)
)

if "%3"=="" (
	adb shell input swipe 600 1000 600 200
) else (
	for /l %%i in (1,1,%3) do (
    adb shell input swipe 600 1000 600 200
)
)

if %4==-touch (
	adb shell input tap 600 600
)
if %4==-home (
	adb shell input keyevent KEYCODE_HOME
)

endlocal
exit /b 0

:left
if "%3"=="" (
	adb shell input swipe 200 600 500 600
) else (
	for /l %%i in (1,1,%3) do (
    adb shell input swipe 200 600 500 600
)
)
goto :switchnotouch

:right
if "%3"=="" (
	adb shell input swipe 500 600 200 600
) else (
	for /l %%i in (1,1,%3) do (
    adb shell input swipe 500 600 200 600
)
)
:switchnotouch

if %4==-touch (
	adb shell input tap 600 600
)

endlocal
exit /b 0

:typetap
if "%2"=="" (
	adb shell input tap 600 600
) else (
	adb shell input tap %2 %3
)
endlocal
exit /b 0

:typeresolution
adb shell wm size %2%
endlocal
exit /b 0

:typeunlock
adb shell input keyevent KEYCODE_WAKEUP
adb shell input keyevent KEYCODE_MENU
if %2%==[] (
	echo No password recieved, assuming phone does not have one.
) else (
	adb shell input text '%2'
	adb shell input keyevent KEYCODE_ENTER
)
endlocal
exit /b 0

:typelock
adb shell input keyevent KEYCODE_SLEEP
endlocal
exit /b 0

:typemakephoto
adb shell input keyevent KEYCODE_CAMERA
timeout /t %2% /nobreak
adb shell input keyevent KEYCODE_ENTER
endlocal
exit /b 0

:typescreenshot
set localandroidscreencaplocation=screenshot_%random%.png
adb shell screencap -p /sdcard/%localandroidscreencaplocation%
if %2==-pull (
	mkdir C:\WinPork\wp\lib\imgs\screencap
	adb pull /sdcard/%localandroidscreencaplocation% C:\WinPork\wp\lib\imgs\screencap
)
endlocal
exit /b 0

:typedens
adb shell wm density %2%
endlocal
exit /b 0

:typeversion
adb shell getprop ro.build.version.release
endlocal
exit /b 0

:typeback
if "%2"=="" (
	adb shell input keyevent KEYCODE_BACK
) else (
	for /l %%i in (1,1,%2) do (
    adb shell input keyevent KEYCODE_BACK
)
)
endlocal
exit /b 0

endlocal
exit /b 0