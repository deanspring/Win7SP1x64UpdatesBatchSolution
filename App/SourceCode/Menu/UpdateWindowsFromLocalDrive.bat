@ECHO OFF&PUSHD %~DP0
if defined %~1 GOTO %~1 else GOTO :OnlineMenu
::===================================================================================================================
:: 首页
::===================================================================================================================
:OnlineMenu
mode con:cols=94 lines=42
Color 3F
SET input=null
cls            
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" DisplayAppName
ECHO.
ECHO.
ECHO   1. 安装 [系统更新,IE11,.NET Framework v4.7,Visual C++运行库,DirectX9.0c] (推荐)
ECHO.
ECHO.
ECHO   2. 安装 [系统更新,IE11,.NET Framework v4.7]          
ECHO.                                                       
ECHO.                                                       
ECHO   3. 安装 [系统更新,IE11]                              
ECHO.                                                             *******************************
ECHO.                                                             *       版本:%LastUpdateDate%       *
ECHO   4. 安装 [系统更新,保留IE8,.NET Framework v4.7]             *******************************
ECHO.                                                             *   开发者: 远景论坛Jay1982   *
ECHO.                                                             *******************************
ECHO   5. 安装 [系统更新,保留IE8]                                 *       QQ: 1438411802        *
ECHO.                                                             *******************************
ECHO.                                                             *   纯净,无广告,不含推广软件  *
ECHO   6. 仅安装 微软 DirectX9.0c 最终版                          *******************************
ECHO.                                                             *            开源             *
ECHO.                                                             *******************************
ECHO   7. 仅安装 Microsoft Visual C++[2005-2017]运行库            
ECHO.
ECHO.
ECHO   8. 进入全新推出的封装集成更新到官方镜像中模块
ECHO.
ECHO.
ECHO   00. 更多.. (敬请期待...)                            0. 返回首页
ECHO.
ECHO.
SET /p input=*  请输入你要选择的数字:
IF "%input%"=="0" (CALL "%APP_HOME%\SourceCode\Menu\Home.bat")
IF "%input%"=="00" (start http://t.cn/RtOmdw5
GOTO OnlineMenu)
IF "%input%"=="1" (Goto U1)
IF "%input%"=="2" (Goto U2)
IF "%input%"=="3" (GOTO U3)
IF "%input%"=="4" (GOTO U4)
IF "%input%"=="5" (GOTO U5)
IF "%input%"=="6" (GOTO U6)
IF "%input%"=="7" (GOTO U7)
IF "%input%"=="8" (CALL "%APP_HOME%\SourceCode\Menu\BuildNewISOWithUpdates.bat" ISOMenu)
if %input% GTR 8 (
    ECHO.
    ECHO 请输入一个有效的数字
)
ECHO.
PAUSE
cls
GOTO OnlineMenu
::===================================================================================================================
:U1
mode con:cols=87 lines=28
:: 阅读安装须知
CALL "%APP_HOME%\SourceCode\Common\Utils\Readme.bat"
copy /y "%APP_HOME%\SourceCode\InstallOption\UpdatesAIO\1.bat" "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\" > NUL
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" Restart
::===================================================================================================================
:U2
:: 阅读安装须知
CALL "%APP_HOME%\SourceCode\Common\Utils\Readme.bat"
copy /y "%APP_HOME%\SourceCode\InstallOption\UpdatesWithIE11AndDotNET47\1.bat" "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\" > NUL
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" Restart
:U3
:: 阅读安装须知
CALL "%APP_HOME%\SourceCode\Common\Utils\Readme.bat"
copy /y "%APP_HOME%\SourceCode\InstallOption\UpdatesWithIE11\1.bat" "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\" > NUL
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" Restart
::===================================================================================================================
:U4
:: 阅读安装须知
CALL "%APP_HOME%\SourceCode\Common\Utils\Readme.bat"
copy /y "%APP_HOME%\SourceCode\InstallOption\UpdatesWithIE8AndDotNET47\1.bat" "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\" > NUL
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" Restart
::===================================================================================================================
:U5
:: 阅读安装须知
CALL "%APP_HOME%\SourceCode\Common\Utils\Readme.bat"
copy /y "%APP_HOME%\SourceCode\InstallOption\UpdatesWithIE8\1.bat" "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\" > NUL
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" Restart
::===================================================================================================================
:U6
CALL "%APP_HOME%\SourceCode\Common\Header\HeaderOfIndex.bat"
CALL "%APP_HOME%\SourceCode\Common\UpdateScripts\InstallDirectX.bat"
CALL :PAUSETIP
cls
GOTO OnlineMenu
::===================================================================================================================
:U7
CALL "%APP_HOME%\SourceCode\Common\Header\HeaderOfIndex.bat"
CALL "%APP_HOME%\SourceCode\Common\UpdateScripts\InstallVC.bat"
CALL :PAUSETIP
cls
GOTO OnlineMenu
::===================================================================================================================
:U8
CALL "%APP_HOME%\SourceCode\Common\Header\HeaderOfIndex.bat"
CALL "%APP_HOME%\SourceCode\Common\UpdateScripts\InstallNET47.bat"
CALL :PAUSETIP
cls
GOTO OnlineMenu
::===================================================================================================================
:PAUSETIP
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
ECHO   ==========================================================================================
ECHO.  
ECHO                                     按 “任意键” 退出
ECHO.  
ECHO   ==========================================================================================
ECHO.
PAUSE>NUL
GOTO :EOF