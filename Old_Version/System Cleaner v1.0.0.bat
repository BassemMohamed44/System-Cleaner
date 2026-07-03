@echo off
:: ===========================================================
::      Auto Elevate to Administrator (Self-Run as Admin)
:: ===========================================================
>nul 2>&1 net session || (
    echo We are Waiting For Approval To grant Run As Administrator...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)


color 05
title  System Cleaner Edition - By Bassem Mohamed
chcp 65001 >nul
:: ===========================================================
::                     ASCII ART
:: ===========================================================
cls
echo.	
echo	░██╗░░░░░░░██╗███████╗██╗░░░░░░█████╗░░█████╗░███╗░░░███╗███████╗  ████████╗░█████╗░
echo	░██║░░██╗░░██║██╔════╝██║░░░░░██╔══██╗██╔══██╗████╗░████║██╔════╝  ╚══██╔══╝██╔══██╗
echo	░╚██╗████╗██╔╝█████╗░░██║░░░░░██║░░╚═╝██║░░██║██╔████╔██║█████╗░░  ░░░██║░░░██║░░██║
echo	░░████╔═████║░██╔══╝░░██║░░░░░██║░░██╗██║░░██║██║╚██╔╝██║██╔══╝░░  ░░░██║░░░██║░░██║
echo	░░╚██╔╝░╚██╔╝░███████╗███████╗╚█████╔╝╚█████╔╝██║░╚═╝░██║███████╗  ░░░██║░░░╚█████╔╝	
echo	░░░╚═╝░░░╚═╝░░╚══════╝╚══════╝░╚════╝░░╚════╝░╚═╝░░░░░╚═╝╚══════╝  ░░░╚═╝░░░░╚════╝░
echo.
echo.   
echo    ░░██╗░██████╗░█████╗░██╗░░
echo    ░██╔╝██╔════╝██╔══██╗╚██╗░
echo    ██╔╝░╚█████╗░██║░░╚═╝░╚██╗
echo    ╚██╗░░╚═══██╗██║░░██╗░██╔╝
echo    ░╚██╗██████╔╝╚█████╔╝██╔╝░
echo    ░░╚═╝╚═════╝░░╚════╝░╚═╝░░        	
echo.
echo     System Cleaner - By Bassem Mohamed 
echo     WebSite - https://hyperflow-corp.pages.dev/
echo     Thanks For Used The Tool
echo   ------------------------------------------
echo.

timeout /t 2 >nul

color 05
@echo off
title System Cleaner - By Bassem Mohamed

echo The entire system is being cleaned...
echo.


echo Clean C:\Windows\Temp
del /f /s /q "C:\Windows\Temp\*.*" 2>nul
for /d %%i in ("C:\Windows\Temp\*") do rd /s /q "%%i" 2>nul


echo Clean %temp%
del /f /s /q "%temp%\*.*" 2>nul
for /d %%i in ("%temp%\*") do rd /s /q "%%i" 2>nul


echo Clean Prefetch
del /f /s /q "C:\Windows\Prefetch\*.*" 2>nul

:: ===========================================================
::                          SOUND ALERT
:: ===========================================================

powershell -c "(New-Object Media.SoundPlayer 'C:\Windows\Media\Windows Notify.wav').PlaySync()"


echo.
echo Done!