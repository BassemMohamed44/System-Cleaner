@echo off
title  System Cleaner - By Bassem Mohamed
chcp 65001 >nul
setlocal enabledelayedexpansion

:: ===========================================================
:: SUPPORT SILENT /auto RUN (used by Task Scheduler)
:: ===========================================================
set "autorun=0"
if /i "%~1"=="/auto" set "autorun=1"

:: ===========================================================
:: ADMIN CHECK
:: ===========================================================
>nul 2>&1 net session || (
    echo Requesting Administrator Access...
    if "%autorun%"=="1" (
        powershell -Command "Start-Process '%~f0' -ArgumentList '/auto' -Verb RunAs"
    ) else (
        powershell -Command "Start-Process '%~f0' -Verb RunAs"
    )
    exit /b
)

set "log_enabled=0"
set "log=%~dp0clean_log.txt"
set "report=%~dp0system_report.txt"
set "drive=%SystemDrive%"

:: ===========================================================
:: AUTO MODE - RUN FULL CLEAN SILENTLY THEN EXIT
:: ===========================================================
if "%autorun%"=="1" (
    set "log_enabled=1"
    echo ============================== >> "%log%"
    echo Scheduled AUTO run: %date% %time% >> "%log%"
    call :full
    exit /b
)

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
:: HEADER
:: ===========================================================
cls
echo ============================================
echo        SYSTEM CLEANER
echo ============================================
echo.

if "%safemode%"=="1" (
    echo [!] SAFE MODE DETECTED - Some features disabled
    echo.
)

echo Starting...
timeout /t 1 >nul

:: ===========================================================
:: MAIN MENU
:: ===========================================================
:menu
cls
color %theme%

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
echo 7 - Advanced Cleaning Tools ^>^>
echo 8 - System Tools ^>^>
echo 9 - Change Theme
echo 0 - Exit
echo.

set /p choice=Select option: 

if "%choice%"=="1" goto temp
if "%choice%"=="2" goto prefetch
if "%choice%"=="3" goto dns
if "%choice%"=="4" goto recycle
if "%choice%"=="5" goto sysinfo
if "%choice%"=="6" call :full & goto menu
if "%choice%"=="7" goto advmenu
if "%choice%"=="8" goto sysmenu
if "%choice%"=="9" goto theme
if "%choice%"=="0" exit
goto menu

:: ===========================================================
:: ADVANCED CLEANING SUBMENU
:: ===========================================================
:advmenu
cls
color %theme%
echo ============================================
echo        ADVANCED CLEANING TOOLS
echo ============================================
echo.
echo 1 - Clean Browser Cache (Chrome / Edge / Firefox)
echo 2 - Clean Windows.old ^& Old Update Files
echo 3 - Clean Thumbnail Cache
echo 4 - Clean Font Cache
echo 5 - Clear Event Logs
echo 6 - Clean Windows Error Reporting Files
echo 7 - Clean Old Downloads (by age)
echo 8 - Back to Main Menu
echo.
set /p achoice=Select option: 

if "%achoice%"=="1" goto browsercache
if "%achoice%"=="2" goto oldwin
if "%achoice%"=="3" goto thumbcache
if "%achoice%"=="4" goto fontcache
if "%achoice%"=="5" goto eventlogs
if "%achoice%"=="6" goto wercache
if "%achoice%"=="7" goto olddownloads
if "%achoice%"=="8" goto menu
goto advmenu

:: ===========================================================
:: SYSTEM TOOLS SUBMENU
:: ===========================================================
:sysmenu
cls
color %theme%
echo ============================================
echo        SYSTEM TOOLS
echo ============================================
echo.
echo 1 - Show Disk Free Space Report
echo 2 - Top 10 Largest Files/Folders
echo 3 - Installed Programs Manager (Uninstall)
echo 4 - Disk Health Check (S.M.A.R.T.)
echo 5 - Check Disk for Errors (CHKDSK)
echo 6 - Schedule Automatic Full Clean
echo 7 - Back to Main Menu
echo.
set /p schoice=Select option: 

