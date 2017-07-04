::Author:远景论坛Jay1982
::Blog: https://www.cnblogs.com/1982/
::QQ:1438411802
@ECHO OFF & PUSHD %~DP0& TITLE 『安装程序正在应用系统设置,请勿关闭本窗口』
mode con cols=70 lines=20
taskkill /im explorer.exe /f  >nul 2>&1
taskkill /IM sysprep.exe /f >nul 2>&1
taskkill /IM rundll32.exe /f >nul 2>&1
CALL :PrintMessage 0f "正在安装系统更新,请不要关闭本窗口"
CALL :Main >nul 2>&1
GOTO :END
::===================================================================================================================
:Main
IF EXIST "%WinDir%\SysWOW64" set "OS_ARCHITECTURE=x64"
IF NOT EXIST "%WinDir%\SysWOW64" set "OS_ARCHITECTURE=x86"
CALL :SystemTweaks
CALL :RemoveSupersededPackages
CALL :InstallUpdates
CALL :EnableAeroTheme
::===================================================================================================================
:EnableAeroTheme
Reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes" /v "CurrentTheme" /t REG_SZ /d "C:\Windows\resources\Themes\aero.theme" /f
Reg add "HKCU\Software\Microsoft\Windows\DWM" /v "ColorizationAfterglowBalance" /t REG_DWORD /d "43" /f
Reg add "HKCU\Software\Microsoft\Windows\DWM" /v "ColorizationBlurBalance" /t REG_DWORD /d "49" /f
Reg add "HKCU\Software\Microsoft\Windows\DWM" /v "ColorizationColorBalance" /t REG_DWORD /d "8" /f
Reg add "HKCU\Software\Microsoft\Windows\DWM" /v "ColorizationOpaqueBlend" /t REG_DWORD /d "0" /f
Reg add "HKCU\Software\Microsoft\Windows\DWM" /v "ColorizationGlassReflectionIntensity" /t REG_DWORD /d "50" /f
Reg add "HKCU\Software\Microsoft\Windows\DWM" /v "Composition" /t REG_DWORD /d "1" /f
Reg add "HKCU\Software\Microsoft\Windows\DWM" /v "CompositionPolicy" /t REG_DWORD /d "2" /f
GOTO :EOF
::===================================================================================================================
:SystemTweaks
IF EXIST "%SystemRoot%\Setup\Scripts\CCleanerRegFix7.bat" (
    CALL %SystemRoot%\Setup\Scripts\CCleanerRegFix7.bat
)
IF EXIST "%SystemRoot%\Setup\Scripts\Tweaks.reg" (
    REGEDIT /S %SystemRoot%\Setup\Scripts\Tweaks.reg
    CALL :PowerSetting
    CALL :ServiceTweak
    Reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /va /f
    Reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Run" /va /f /reg:64
    Reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /va /f
    Reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /va /f /reg:64
)
IF EXIST "%SystemRoot%\Setup\Scripts\TweaksMy.reg" (
    REGEDIT /S %SystemRoot%\Setup\Scripts\TweaksMy.reg
)
GOTO :EOF
::===================================================================================================================
:InstallFlashPlayer
SET FlashPlayer=%WINDIR%\Setup\Files\Apps\install_flash_player_ax.exe
IF EXIST "%FlashPlayer%" (
    Start /WAIT %FlashPlayer% /install
)
GOTO :EOF
::===================================================================================================================
:InstallUpdates
SET ServicingStack=%WINDIR%\Setup\Files\Updates\Windows6.1-KB3177467-%OS_ARCHITECTURE%.cab
SET KB2533552=%WINDIR%\Setup\Files\Updates\Windows6.1-KB2533552-%OS_ARCHITECTURE%.cab
SET KB3172605=%WINDIR%\Setup\Files\Updates\Windows6.1-KB3172605-%OS_ARCHITECTURE%.cab
IF EXIST "%KB2533552%" (
    dism /online /Add-Package /PackagePath:"%KB2533552%" /norestart /quiet
)
IF EXIST "%ServicingStack%" (
    dism /online /Add-Package /PackagePath:"%ServicingStack%" /norestart /quiet
)
IF EXIST "%KB3172605%" (
    dism /online /Add-Package /PackagePath:"%KB3172605%" /norestart /quiet
)
GOTO :EOF
::===================================================================================================================
:PowerSetting
powercfg -h off
powercfg /s 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
powercfg /change monitor-timeout-ac 0
powercfg /change monitor-timeout-dc 0
powercfg /change disk-timeout-ac 0
powercfg /change disk-timeout-dc 0
powercfg /change standby-timeout-ac 0
powercfg /change standby-timeout-dc 0
powercfg /change hibernate-timeout-ac 0
powercfg /change hibernate-timeout-dc 0
GOTO :EOF
::===================================================================================================================
:ServiceTweak
net stop SysMain
sc config SysMain start= DISABLED
net stop WSearch
sc config WSearch start= DISABLED
net stop WMPNetworkSvc
sc config WMPNetworkSvc start= DISABLED
net stop PcaSvc
sc config PcaSvc start= DISABLED
GOTO :EOF
::===================================================================================================================
::移除被替代的旧IE组件
:RemoveSupersededPackages
dism /online /Remove-Package /PackageName:Microsoft-Windows-IE-Troubleshooters-Package~31bf3856ad364e35~amd64~~6.1.7601.17514 /norestart
dism /online /Remove-Package /PackageName:Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~amd64~~8.0.7601.17514 /norestart
GOTO :EOF
::===================================================================================================================
:PrintMessage
Color %~1
ECHO.
ECHO.
ECHO.
ECHO.
ECHO  ====================================================================
ECHO.
ECHO.
ECHO.
ECHO.
ECHO                   %~2...
ECHO.
ECHO.
ECHO.
ECHO.
ECHO  ====================================================================
ECHO.
ECHO.
ECHO.
ECHO.
GOTO :EOF
::===================================================================================================================
:AddRunOnce
IF EXIST "%WINDIR%\System32\RunOnce.bat" reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v 1 /t reg_sz /d "RunOnce.bat" >nul 2>&1
GOTO :EOF
::===================================================================================================================
:END
LABEL C:Win7
chkntfs /t:2
bcdedit /timeout 3
IF NOT EXIST "%WINDIR%\System32\RunOnce.bat" (
    rd /s /q %WINDIR%\Setup\Files
    rd /s /q %WINDIR%\Setup\Scripts
) ELSE (
    reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce /v 1 /t reg_sz /d "RunOnce.bat" >nul 2>&1
)
shutdown.exe /r /f /t 5 /c "安装程序将在重新启动后继续"
del /f /q %0
GOTO :EOF