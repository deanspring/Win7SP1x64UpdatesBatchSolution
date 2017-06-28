::Author:远景论坛Jay1982
::Blog: https://www.cnblogs.com/1982/
::Github: https://github.com/deanspring/Win7SP1x64UpdatesBatchSolution
::QQ:1438411802
@ECHO OFF&PUSHD %~DP0
CALL :Notice
SetLocal EnableDelayedExpansion
Color 0F
CALL :SystemCheckVariables
mode con:cols=94 lines=42
Color 8F
ECHO.
ECHO.  
ECHO.
ECHO.
ECHO.  
ECHO.  
ECHO.  
ECHO.  
ECHO.  
ECHO.  
ECHO.  
ECHO.  
ECHO.  
ECHO.  
ECHO.  
ECHO.  
ECHO.  
ECHO.  
ECHO.  
ECHO.  
ECHO.  
ECHO.  
ECHO                                     正在初始化,请稍候... 
ECHO.  
ECHO.  
ECHO.  
ECHO.  
ECHO.  
ECHO.
ECHO.
ECHO.  
ECHO.  
ECHO.  
ECHO.  
ECHO.  
ECHO.  
ECHO.  
ECHO.
ECHO.
ECHO.  
ECHO.
ECHO.
CALL :DisableUAC >nul 2>&1
CALL :GetAdminRights >nul 2>&1
CALL :SetAPPHOME >nul 2>&1
CALL :Home
exit
::===================================================================================================================
:: 设置环境变量
::===================================================================================================================
:SetAPPHOME
FOR %%x IN ("%APP_HOME%") DO SET APP_HOME=%%~sx
CALL "%APP_HOME%\SourceCode\Common\Utils\SetPathNow.bat" APP_HOME
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" InitializeVariables
GOTO :EOF
::===================================================================================================================
:Notice
mode con:cols=105 lines=27
ECHO. 
ECHO.
ECHO                           ---------------------------------------------------
ECHO                                              使 用 须 知
ECHO                           ---------------------------------------------------
ECHO.                                           
ECHO. 
ECHO =========================================================================================================
ECHO   为了让您更好地使用本更新汇总,有必要阅读以下的风险提示[必须仔细阅读]
ping -n 1 127.0 >nul 2>&1
ECHO.
ECHO   1.本更新汇总原则上仅仅支持在刚刚安装好的,且没有安装其它软件的,纯官方原版的Win7SP164位简体中文版上使用.
ping -n 1 127.0 >nul 2>&1
ECHO.
ECHO   2.如果你使用的是第三方封装的系统,或者系统中安装了管家卫士等第三方安全防护软件,某些操作可能会失败，
ping -n 1 127.0 >nul 2>&1
ECHO.
ECHO   甚至造成蓝屏,系统崩溃,无法启动等严重后果。所以如果你的系统如果不满足上述条件，请立即关闭此安装程序.
ping -n 1 127.0 >nul 2>&1
ECHO.
ECHO   3.如果执意要在不满足上述条件的系统上使用，请先备份您的操作系统然后再使用，切记!!!
ping -n 1 127.0 >nul 2>&1
ECHO.
ECHO   4.因未仔细阅读本声明而引发的任何问题,后果自负!!!
ping -n 1 127.0 >nul 2>&1
ECHO. 
ECHO =========================================================================================================
ECHO.
ECHO                  如果您的系统满足上述条件,请按 "任意键" 继续,否则,请直接关闭本窗口.
ECHO.
PAUSE>nul
cls
GOTO :CheckRuntimeEnvironment
::===================================================================================================================
:CheckRuntimeEnvironment
IF EXIST "%ProgramFiles%\Jiangmin\Antivirus\KvPad.exe" CALL :ShowTips 江民杀毒软件
IF EXIST "%ProgramFiles(x86)%\Rising\Rav\rsmain.exe" CALL :ShowTips 瑞星杀毒软件
IF EXIST "%ProgramFiles(x86)%\Baidu\BaiduSd" CALL :ShowTips 百度杀毒
IF EXIST "%ProgramFiles(x86)%\Baidu\BaiduAn" CALL :ShowTips 百度卫士
IF EXIST "%ProgramFiles(x86)%\kingsoft\kingsoft antivirus\kismain.exe" CALL :ShowTips 金山毒霸
IF EXIST "%ProgramFiles(x86)%\ksafe\KSafe.exe" CALL :ShowTips 金山卫士
IF EXIST "%ProgramFiles(x86)%\2345Soft\2345PCSafe\2345MPCSafe.exe" CALL :ShowTips 2345安全卫士
IF EXIST "%ProgramFiles(x86)%\360\360Safe\360Safe.exe" CALL :ShowTips 360安全卫士
IF EXIST "%ProgramFiles(x86)%\360\360sd\360sd.exe" CALL :ShowTips 360杀毒
IF EXIST "%ProgramFiles(x86)%\Tencent\QQPCMgr" CALL :ShowTips 电脑管家
GOTO :EOF
::===================================================================================================================
:ShowTips
mode con:cols=105 lines=20
ECHO. 
ECHO =========================================================================================================
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO         检测到您的电脑中安装了%~1，请务必在刚安装好，且没有安装其它软件的系统上运行此工具。
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO. 
ECHO =========================================================================================================
ECHO.
ECHO                                        按 “任意键” 退出
ECHO. 
ECHO =========================================================================================================
ECHO.
PAUSE>NUL
EXIT
GOTO :EOF
::===================================================================================================================
:Home
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" CleanTemp>NUL 2>&1
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" DoAutoDiscard>NUL 2>&1
taskkill /f /IM trustedinstaller.exe>NUL 2>&1
net start trustedinstaller>NUL 2>&1
cls
CALL "%APP_HOME%\SourceCode\Menu\Home.bat"
::===================================================================================================================
:: 关闭UAC,否则程序重启后将无法继续安装.
::===================================================================================================================
:DisableUAC
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d "0" /f
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "PromptOnSecureDesktop" /t REG_DWORD /d "0" /f
GOTO :EOF
::===================================================================================================================
::提升UAC管理员权限,在弹出的对话框上点击是继续,点击否将退出.
::===================================================================================================================
:GetAdminRights
SET "params=%*"
cd /d "%~dp0" && ( IF EXIST "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  ECHO SET UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )
GOTO :EOF
::===================================================================================================================
:CheckRunningConditions
mode con:cols=68 lines=5
FOR /F "tokens=2 delims==" %%G in ('wmic path Win32_Processor get AddressWidth /value') DO (SET OSArchitecture=%%G)
if %OSArchitecture% NEQ %UpdateToolArchitecture% (
    ECHO.
    ECHO 此更新汇总包为 %UpdateToolArchitecture%位 操作系统而生,无法运行在您的 %OSArchitecture%位 操作系统上 ...
    ECHO.
    ECHO 请运行专为 %OSArchitecture%位 操作系统制作的更新汇总包，按任意键退出。
    pause>nul
    exit
)
GOTO :EOF
::===================================================================================================================
:SystemCheckVariables
IF EXIST "%APP_HOME%\Updates\KB976932\Windows6.1-KB2533552-x86.cab" (
    SET UpdateToolArchitecture=32
) else (
    SET UpdateToolArchitecture=64
)
CALL :CheckRunningConditions
cls
GOTO :EOF