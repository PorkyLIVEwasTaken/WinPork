@echo off
echo [[94mSTART[0m] WinPork Crypt
mkdir C:\WinPork\wp\tmp

:wpcryptreset

powershell write-host -fore White -back Magenta WinPork Crypt
echo "Please select an option:"
echo "[M] Create a new encrypted text file"
echo "[E] Encrypt a file"
echo "[D] Decrypt an encrypted file"
echo "[R] Remove an encrypted file"
echo "[C] Clear all decrypted files"
echo "[L] List of encrypted files stored in WinPork Crypt"
echo "[X] Exit WinPork Crypt"
choice /c MEDRCLX
goto :check%errorlevel%

:check1
copy nul "C:\WinPork\wp\tmp\tempencrypt.txt"
echo [[1;95mINFO[0m] Use the opened notepad to type/paste your text. Save the file when closing.
notepad "C:\WinPork\wp\tmp\tempencrypt.txt"
set /p cryptfilename="[[1;95mQUEST[0m] What is the name of the encrypted file? (This name is used to find the file back in the Crypt.) "
@certutil -encode "C:\WinPork\wp\tmp\tempencrypt.txt" "C:\WinPork\wp\users\%logonusername%\shdw\%cryptfilename%.wpcrypt"
@del "C:\WinPork\wp\tmp\tempencrypt.txt" /f /q
echo [[92mSUCCESS[0m] Encrypted your text!
goto :wpcryptreset

:check2
set /p originalfilelocation="[[1;95mQUEST[0m] What is the location of the file you wish to encrypt?"
set /p cryptfilename="[[1;95mQUEST[0m] What is the name of the encrypted file? Include the file extension. (This name is used to find the file back in the Crypt.) "
@certutil -encode %originalfilelocation% %cryptfilename%.wpcrypt
choice /m "Do you wish to remove the original file? "
goto :rmorig%errorlevel%

:rmorig1
@del %originalfilelocation% /f /q
echo [[92mSUCCESS[0m] Encrypted your file!
goto :wpcryptreset

:rmorig2
echo [[92mSUCCESS[0m] Encrypted your file!
goto :wpcryptreset

:check3
set /p cryptfilename="[[1;95mQUEST[0m] What is the full name of the encrypted file? (This name was specified when creating the encrypted file. Please include the file extension. Do not include '.wpcrypt'.) "
@certutil -decode "C:\WinPork\wp\wpcrypt\%cryptfilename%.wpcrypt" "C:\WinPork\Decrypted\%cryptfilename%"
echo [[92mSUCCESS[0m] Decrypted your file!
notepad "C:\WinPork\Decrypted\%cryptfilename%"
goto :wpcryptreset

:check4
set /p cryptfilename="[[1;95mQUEST[0m] What is the name of the encrypted file? (This name was specified when creating the encrypted file. Please include the file extension. Do not include '.wpcrypt'.) "
@del "C:\WinPork\wp\users\%logonusername%\shdw\%cryptfilename%.wpcrypt" /f /q
echo [[92mSUCCESS[0m] Deleted the encrypted text file!
goto :wpcryptreset

:check5
choice /m "This will delete all decrypted files in C:\WinPork\Decrypted\. Are you sure you want to continue? "
goto :rmdecrypt%errorlevel%

:rmdecrypt1
@del "C:\WinPork\Decrypted\." /f /q
echo [[92mSUCCESS[0m] Deleted all decrypted text files!
goto :wpcryptreset

:rmdecrypt2
echo "[[91mFAIL[0m] User cancelled operation."
goto :wpcryptreset

:check6
dir "C:\WinPork\wp\users\%logonusername%\shdw"
PAUSE
cls
powershell write-host -fore White -back Magenta Welcome to WinPork!

if %RAC% == 1 (
	echo [[33mWARN[0m] Not all commands might be available through WinPork Run As Companion!
)

echo Type "nogui" for a list of available WinPork commands.
goto :wpcryptreset

:check7
rmdir /s /q C:\WinPork\wp\tmp
echo [[91mCLOSE[0m] WinPork Crypt
exit /b 0