if "%schoice%"=="1" goto diskspace
if "%schoice%"=="2" goto topfiles
if "%schoice%"=="3" goto uninstaller
if "%schoice%"=="4" goto diskhealth
if "%schoice%"=="5" goto chkdsk
if "%schoice%"=="6" goto schedule
if "%schoice%"=="7" goto menu
goto sysmenu

:: ===========================================================
:: TEMP CLEAN (with before/after file count)
:: ===========================================================
:temp
cls
echo Scanning Temp Files...

set "tcount=0"
for /f %%a in ('dir /a-d /s /b "%temp%\*" 2^>nul ^| find /c /v ""') do set "tcount=%%a"
echo Found approximately %tcount% temp files.
echo.
echo Cleaning Temporary Files...

del /f /s /q "%temp%\*" 2>nul
for /d %%i in ("%temp%\*") do rd /s /q "%%i" 2>nul

del /f /s /q "C:\Windows\Temp\*" 2>nul
for /d %%i in ("C:\Windows\Temp\*") do rd /s /q "%%i" 2>nul

if "%log_enabled%"=="1" echo Temp cleaned (%tcount% files found) >> "%log%"
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

if !errorlevel! neq 0 (
    echo [!] Failed to flush DNS cache.
    if "%log_enabled%"=="1" echo DNS flush FAILED >> "%log%"
) else (
    if "%log_enabled%"=="1" echo DNS flushed >> "%log%"
    echo Done.
)
timeout /t 2 >nul
goto menu

:: ===========================================================
:: RECYCLE BIN
:: ===========================================================
:recycle
cls
echo Emptying Recycle Bin...
powershell -Command "Clear-RecycleBin -Force" >nul 2>&1

if !errorlevel! neq 0 (
    echo [!] Failed to empty Recycle Bin, or it was already empty.
    if "%log_enabled%"=="1" echo Recycle Bin clear FAILED or already empty >> "%log%"
) else (
    if "%log_enabled%"=="1" echo Recycle Bin cleared >> "%log%"
    echo Done.
)
timeout /t 2 >nul
goto menu

:: ===========================================================
:: SYSTEM INFO EXPORT
:: ===========================================================
:sysinfo
cls
echo Generating System Report...

systeminfo > "%report%" 2>nul

if !errorlevel! neq 0 (
    echo [!] Failed to generate system report.
    if "%log_enabled%"=="1" echo System info export FAILED >> "%log%"
    timeout /t 3 >nul
    goto menu
)

echo ========================== >> "%report%"
echo Report Time: %date% %time% >> "%report%"

echo System report saved!
echo Location: %report%

if "%log_enabled%"=="1" echo System info exported >> "%log%"
timeout /t 3 >nul
goto menu

:: ===========================================================
:: BROWSER CACHE CLEAN
:: ===========================================================
:browsercache
cls
echo Cleaning Browser Caches...
echo (Close your browsers first for best results)
echo.

echo [1/3] Chrome...
del /f /s /q "%localappdata%\Google\Chrome\User Data\Default\Cache\*" 2>nul
del /f /s /q "%localappdata%\Google\Chrome\User Data\Default\Code Cache\*" 2>nul

echo [2/3] Edge...
del /f /s /q "%localappdata%\Microsoft\Edge\User Data\Default\Cache\*" 2>nul
del /f /s /q "%localappdata%\Microsoft\Edge\User Data\Default\Code Cache\*" 2>nul

echo [3/3] Firefox...
for /d %%p in ("%appdata%\Mozilla\Firefox\Profiles\*") do (
    del /f /s /q "%%p\cache2\*" 2>nul
)

if "%log_enabled%"=="1" echo Browser caches cleaned >> "%log%"
echo Done.
timeout /t 2 >nul
goto advmenu

