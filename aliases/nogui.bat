@echo off

goto :page%1%

echo [[33mWARN[0m] All commands are only available in the C:\ drive. Type "root" to go back to the C: hard drive.
echo List of available WinPork commands: ([[1;95mINFO[0m] All Windows Command Prompt commands are available as well. Type "help" to display those.)'
echo=

:page
:page1
echo -====================================================-
echo reboot [safe]
echo Shutdown WinPork and reboot the computer. 
echo -====================================================-
echo envreset
echo Reset the WinPork Environment and reboot the computer.
echo -====================================================-
echo bootfw
echo Reboots your computer to the BIOS of your firmware.
echo -====================================================-
echo rac
echo Attempts to reboot your computer with WinPork in Companion Mode.
echo -====================================================-
echo shutdown
echo Power off the computer.
echo -====================================================-
echo fileboot {FilePath}
echo Reboot WinPork, but run the specified file instead of the RTE.
echo ([[33mWARN[0m] This command can brick your computer if used incorrectly. Use with caution!)
echo -====================================================-
echo nogui {pageNumber}
echo Shows this help message.
echo {pageNumber} = Help page to display
echo -====================================================-
echo wpver [print]
echo Shows the current version of WinPork.
echo -====================================================-
echo clearscreen
echo Clears the WinPork teminal.
echo -====================================================-
echo settings [...]
echo Runs the settings wizard.
echo -====================================================-
echo fs / wd
echo Changes WinPork to Fullscreen or Windowed Mode, respectively.
echo -====================================================-
echo wait [seconds] [quick]
echo Let WinPork wait for a few seconds. 
echo If no arguments are given, WinPork will ask for how long it needs to wait.
echo -====================================================-
echo history
echo Returns all previous commands run in this WinPork session.
echo -====================================================-
echo ucid
echo Shows WinPork Computer ID.
echo -====================================================-
echo wiki
echo Shows the WinPork wiki.
echo -====================================================-
REM echo as {User} {Command}
REM echo Runs a command as a different user.
REM echo -====================================================-
echo= 
echo [[1;95mINFO[0m] HELP PAGE 1/7
exit /b 0

:page2
echo -====================================================-
echo newuser {NORMAL/quick} [Username] [HasPassword{y/N}] [IsAdmin{y/N}]
echo Creates a new user.
echo -====================================================-
echo deluser {username}
echo Deletes a user.
echo {username} = User to be deleted
echo -====================================================-
echo user {username}
echo Navigate to the directory of the specified user.
echo [[1;95mINFO[0m] If no username is specified, the "C:\Users" folder will be opened instead.
echo {username} = User to go to
echo -====================================================-
echo admin {y/N}
echo Enables / Disables the Administrator account respectively.
echo -====================================================-
echo gentestfile {size}
echo Generates a Test File in C:\Generated Test Files with the specified size.
echo {size} = File Size in bytes
echo -====================================================-
echo deltestfile
echo Deletes all test files.
echo -====================================================-
echo idgen
echo Generates a new WinPork ID. Does not alter existing IDs.
echo -====================================================-
echo=  
echo [[1;95mINFO[0m] HELP PAGE 2/7
exit /b 0

:page3
echo -====================================================-
echo sys
echo Navigate to system32.
echo -====================================================-
echo root
echo Navigate to C:\
echo -====================================================-
echo verboselogon {y/n}
echo Enables / Disables verbose login messages respectively.
echo -====================================================-
echo cursor {y/n}
echo Shows / Hides the cursor respectively. ([[33mWARN[0m] Might not work on all versions of Windows.)
echo -====================================================-
echo wpmenu {y/n}
echo Shows / Hides the 'Boot WinPork' option in the Desktop Context Menu respectively. ([[33mWARN[0m] Might not work on all versions of Windows.)
echo -====================================================-
echo scanquick {y/n}
echo Make some quick scans and repairs any missing or corrupt Windows System Files.
echo -====================================================-
echo scanfull {y/n}
echo Fully scans your computer for any potential problems that might prevent Windows from working.
echo -====================================================-
echo pong / llb
echo Pings 127.0.0.1 to check if your network card is still working.
echo -====================================================-
echo skcp
echo Enables / Disables opening Command Prompt after pressing the SHIFT-key 5 times. ([[33mWARN[0m] Sticky Keys will not be available through pressing SHIFT 5 times.)
echo -====================================================-
echo ext {y/n}
echo Enables / Disables the .winpork extension respectively.
echo -====================================================-
echo=  
echo [[1;95mINFO[0m] HELP PAGE 3/7
exit /b 0

:page4
echo -====================================================-
echo events
echo Shows the Event Viewer.
echo -====================================================-
echo sysinfo
echo Shows information about your system.
echo -====================================================-
echo intset
echo Shows your Internet Settings.
echo -====================================================-
echo sysres
echo Allows you to restore your system.
echo -====================================================-
echo scheduler
echo Shows the Task Scheduler.
echo -====================================================-
echo=  
echo [[1;95mINFO[0m] HELP PAGE 4/7
exit /b 0

:page5
echo -====================================================-
echo weather [Location]
echo Shows the current weather in the specified location. If no location has been given, it will show the weather of your current location.
echo -====================================================-
echo unshort-url {URL}
echo Unshortens shortened URLs, if applicable.
echo -====================================================-
echo urlinfo {URL}
echo Returns information about the given URL.
echo -====================================================-
echo publicip
echo Returns the computer's public IP address.
echo -====================================================-
echo genqr {URL}
echo Generates a QR-code for the given URL.
echo -====================================================-
echo yt-latest {Channel}
echo Returns the title of the latest YouTube video of the given YouTube Channel.
echo -====================================================-
echo twt-latest {Username}
echo Returns the latest Tweet of the given Twitter Username.
echo -====================================================-
echo dict [Word]
echo Returns the definition of the given word.
echo -====================================================-
echo=  
echo [[1;95mINFO[0m] HELP PAGE 5/7
exit /b 0

:page6
echo -====================================================-
echo storage
echo Opens the WinPork Storage.
echo -====================================================-
echo wpuser
echo Tool to add or remove WinPork users.
echo -====================================================-
echo uuid
echo Shows WinPork User ID of the current user.
echo -====================================================-
echo sign {User}
echo Changes directory to the given wp-user.
echo -====================================================-
echo create {Filename+Extension}
echo Creates a new file with the given file name and extension in the current directory.
echo -====================================================-
echo acid {FileName+Extension}
echo Moves the file with the given name to the Trash Bin.
echo -====================================================-
echo crypt
echo Opens WinPork Crypt.
echo -====================================================-
echo=  
echo [[1;95mINFO[0m] HELP PAGE 6/7
exit /b 0h

:page7
echo -====================================================-
echo cdrom {open/close} {Drive}
echo Opens/Closes the specified Drive Bay.
echo -====================================================-
echo hardmon {on/off}
echo Turns the monitor on/off.
echo -====================================================-
echo mute
echo Turns the system audio on/off.
echo -====================================================-
echo rasdial {dial/hangup}
echo Dials / hangs up the given Internet connection.
echo -====================================================-
<<<<<<< Updated upstream
=======
echo display {width} {height} {colors}
echo Sets the display to the set width, height and colors.
echo -====================================================-
>>>>>>> Stashed changes
echo=  
echo [[1;95mINFO[0m] HELP PAGE 7/7
exit /b 0h