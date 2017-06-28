@ECHO OFF
GOTO %~1
::===================================================================================================================
:: 重启
::===================================================================================================================
:Restart
start shutdown.exe /r /t 0
exit
::===================================================================================================================
:CleanTemp
del /f /q /a "%APP_HOME%\Temp\sumtemp.db">NUL 2>&1
del /f /q /a "%APP_HOME%\Temp\numtemp.db">NUL 2>&1
GOTO :EOF
::===================================================================================================================
:FOOTER
ECHO:
ECHO.----------------------------------------------------------
ECHO:
GOTO :EOF
::===================================================================================================================
:InitializeVariables
ECHO %~DP0
PUSHD %APP_HOME%
PUSHD ..
SET APP_ROOT=%cd%
POPD
SET ISOFolderName=%APP_ROOT%\ISO
SET "ISO_HOME=%WORK_HOME%:\UPDATE_HOME\ISO"
CALL :SystemCheckVariables
SET "StartPlus=START /B /ABOVENORMAL /wait"
SET "DISM=%StartPlus% %APP_HOME%\Bin\%PROCESSOR_ARCHITECTURE%\DISM\dism.exe /English"
SET "oscdimg=%APP_HOME%\Bin\%PROCESSOR_ARCHITECTURE%\Oscdimg\oscdimg.exe"
SET "etfsboot=%APP_HOME%\Bin\%PROCESSOR_ARCHITECTURE%\Oscdimg\etfsboot.com"
SET "efisys=%APP_HOME%\Bin\%PROCESSOR_ARCHITECTURE%\Oscdimg\efisys.bin"
CALL "%APP_HOME%\SourceCode\Common\Utils\SetPathNow.bat" OS_ARCHITECTURE
CALL "%APP_HOME%\SourceCode\Common\Utils\SetPathNow.bat" DISM
GOTO :EOF
::===================================================================================================================
:SystemCheckVariables
IF EXIST "%APP_HOME%\Updates\KB976932\Windows6.1-KB2533552-x86.cab" (
    SET UpdateToolArchitecture=32
    SET OS_ARCHITECTURE=x86
) else (
    SET UpdateToolArchitecture=64
    SET OS_ARCHITECTURE=x64
)
cls
GOTO :EOF
::===================================================================================================================
:GetMountedImageInfo
FOR /F "tokens=1,* delims=:" %%a in ('%DISM% /Get-MountedImageInfo') DO (
    if "%%~a"=="Mount Dir " (
        SET MountedDir=%%~b
    )
    if "%%~a"=="Image File " (
        SET InstallWim=%%~b
    )
    if "%%~a"=="Image Index " (
        SET WimIndexNo=%%~b
    )
    if "%%~a"=="Status " (
        SET MountedState=%%~b
    )
)
SET "MountedDir=%MountedDir:~1%"
SET "InstallWim=%InstallWim:~1%"
SET "WimIndexNo=%WimIndexNo:~1%"
SET "MountedState=%MountedState:~1%"
GOTO :EOF
::===================================================================================================================
:DisplayAppName
ECHO  ********************************************************************************************
ECHO  *     ________________________________________________________________________________     *
ECHO  *    *                                                                                *    *
ECHO  *    *  %AppName%  *    *
ECHO  *    *________________________________________________________________________________*    *
ECHO  *                                                                                          *
ECHO  ********************************************************************************************
GOTO :EOF
::===================================================================================================================
:DoAutoDiscard
CALL :KillRelatedProcess
CALL :CleanupMount >NUL 2>&1
CALL :GetMountedImageInfo
ECHO 正在检测是否存在已经被挂载的镜像. . .
ECHO.
IF NOT EXIST "%MountedDir%" (
    ECHO 当前没有需要卸载的映像. . .
) else (
    ECHO 镜像挂载的目录是:"%MountedDir%"
    CALL :UnMountRegistry %MountedDir:\=/% >NUL 2>&1
    Dism /English /Unmount-Wim /MountDir:"%MountedDir%" /Discard >NUL 2>&1
    rd /s /q "!MountedDir!"
)
CALL :CleanFolder "!WORK_HOME!:\UPDATE_HOME\INSTALL_MOUNT"
CALL :KillRelatedProcess>NUL 2>&1
CALL :CleanupMount>NUL 2>&1
if %errorlevel% equ 0 (
    GOTO :EOF
) else (
    ECHO.
    ECHO                  清理挂载的镜像失败了,请重新启动你的电脑,然后在次运行本程序.
    ECHO.
)
GOTO :EOF
::===================================================================================================================
:UnMountRegistry
reg unload HKLM\BCD00000000
reg unload HKLM\{bf1a281b-ad7b-4476-ac95-f47682990ce7}%1/Users/Default/NTUSER.DAT
reg unload HKLM\{bf1a281b-ad7b-4476-ac95-f47682990ce7}%1/Windows/system32/config/COMPONENTS
reg unload HKLM\{bf1a281b-ad7b-4476-ac95-f47682990ce7}%1/Windows/system32/config/DEFAULT
reg unload HKLM\{bf1a281b-ad7b-4476-ac95-f47682990ce7}%1/Windows/system32/config/SAM
reg unload HKLM\{bf1a281b-ad7b-4476-ac95-f47682990ce7}%1/Windows/system32/config/SECURITY
reg unload HKLM\{bf1a281b-ad7b-4476-ac95-f47682990ce7}%1/Windows/system32/config/SOFTWARE
reg unload HKLM\{bf1a281b-ad7b-4476-ac95-f47682990ce7}%1/Windows/system32/config/SYSTEM
reg unload HKLM\{bf1a281b-ad7b-4476-ac95-f47682990ce7}%1/Windows/system32/smi/store/Machine/schema.dat
GOTO :EOF 
::===================================================================================================================
:KillRelatedProcess
taskkill /f /IM dism.exe >NUL 2>&1
taskkill /f /IM DismHost.exe >NUL 2>&1
taskkill /f /IM wimserv.exe >NUL 2>&1
taskkill /f /IM WmiPrvSE.exe >NUL 2>&1
taskkill /f /IM WmiApSrv.exe >NUL 2>&1
taskkill /f /IM backgroundTaskHost.exe >NUL 2>&1
GOTO :EOF
::===================================================================================================================
:CleanupMount
%DISM% /Cleanup-Wim>NUL 2>&1
%DISM% /Cleanup-Mountpoints>NUL 2>&1
GOTO :EOF
::===================================================================================================================
:CleanFolder
SET "url=%~1"
PowerShell -Command "&{Remove-Item '!url!\*' -Force -Recurse}">NUL 2>&1
ECHO 清理目录: !url!
GOTO :EOF