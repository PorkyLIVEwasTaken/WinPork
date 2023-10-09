@echo off
echo [[94mSTART[0m] New User Setup

REM 1=NORMAL/quick
REM 2=Username
REM 3=HasPassword{y/N}
REM 4=IsAdmin?{y/N}

goto :mode%1

:mode
:modenormal
set /p username="[[1;95mQUEST[0m] What would you like to be the name of the new user? "

net user %username% /add
net user %username% /active:yes
@net localgroup /add users %username%

set /p haspassword="[[1;95mQUEST[0m] Does %username% need a password? [y/N] "
goto :passnor%haspassword%

:passnory
net user %username% *
goto :continueadmin

:passnorn
goto :continueadmin

:continueadmin

set /p isadmin="[[1;95mQUEST[0m] Do you wish for %username to be an Administrator account (Y) or a regular User account (N)? [y/N] "
goto :uacnor%isadmin%

:uacnory
@net localgroup /add administrators %username%
echo [[92mSUCCESS[0m] Account %username has been created as an Administrator.
exit /b 0

:uacnorn
echo [[92mSUCCESS[0m] Account %username has been created as a User.
exit /b 0



:modequick
net user %2% /add
net user %2% /active:yes
@net localgroup /add users %2%

goto :haspassword%3%

:haspasswordy
net user %2% *
goto :finishpassword

:haspasswordn
goto :finishpassword

:finishpassword
goto :isadminquick%4%

:isadminquicky
@net localgroup /add administrators %2%
echo [[92mSUCCESS[0m] Account %2% has been created as an Administrator.
exit /b 0

:isadminquickn
echo [[92mSUCCESS[0m] Account %2% has been created as a User.
exit /b 0