:: ===========================================================
:: WINDOWS.OLD & UPDATE LEFTOVERS
:: ===========================================================
:oldwin
cls
echo Cleaning Windows.old and update leftovers...
rd /s /q "C:\Windows.old" 2>nul
rd /s /q "C:\$Windows.~BT" 2>nul
rd /s /q "C:\$Windows.~WS" 2>nul

echo Running component store cleanup (this can take a while)...
Dism /online /Cleanup-Image /StartComponentCleanup /ResetBase >nul 2>&1

if !errorlevel! neq 0 (
    echo [!] DISM component cleanup FAILED ^(errorlevel !errorlevel!^).
    if "%log_enabled%"=="1" echo Windows.old / update cleanup FAILED ^(errorlevel !errorlevel!^) >> "%log%"
) else (
    if "%log_enabled%"=="1" echo Windows.old / update cleanup done >> "%log%"
    echo Done.
)
timeout /t 2 >nul
goto advmenu

:: ===========================================================
:: THUMBNAIL CACHE
:: ===========================================================
:thumbcache
cls
echo Cleaning Thumbnail Cache...
taskkill /f /im explorer.exe >nul 2>&1
del /f /s /q "%localappdata%\Microsoft\Windows\Explorer\thumbcache_*.db" 2>nul
start explorer.exe

if "%log_enabled%"=="1" echo Thumbnail cache cleaned >> "%log%"
echo Done.
timeout /t 2 >nul
goto advmenu

:: ===========================================================
:: FONT CACHE
:: ===========================================================
:fontcache
cls
echo Cleaning Font Cache...
net stop FontCache >nul 2>&1
del /f /s /q "C:\Windows\ServiceProfiles\LocalService\AppData\Local\FontCache\*" 2>nul
net start FontCache >nul 2>&1

if !errorlevel! neq 0 (
    echo [!] Failed to restart Font Cache service.
    if "%log_enabled%"=="1" echo Font cache cleaned but service restart FAILED >> "%log%"
) else (
    if "%log_enabled%"=="1" echo Font cache cleaned >> "%log%"
    echo Done.
)
timeout /t 2 >nul
goto advmenu

:: ===========================================================
:: EVENT LOGS
:: ===========================================================
:eventlogs
cls
echo Clearing Event Logs...
set "evtfail=0"
for /f "tokens=*" %%L in ('wevtutil el') do (
    wevtutil cl "%%L" 2>nul
    if !errorlevel! neq 0 set "evtfail=1"
)

if "!evtfail!"=="1" (
    echo [!] Some event logs could not be cleared ^(in use or access denied^).
    if "%log_enabled%"=="1" echo Event logs cleared with some FAILURES >> "%log%"
) else (
    if "%log_enabled%"=="1" echo Event logs cleared >> "%log%"
    echo Done.
)
timeout /t 2 >nul
goto advmenu

:: ===========================================================
:: WINDOWS ERROR REPORTING FILES
:: ===========================================================
:wercache
cls
echo Cleaning Windows Error Reporting files...
del /f /s /q "%localappdata%\Microsoft\Windows\WER\*" 2>nul
for /d %%i in ("%localappdata%\Microsoft\Windows\WER\*") do rd /s /q "%%i" 2>nul
del /f /s /q "C:\ProgramData\Microsoft\Windows\WER\*" 2>nul
for /d %%i in ("C:\ProgramData\Microsoft\Windows\WER\*") do rd /s /q "%%i" 2>nul

if "%log_enabled%"=="1" echo WER files cleaned >> "%log%"
echo Done.
timeout /t 2 >nul
goto advmenu

:: ===========================================================
:: OLD DOWNLOADS CLEAN (with user confirmation)
:: ===========================================================
:olddownloads
cls
echo ============================================
echo   Delete files in Downloads older than X days
echo ============================================
set /p days=Enter number of days (e.g. 30): 

