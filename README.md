# WinPork (WinPork-RTE)
 WinPork is a simple, minimalistic and user-friendly Windows-based Operating System, available for Windows 7 up until Windows 11.

## Installation
1. Download the code as a .zip file.
2. Open the .zip file. 
3. Copy the "WinPork-main" folder and paste it in your C:\ drive. Do not unpack the .zip, as this would result in the creation of an unnecessary folder we have to get rid of.

> [!IMPORTANT]
> No other drive but the C:\ drive is currently supported. We're working on some magic dynamic drive support!
4. Rename the "WinPork-main" folder to "WinPork"
> [!TIP]
> For easier access, drag the "WinPork RTE" shortcut onto your Desktop.
5. Done!

## First Launch
1. Open the "WinPork RTE" shortcut to start up WinPork.
> [!WARNING]
> This requires Administrative access and restarts your computer. Save any files before starting WinPork.

> [!CAUTION]
> WinPork is a powerful tool, and can be used to easily make changes that can have negative effects to your computer. Use caution while using WinPork. We are **not** responsible for any damages caused as a result of you using WinPork.
2. After your computer restarted, a command prompt should appear over the Windows bootscreen. If it did, WinPork got successfully deployed. If not, contact us for support.
3. WinPork will ask for you to enter a password for the Super-User. This password will be used to log in as the Super-User.
> [!IMPORTANT]
> Pick a password that you can remember! WinPork cannot be used if you do not log in!
4. After that, a pop-up will appear, warning you that using WinPork can be potentially hazardous for your computer. Close the pop-up window by pressing Enter on your keyboard.
> [!NOTE]
> Your cursor might be invisible in WinPork in some versions of Windows. If so, please navigate certain windows using your keyboard instead, or use the command "cursor force" to force the cursor to be displayed.
5. WinPork will now ask for your username and password. Enter `su` as username and password.
6. WinPork has now succesfully started!

## List of commands
> [!TIP]
> 1. You can use `nogui [pageNumber]` to get a list of commands that WinPork adds.
> 2. The commands used by Windows Command Prompt are available in WinPork as well, and Powershell commands can be ran using `powershell {command}`.

> [!NOTE]
> 1. Arguments in `[square brackets]` are optional, while `{curved brackets}` are required.
> 2. If a command asks for you to make a choice, the uppercase choice is the default choice. If no choice has been made, then the default option will be picked.

### WinPork Help & Info Commands
+ `nogui {pageNumber}`
  + Shows this help message.
  + {pageNumber} = Help page to display
+ `settings`
  + Opens the settings file of WinPork.
+ `wpver [print]`
  + Shows the current version of WinPork. Using `wpver print` will put the current version of WinPork in a text file.
+ `clearscreen` / `sr`
  + Clears the WinPork teminal.
+ `wait [seconds] [quick]`
  + Let WinPork wait for a few seconds. 
> [!NOTE]
> If no arguments are given, WinPork will ask for how long it needs to wait.
+ `history`
  + Returns all previous commands run in this WinPork session.
+ `ext {y/N}`
  + Enables / Disables the .winpork extension respectively.
+ `wpmenu {y/N}`
  + Shows / Hides the 'Boot WinPork' option in the Desktop Context Menu respectively.
> [!NOTE]
> Might not work on all versions of Windows.

### Restart / Shutdown Commands
+ `reboot [safe]`
  + Shutdown WinPork and reboot to Windows. Using `reboot safe` will restart the computer in Windows Safe Mode.
+ `envreset`
  + Restart WinPork.
+ `bootfw`
  + Reboots your computer to the BIOS of your firmware.
+ `rac`
  + Reboots your computer back to Windows. WinPork will start in Companion Mode once you have logged in.
+ `shutdown`
  + Shutdown the computer. Windows will be booted next time you turn on your computer.
+ `fileboot {FilePath}`
  + Reboot WinPork, but run the specified file instead of the RTE.
> [!CAUTION]
> The `fileboot` command can brick your computer if used incorrectly. Use with caution!

### WinPork Storage System Commands
+ `storage`
  + Opens the WinPork Storage.
