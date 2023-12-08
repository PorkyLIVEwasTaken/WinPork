$Msg = 'Welcome to WinPork RTE!

The programs included with the WinPork system are free software; the exact distribution terms for each program are described in the individual files in C:\WinPork\LICENSE.

WinPork comes with ABSOLUTELY NO WARRANTY, to the extend permitted by applicable law.'
powershell -Command "& {Add-Type -AssemblyName System.Windows.Forms; [System.Windows.Forms.MessageBox]::Show('$Msg','WinPork RTE','OK',[System.Windows.Forms.MessageBoxIcon]::Warning);}" 