echo %days%|findstr /r "^[0-9][0-9]*$" >nul
if errorlevel 1 (
    echo [!] Invalid number of days. Please enter digits only.
    timeout /t 2 >nul
    goto advmenu
)

echo.
echo The following files will be PERMANENTLY deleted:
forfiles /p "%userprofile%\Downloads" /s /d -%days% /c "cmd /c if @isdir==FALSE echo @path" 2>nul
if errorlevel 1 (
    echo No matching files found, or Downloads folder is inaccessible.
    timeout /t 2 >nul
    goto advmenu
)
echo.
set /p confirm=Proceed with deletion? (Y/N): 
if /i not "%confirm%"=="Y" goto advmenu

forfiles /p "%userprofile%\Downloads" /s /d -%days% /c "cmd /c if @isdir==FALSE del /q @path" 2>nul

if !errorlevel! neq 0 (
    echo [!] Some files could not be deleted.
    if "%log_enabled%"=="1" echo Old downloads (%days%+ days) cleanup had FAILURES >> "%log%"
) else (
    if "%log_enabled%"=="1" echo Old downloads (%days%+ days) cleaned >> "%log%"
    echo Done.
)
timeout /t 2 >nul
goto advmenu

:: ===========================================================
:: DISK SPACE REPORT
:: ===========================================================
:diskspace
cls
echo Gathering disk space info...
echo.
powershell -NoProfile -Command "Get-PSDrive -PSProvider FileSystem | Select-Object Name, @{N='UsedGB';E={[math]::Round($_.Used/1GB,2)}}, @{N='FreeGB';E={[math]::Round($_.Free/1GB,2)}} | Format-Table -AutoSize"
if !errorlevel! neq 0 echo [!] Failed to retrieve disk space info.
echo.
pause
goto sysmenu

:: ===========================================================
:: TOP 10 LARGEST FILES/FOLDERS
:: ===========================================================
:topfiles
cls
echo Scanning %drive%\ for the 10 largest files...
echo (This may take a few minutes depending on disk size)
echo.
powershell -NoProfile -Command "Get-ChildItem -Path '%drive%\' -Recurse -File -ErrorAction SilentlyContinue | Sort-Object Length -Descending | Select-Object -First 10 @{N='SizeMB';E={[math]::Round($_.Length/1MB,2)}}, FullName | Format-Table -AutoSize"
if !errorlevel! neq 0 echo [!] Failed to scan for largest files.
echo.
pause
goto sysmenu

:: ===========================================================
:: INSTALLED PROGRAMS MANAGER
:: ===========================================================
:uninstaller
cls
echo Loading installed programs list...
echo.
powershell -NoProfile -Command "Get-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*','HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*' -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName } | Select-Object DisplayName, DisplayVersion | Sort-Object DisplayName | Format-Table -AutoSize"
echo.
set /p prog=Enter EXACT program name to uninstall (or press Enter to cancel): 
if "%prog%"=="" goto sysmenu

powershell -NoProfile -Command ^
 "$app = Get-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*','HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*' -ErrorAction SilentlyContinue | Where-Object { $_.DisplayName -eq '%prog%' } | Select-Object -First 1; if ($app -and $app.UninstallString) { Write-Host 'Launching uninstaller...'; Start-Process cmd -ArgumentList '/c', $app.UninstallString -Wait; exit 0 } else { Write-Host 'Program not found.'; exit 1 }"

if !errorlevel! neq 0 (
    echo [!] Uninstall FAILED or program not found: %prog%
    if "%log_enabled%"=="1" echo Uninstall FAILED or not found: %prog% >> "%log%"
) else (
    if "%log_enabled%"=="1" echo Attempted uninstall: %prog% >> "%log%"
    echo Uninstall process finished.
)
echo.
pause
goto sysmenu

