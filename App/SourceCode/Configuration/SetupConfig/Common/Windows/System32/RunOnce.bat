::Author:远景论坛Jay1982
::Blog: https://www.cnblogs.com/1982/
::QQ:1438411802
@ECHO OFF & PUSHD %~DP0& TITLE 『正在清理计算机中不需要的文件,请勿关闭本窗口』
mode con cols=70 lines=20
taskkill /im explorer.exe /f  >nul 2>&1
taskkill /IM sysprep.exe /f >nul 2>&1
taskkill /IM rundll32.exe /f >nul 2>&1
CALL :PrintMessage 1F "正在执行最后的清理工作,请不要关闭本窗口"
CALL :Main >nul 2>&1
GOTO :END
::===================================================================================================================
:Main
CALL :EnableAeroTheme
CALL :MyConfig
CALL :UnpinAppFromTaskbar
CALL :Clean
::===================================================================================================================
:UnpinAppFromTaskbar
REGEDIT /S %SystemRoot%\Setup\Scripts\Taskband.reg
attrib -s -r -h "%userprofile%\AppData\Local\iconcache.db"
del /f /q /a "%userprofile%\AppData\Local\iconcache.db"
GOTO :EOF
::===================================================================================================================
:MyConfig
::删除安装显卡驱动后,桌面右键菜单中新增的显卡设置,以及托盘中声卡驱动图标
reg delete "HKLM\SOFTWARE\Classes\Directory\background\shellex\ContextMenuHandlers\igfxcui" /va /f
reg delete "HKLM\SOFTWARE\Classes\Directory\background\shellex\ContextMenuHandlers\igfxDTCM" /va /f
reg add "HKCU\Software\Intel\Display\igfxcui\igfxtray\TrayIcon" /v  ShowTrayIcon /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Realtek\RAVCpl64\General" /v  ShowTrayIcon /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Intel\Display\igfxcui\HotKeys" /v  Enable /t REG_DWORD /d 0 /f
regsvr32 /u /s igfxpph.dll 1
reg delete HKEY_CLASSES_ROOT\Directory\Background\shellex\ContextMenuHandlers /f
reg add HKEY_CLASSES_ROOT\Directory\Background\shellex\ContextMenuHandlers\new /ve /d {D969A300-E7FF-11d0-A93B-00A0C90F2719} /f
reg add "HKCU\Software\Realtek\RAVCpl64\General" /v  ShowTrayIcon /t REG_DWORD /d 0 /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\WinTrust\Trust Providers\Software Publishing" /v "State" /t REG_DWORD /d "146944" /f
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Internet Settings" /v "CertificateRevocation" /t REG_DWORD /d "0" /f
GOTO :EOF
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
:Clean
::移除安装过程中的临时文件
del /f /q /a "%SystemDrive%\Project.log"
del /f /q /a "%LOCALAPPDATA%\Microsoft\Internet Explorer\brndlog.txt"
del /f /q /a "%LOCALAPPDATA%\Microsoft\Windows Mail\edb*"
del /f /q /a "%LOCALAPPDATA%\Microsoft\Windows\Burn\Burn\desktop.ini"
del /f /q /a "%LOCALAPPDATA%\Microsoft\Windows\Explorer"
del /f /q /a "%LOCALAPPDATA%\Microsoft\Windows\WebCache"
del /f /q /a "%ProgramData%\Microsoft\Network\Downloader\qmgr*.dat"
del /f /q /a "%ProgramData%\Microsoft\Windows Defender\Support\*.log"
del /f /q /a "%USERPROFILE%\Favorites\Links\Web Slice Gallery.url"
del /f /q /a "%USERPROFILE%\Favorites\Links\网页快讯库.url"
rd /s /q "%USERPROFILE%\Favorites\Microsoft Websites"
rd /s /q "%USERPROFILE%\Favorites\MSN Websites"
rd /s /q "%USERPROFILE%\Favorites\Windows Live"
rd /s /q "%USERPROFILE%\Favorites\MSN 网站"
rd /s /q "%USERPROFILE%\Favorites\Microsoft 网站"
del /f /q /a "%WINDIR%\DtcInstall.log"
del /f /q /a "%WINDIR%\INF\*.log"
del /f /q /a "%WINDIR%\Logs\DISM\dism.log"
del /f /q /a "%WINDIR%\Performance\WinSAT\winsat.log"
del /f /q /a "%WINDIR%\PFRO.log"
del /f /q /a "%WINDIR%\ServiceProfiles\LocalService\AppData\Local\Microsoft\Windows\WindowsUpdate.log"
del /f /q /a "%WINDIR%\setupact.log"
del /f /q /a "%WINDIR%\setuperr.log"
del /f /q /a "%WINDIR%\System32\catroot2\dberr.txt"
del /f /q /a "%WINDIR%\System32\catroot2\edb*"
del /f /q /a "%WINDIR%\System32\FNTCACHE.DAT"
del /f /q /a "%WINDIR%\System32\LogFiles\AIT"
del /f /q /a "%WINDIR%\System32\LogFiles\Scm"
del /f /q /a "%WINDIR%\System32\LogFiles\SQM"
del /f /q /a "%WINDIR%\TSSysprep.log"
del /f /s /q /a "%WINDIR%\Microsoft.NET\*.log"
rd /q /s "%WINDIR%\Panther"
rd /q /s "%WINDIR%\Setup\Files"
rd /q /s "%WINDIR%\System32\sysprep\Panther"
rd /s /q "%WINDIR%\Setup\Scripts"
CALL :CleanFolder "%APPDATA%\Microsoft\Windows\Recent"
CALL :CleanFolder "%TMP%"
CALL :CleanFolder "%WINDIR%\Debug"
CALL :CleanFolder "%WINDIR%\Temp"
CALL :DeleteNotOSFolder %SystemDrive%
GOTO :EOF
::===================================================================================================================
:CleanFolder
SET "url=%~1"
PowerShell -Command "&{Remove-Item '%url%\*' -Force -Recurse}">NUL 2>&1
ECHO CleanDir: %url%
GOTO :EOF
::===================================================================================================================
:DeleteNotOSFolder
SET "url=%~1"
dir /a:d /b "%url%\" > "%cd%\directory.txt"
for %%a in ("$RECYCLE.BIN" "Boot" "MSOCache" "Program Files" "Program Files (x86)" "ProgramData" "Recovery" "System Volume Information" "Users" "Windows") DO (SET _%%a=%%a)
FOR /F "usebackq delims=" %%a in ("directory.txt") DO (
    if not defined _"%%a" (
        rd /s /q %url%\%%a
    ) 
) 
del  "%cd%\directory.txt"
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
ECHO                %~2...
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
:END
shutdown.exe /r /f /t 3 /c "安装程序将在重新启动完毕"
del /f /q %0
GOTO :EOF