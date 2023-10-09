@echo off
echo [[94mSTART[0m] Pinging Local Loopback IP for network card health check (ping 127.0.0.1)...
ping 127.0.0.1
echo [[1;95mINFO[0m] If all pings returned an error, please replace your network card.
echo [[92mSUCCESS[0m] Completed Local Loopback IP ping!
exit /b 0