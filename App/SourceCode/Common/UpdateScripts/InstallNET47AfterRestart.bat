@ECHO OFF & PUSHD %~DP0
mode con:cols=94 lines=42
CALL "%APP_HOME%\SourceCode\Common\Header\HeaderOfIndex.bat"
SET NET470_HOME=%APP_HOME%\Updates\Runtimes\NDP47
echo.
echo                        ---------------------------------------------------
echo                                Microsoft .NET Framework 4.7 安装器
echo                        ---------------------------------------------------
echo.
echo.
echo.
ECHO                         安装.NET Framework 4.7需要一些时间,请稍候......
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
"%NET470_HOME%\NDP47-KB3186497-x86-x64-AllOS-ENU\Setup.exe" /passive /norestart
ECHO.
ECHO.
ECHO.
ECHO.
echo                     成功安装  Microsoft .NET Framework 4.7 正式版 (KB3186497)
ECHO.
ECHO.
ECHO.
ECHO.
"%NET470_HOME%\NDP47-KB3186497-x86-x64-AllOS-CHS.exe" /passive /norestart
echo                     成功安装  Microsoft .NET Framework 4.7 语言包 (KB3186497)
ECHO.
ECHO.
ECHO.
ECHO.
ECHO   ==========================================================================================
ECHO.  
ECHO                                     按 “任意键” 退出
ECHO.  
ECHO   ==========================================================================================
ECHO.
pause >nul
CALL "%APP_HOME%\SourceCode\Menu\UpdateWindowsFromLocalDrive.bat"
del /f /q %0