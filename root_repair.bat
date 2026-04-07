@echo off
title root://repair
color 0A

:menu
cls
echo =====================================
echo           root://repair
echo     Created by SociallyEncrypted 2026
echo =====================================
echo.

echo 1. System File Repair
echo 2. Deep Clean
echo 3. Malware Scan (Quick)
echo 4. Malware Scan (Full)
echo 5. Network Reset
echo 6. Driver Scan (Microsoft)
echo 7. Remove Bloatware
echo 8. RAM Cleanup
echo 9. Privacy Hardening
echo 10. Startup Programs List
echo 11. AUTO FIX (recommended)
echo 12. FULL REPAIR
echo 0. Exit
echo.

set /p choice=Select option:

if %choice%==1 goto repair
if %choice%==2 goto deepclean
if %choice%==3 goto quickscan
if %choice%==4 goto fullscan
if %choice%==5 goto network
if %choice%==6 goto drivers
if %choice%==7 goto bloat
if %choice%==8 goto ram
if %choice%==9 goto privacy
if %choice%==10 goto startup
if %choice%==11 goto autofix
if %choice%==12 goto full
if %choice%==0 exit

goto menu

:repair
cls
echo Repairing Windows...
sfc /scannow
DISM /Online /Cleanup-Image /RestoreHealth
pause
goto menu

:deepclean
cls
echo Deep Cleaning...
cleanmgr /sagerun:1
ipconfig /flushdns
del /s /f /q %temp%\*
powershell Clear-RecycleBin -Force
DISM /Online /Cleanup-Image /StartComponentCleanup
pause
goto menu

:quickscan
cls
echo Quick malware scan...
powershell Start-MpScan -ScanType QuickScan
pause
goto menu

:fullscan
cls
echo Full malware scan...
powershell Start-MpScan -ScanType FullScan
pause
goto menu

:network
cls
echo Resetting network...
ipconfig /flushdns
netsh winsock reset
netsh int ip reset
pause
goto menu

:drivers
cls
echo Checking drivers...
powershell Install-Module PSWindowsUpdate -Force
powershell Import-Module PSWindowsUpdate
powershell Get-WindowsUpdate -MicrosoftUpdate
pause
goto menu

:bloat
cls
echo Removing bloatware...
powershell Get-AppxPackage Microsoft.XboxApp | Remove-AppxPackage
powershell Get-AppxPackage Microsoft.XboxGamingOverlay | Remove-AppxPackage
powershell Get-AppxPackage Microsoft.YourPhone | Remove-AppxPackage
powershell Get-AppxPackage Microsoft.ZuneMusic | Remove-AppxPackage
powershell Get-AppxPackage Microsoft.ZuneVideo | Remove-AppxPackage
powershell Get-AppxPackage Microsoft.SkypeApp | Remove-AppxPackage
powershell Get-AppxPackage Microsoft.GetHelp | Remove-AppxPackage
powershell Get-AppxPackage Microsoft.Getstarted | Remove-AppxPackage
powershell Get-AppxPackage Microsoft.People | Remove-AppxPackage
powershell Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage
powershell Get-AppxPackage Microsoft.MicrosoftOfficeHub | Remove-AppxPackage
pause
goto menu

:ram
cls
echo Cleaning RAM + temp...
del /s /f /q %temp%\*
powershell Clear-RecycleBin -Force
pause
goto menu

:privacy
cls
echo Applying privacy settings...
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v Enabled /t REG_DWORD /d 0 /f
schtasks /Change /TN "Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser" /Disable
schtasks /Change /TN "Microsoft\Windows\Customer Experience Improvement Program\Consolidator" /Disable
pause
goto menu

:startup
cls
echo Startup programs...
powershell Get-CimInstance Win32_StartupCommand
pause
goto menu

:autofix
cls
echo Running recommended fixes...
sfc /scannow
DISM /Online /Cleanup-Image /RestoreHealth
del /s /f /q %temp%\*
ipconfig /flushdns
powershell Start-MpScan -ScanType QuickScan
pause
goto menu

:full
cls
echo Running FULL repair...
sfc /scannow
DISM /Online /Cleanup-Image /RestoreHealth
cleanmgr /sagerun:1
ipconfig /flushdns
del /s /f /q %temp%\*
powershell Clear-RecycleBin -Force
powershell Start-MpScan -ScanType QuickScan
netsh winsock reset
netsh int ip reset
pause
goto menu