@echo off
title  System Cleaner - By Bassem Mohamed
chcp 65001 >nul
setlocal enabledelayedexpansion

:: ===========================================================
:: ADMIN CHECK
:: ===========================================================
>nul 2>&1 net session || (
    echo Requesting Administrator Access...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

set "log_enabled=0"
set "log=%~dp0clean_log.txt"
set "report=%~dp0system_report.txt"

:: ===========================================================
:: ASK FOR LOG OPTION
:: ===========================================================
cls
echo ============================================
echo        SYSTEM CLEANER SETUP
echo ============================================
echo.
set /p log_choice=Do you want to enable LOG file? (Y/N): 

if /i "%log_choice%"=="Y" set "log_enabled=1"

:: ===========================================================
:: INIT LOG ONLY IF ENABLED
:: ===========================================================
if "%log_enabled%"=="1" (
    echo ============================== >> "%log%"
    echo Started: %date% %time% >> "%log%"
)

:: ===========================================================
:: DEFAULT THEME
:: ===========================================================
set "theme=05"
color %theme%

:: ===========================================================
:: SAFE MODE CHECK (SAFE VERSION)
:: ===========================================================
set "safemode=0"
bcdedit >nul 2>&1 && (
    bcdedit | findstr /i "safeboot" >nul && set "safemode=1"
)

:: ===========================================================
::                         HEADER
:: ===========================================================
cls
echo ============================================
echo         SYSTEM CLEANER
echo ============================================
echo.

if "%safemode%"=="1" (
    echo [!] SAFE MODE DETECTED - Some features disabled
    echo.
)

echo Starting...
timeout /t 1 >nul

:: ===========================================================
::                    MENU
:: ===========================================================
:menu
cls
color %theme%

:: ===========================================================
::                     UI
:: ===========================================================
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

echo 1 - Clean Temp Files
echo 2 - Clean Prefetch (Advanced)
echo 3 - Flush DNS Cache
echo 4 - Empty Recycle Bin
echo 5 - System Info Export
echo 6 - FULL CLEAN (Recommended)
echo 7 - Change Theme
echo 8 - Exit
echo.

set /p choice=Select option: 

if "%choice%"=="1" goto temp
if "%choice%"=="2" goto prefetch
if "%choice%"=="3" goto dns
if "%choice%"=="4" goto recycle
if "%choice%"=="5" goto sysinfo
if "%choice%"=="6" goto full
if "%choice%"=="7" goto theme
if "%choice%"=="8" exit
goto menu

:: ===========================================================
:: TEMP CLEAN
:: ===========================================================
:temp
cls
echo Cleaning Temporary Files...

del /f /s /q "%temp%\*" 2>nul
for /d %%i in ("%temp%\*") do rd /s /q "%%i" 2>nul

del /f /s /q "C:\Windows\Temp\*" 2>nul
for /d %%i in ("C:\Windows\Temp\*") do rd /s /q "%%i" 2>nul

if "%log_enabled%"=="1" echo Temp cleaned >> "%log%"
echo Done.
timeout /t 2 >nul
goto menu

:: ===========================================================
:: PREFETCH CLEAN (Optional)
:: ===========================================================
:prefetch
cls
echo Cleaning Prefetch (may slow first boot after)...

del /f /s /q "C:\Windows\Prefetch\*.*" 2>nul

if "%log_enabled%"=="1" echo Prefetch cleaned >> %log%
echo Done!
timeout /t 2 >nul
goto menu


:: ===========================================================
:: DNS CLEAN
:: ===========================================================
:dns
cls
echo Flushing DNS Cache...
ipconfig /flushdns >nul

if "%log_enabled%"=="1" echo DNS flushed >> "%log%"
echo Done.
timeout /t 2 >nul
goto menu

:: ===========================================================
:: RECYCLE BIN
:: ===========================================================
:recycle
cls
echo Emptying Recycle Bin...
powershell -Command "Clear-RecycleBin -Force" >nul 2>&1

if "%log_enabled%"=="1" echo Recycle Bin cleared >> "%log%"
echo Done.
timeout /t 2 >nul
goto menu

:: ===========================================================
:: SYSTEM INFO EXPORT
:: ===========================================================
:sysinfo
cls
echo Generating System Report...

systeminfo > "%report%"

echo ========================== >> "%report%"
echo Report Time: %date% %time% >> "%report%"

echo System report saved!
echo Location: %report%

if "%log_enabled%"=="1" echo System info exported >> "%log%"
timeout /t 3 >nul
goto menu

:: ===========================================================
:: FULL CLEAN
:: ===========================================================
:full
cls
echo Running FULL CLEAN...
echo Please wait...

del /f /s /q "%temp%\*" 2>nul
for /d %%i in ("%temp%\*") do rd /s /q "%%i" 2>nul

del /f /s /q "C:\Windows\Temp\*" 2>nul
for /d %%i in ("C:\Windows\Temp\*") do rd /s /q "%%i" 2>nul

ipconfig /flushdns >nul
powershell -Command "Clear-RecycleBin -Force" >nul 2>&1

if "%log_enabled%"=="1" echo FULL CLEAN DONE >> "%log%"

powershell -c "(New-Object Media.SoundPlayer 'C:\Windows\Media\Windows Notify.wav').PlaySync()"

echo.
echo CLEAN COMPLETE SUCCESSFULLY
timeout /t 3 >nul
goto menu

:: ===========================================================
:: THEME CHANGER
:: ===========================================================
:theme
cls
echo ============================================
echo THEMES:
echo 1 - Green
echo 2 - Blue
echo 3 - Red
echo 4 - Purple
echo ============================================
set /p th=Choose theme: 

if "%th%"=="1" set theme=0A
if "%th%"=="2" set theme=09
if "%th%"=="3" set theme=0C
if "%th%"=="4" set theme=05

if "%log_enabled%"=="1" echo Theme changed >> "%log%"
goto menu