+ `wpuser`
  + Tool to add or remove WinPork users, or to convert WinPork users to Windows accounts.
+ `sign {User}`
  + Changes directory to the given wp-user.
+ `create {Filename+Extension}`
  + Creates a new file with the given file name and extension in the current directory.
+ `crypt`
  + Opens WinPork Crypt.

### Windows User Account Commands
+ `newuser {NORMAL/quick} [Username] [HasPassword{y/N}] [IsAdmin{y/N}]`
  + Creates a new user. Normal will ask you several questions to create the account, whilst quick allows you to directly insert the acccount details as command arguments.
+ `deluser {username}`
  + Deletes a user.
  + {username} = User to be deleted
+ `user {username}`
  + Navigate to the directory of the specified user.
  + {username} = User to go to
> [!NOTE]
> If no username is specified, the "C:\Users" folder will be opened instead.
+ `admin {y/N}`
  + Enables / Disables the Administrator account respectively.

### Utility Commands
+ `gentestfile {size}`
  + Generates a Test File in C:\Generated Test Files with the specified size.
  + {size} = File Size in bytes
+ `deltestfile`
  + Deletes all test files.
+ `sys`
  + Navigate to system32.
+ `sysroot`
  + Navigate to C:\
+ `verboselogon {y/n}`
  + Enables / Disables verbose login messages respectively.
+ `cursor {y/n/force}`
  + Shows / Hides the cursor respectively.
> [!NOTE]
> Might not work on all versions of Windows.

> [!TIP]
> If the cursor does not show up after using `cursor y`, using `cursor force` might show the cursor anyways. 
+ `urlinfo {URL}`
  + Returns information about the given URL.
+ `publicip`
  + Returns the computer's public IP address.

### System Repair Commands
+ `scanquick {y/N}`
  + Make some quick scans and repairs any missing or corrupt Windows System Files.
+ `scanfull {y/N}`
  + Fully scans your computer for any potential problems that might prevent Windows from working.
+ `pong / llb`
  + Pings 127.0.0.1 to check if your network card is still working.
+ `skcp`
  + Enables / Disables opening Command Prompt after pressing the SHIFT-key 5 times.
> [!NOTE]
> Sticky Keys will not be available through pressing SHIFT 5 times.
+ `events`
  + Shows the Event Viewer.
+ `sysinfo`
  + Shows information about your system.
+ `intset`
  + Shows your Internet Settings.
+ `sysres`
  + Allows you to restore your system.
+ `scheduler`
  + Shows the Task Scheduler.

### Misc. Commands
+ `weather [Location]`
  + Shows the current weather in the specified location.
> [!TIP]
> If no location has been given, it will show the weather of your current location.
+ `unshort-url {URL}`
  + Unshortens shortened URLs, if applicable.
+ `genqr {URL}`
  + Generates a QR-code for the given URL.
+ `yt-latest {Channel}`
  + Returns the title of the latest YouTube video of the given YouTube Channel.
+ `twt-latest {Username}`
  + Returns the latest Tweet of the given Twitter Username.
+ `dict [Word]`
  + Returns the definition of the given word.
 
## List of WinPork Settings
> [!NOTE]
> The `C:\WinPork\saved\settings.wpsettings` file does not contain any documentation on its own. Instead, the documentation is available in the `C:\WinPork\saved\readme.txt` file.

> [!WARNING]
> The settings.wpsettings file contains settings that WinPork needs to properly operate. Edit with caution!

| Setting | Meaning | Default Value |
|--------:|------------|------------|
|LogWinPorkCommandHistory|Enables the logging of the command history of WinPork in a .winpork file.|true|
|DisableWinPorkWelcomeScreen|If true, the WinPork welcome screen will be disabled.|false|
|NoSavLocRead|If true, WinPork will no longer load saved locations on startup.|false|
|PreventSaveFolderCreation|If true, WinPork will no longer attempt to make a new "Saved" folder if it is missing.|false|
|UseWP_Theme|If true, WinPork will use it's own theme. If false, the default Windows CMD theme will be used.|true|
|PauseAfterBoot|If true, WinPork will wait for a key press before leaving the boot section.|false|