:: ===========================================================
:: DISK HEALTH CHECK (S.M.A.R.T.)
:: ===========================================================
:diskhealth
cls
echo Checking Disk Health Status...
echo.
powershell -NoProfile -Command "Get-PhysicalDisk | Select-Object FriendlyName, MediaType, HealthStatus, OperationalStatus | Format-Table -AutoSize"
if !errorlevel! neq 0 echo [!] Failed to retrieve disk health via PowerShell.
echo.
echo Running basic SMART status check...
wmic diskdrive get model,status
if !errorlevel! neq 0 echo [!] Failed to retrieve SMART status via WMIC.
echo.
if "%log_enabled%"=="1" echo Disk health check run >> "%log%"
pause
goto sysmenu

:: ===========================================================
:: CHKDSK - CHECK DISK FOR ERRORS
:: ===========================================================
:chkdsk
cls
echo ============================================
echo   CHKDSK - Check Disk for Errors (%drive%)
echo ============================================
echo.
echo 1 - Quick Scan (Read-Only, no changes made)
echo 2 - Full Scan and Fix Errors (requires restart)
echo 3 - Back
echo.
set /p cchoice=Select option: 

if "%cchoice%"=="1" (
    cls
    echo Running read-only disk scan on %drive% ...
    echo This may take a while depending on disk size.
    echo.
    chkdsk %drive%
    if !errorlevel! neq 0 (
        echo [!] CHKDSK reported issues or failed to run ^(errorlevel !errorlevel!^).
        if "%log_enabled%"=="1" echo CHKDSK read-only scan on %drive% reported issues ^(errorlevel !errorlevel!^) >> "%log%"
    ) else (
        echo No errors found.
        if "%log_enabled%"=="1" echo CHKDSK read-only scan run on %drive% - no errors >> "%log%"
    )
    echo.
    pause
    goto sysmenu
)

if "%cchoice%"=="2" (
    cls
    echo ============================================
    echo   This will scan and fix errors on %drive%.
    echo   The drive is in use, so this requires a
    echo   RESTART to complete.
    echo ============================================
    echo.
    set /p rconfirm=Restart now to run CHKDSK? (Y/N): 
    if /i not "!rconfirm!"=="Y" goto sysmenu

    echo y| chkdsk %drive% /f /r >nul 2>&1
    if !errorlevel! neq 0 (
        echo [!] Failed to schedule CHKDSK on %drive%.
        if "%log_enabled%"=="1" echo CHKDSK /f /r FAILED to schedule on %drive% >> "%log%"
        pause
        goto sysmenu
    )
    if "%log_enabled%"=="1" echo CHKDSK /f /r scheduled on %drive% >> "%log%"
    echo CHKDSK scheduled successfully.
    echo Restarting in 10 seconds...
    shutdown /r /t 10
    goto sysmenu
)

goto sysmenu

:: ===========================================================
:: SCHEDULE AUTOMATIC FULL CLEAN
:: ===========================================================
:schedule
cls
echo ============================================
echo   Schedule Automatic Full Clean
echo ============================================
echo.
echo D - Daily
echo W - Weekly
echo R - Remove existing schedule
echo.
set /p freq=Choose an option (D/W/R): 

if /i "%freq%"=="R" (
    schtasks /delete /tn "SystemCleanerAuto" /f >nul 2>&1
    if !errorlevel! neq 0 (
        echo [!] No existing scheduled task found, or removal failed.
        if "%log_enabled%"=="1" echo Scheduled task removal FAILED or none existed >> "%log%"
    ) else (
        echo Scheduled task removed.
        if "%log_enabled%"=="1" echo Scheduled task removed >> "%log%"
    )
    goto sysmenu_pause
)

if /i "%freq%"=="D" (
    set "validfreq=1"
) else if /i "%freq%"=="W" (
    set "validfreq=1"
) else (
    set "validfreq=0"
)

if "!validfreq!"=="0" (
    echo Invalid choice.
    goto sysmenu_pause
)

set /p rtime=Enter time to run daily/weekly, 24h format (e.g. 09:00): 

echo %rtime%|findstr /r "^[0-2][0-9]:[0-5][0-9]$" >nul
if errorlevel 1 (
    echo [!] Invalid time format. Please use HH:MM in 24h format ^(e.g. 09:00^).
    goto sysmenu_pause
)

if /i "%freq%"=="D" (
    schtasks /create /tn "SystemCleanerAuto" /tr "\"%~f0\" /auto" /sc daily /st %rtime% /rl highest /f
) else (
    schtasks /create /tn "SystemCleanerAuto" /tr "\"%~f0\" /auto" /sc weekly /st %rtime% /rl highest /f
)

if !errorlevel! neq 0 (
    echo [!] FAILED to schedule task. Check permissions and try again.
    if "%log_enabled%"=="1" echo FAILED to schedule automatic full clean (%freq% at %rtime%) >> "%log%"
    goto sysmenu_pause
)

if "%log_enabled%"=="1" echo Scheduled automatic full clean (%freq% at %rtime%) >> "%log%"
echo Task scheduled successfully.

:sysmenu_pause
pause
goto sysmenu

:: ===========================================================
:: FULL CLEAN (with disk space before/after + staged progress)
:: ===========================================================
:full
cls
echo ============================================
echo             RUNNING FULL CLEAN
echo ============================================
echo.

set "spacebefore=0"
for /f %%a in ('powershell -NoProfile -Command "[math]::Round((Get-PSDrive %drive:~0,1%).Free/1MB)" 2^>nul') do set "spacebefore=%%a"

set "stepfail=0"

echo [1/6] Cleaning Temp Files...
del /f /s /q "%temp%\*" 2>nul
for /d %%i in ("%temp%\*") do rd /s /q "%%i" 2>nul
del /f /s /q "C:\Windows\Temp\*" 2>nul
for /d %%i in ("C:\Windows\Temp\*") do rd /s /q "%%i" 2>nul

echo [2/6] Cleaning Prefetch...
del /f /s /q "C:\Windows\Prefetch\*.*" 2>nul

echo [3/6] Flushing DNS...
ipconfig /flushdns >nul
if !errorlevel! neq 0 set "stepfail=1"

echo [4/6] Emptying Recycle Bin...
powershell -Command "Clear-RecycleBin -Force" >nul 2>&1

echo [5/6] Cleaning Thumbnail Cache...
del /f /s /q "%localappdata%\Microsoft\Windows\Explorer\thumbcache_*.db" 2>nul

echo [6/6] Cleaning Windows Error Reporting files...
del /f /s /q "%localappdata%\Microsoft\Windows\WER\*" 2>nul

set "spaceafter=0"
for /f %%a in ('powershell -NoProfile -Command "[math]::Round((Get-PSDrive %drive:~0,1%).Free/1MB)" 2^>nul') do set "spaceafter=%%a"

set /a freedmb=spaceafter-spacebefore
if %freedmb% lss 0 set /a freedmb=0

if "%log_enabled%"=="1" (
    if "!stepfail!"=="1" (
        echo FULL CLEAN completed WITH WARNINGS - Freed approximately %freedmb% MB >> "%log%"
    ) else (
        echo FULL CLEAN DONE - Freed approximately %freedmb% MB >> "%log%"
    )
)

powershell -c "(New-Object Media.SoundPlayer 'C:\Windows\Media\Windows Notify.wav').PlaySync()" 2>nul

echo.
if "!stepfail!"=="1" (
    echo CLEAN COMPLETE WITH WARNINGS ^(check log for details^)
) else (
    echo CLEAN COMPLETE SUCCESSFULLY
)
echo Approximate space freed: %freedmb% MB
if "%autorun%"=="0" timeout /t 4 >nul
goto :eof

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
