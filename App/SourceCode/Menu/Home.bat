@ECHO OFF&PUSHD %~DP0
CALL "%APP_HOME%\SourceCode\Common\Header\HeaderOfIndex.bat"
SetLocal EnableDelayedExpansion
if defined %~1 GOTO %~1 else GOTO :HomePage
:HomePage
mode con:cols=94 lines=42
Color 1F
SET input=null
cls
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" DisplayAppName
ECHO. *                                                                                          *
ECHO. *                                                                                          *
ECHO. *                                                                                          *
ECHO  *                                 1.安装更新到当前系统中                                   *
ECHO  *                                                                                          *
ECHO. *         注：务必在使用官方镜像安装好的系统中,且未安装其它软件前运行本功能                *
ECHO  *                                                                                          *
ECHO. *                                                                                          *
ECHO. *                                                                                          *
ECHO  ********************************************************************************************
ECHO. *                                                                                          *
ECHO. *                                                                                          *
ECHO. *                                                                                          *
ECHO  *                                 2.封装更新到官方镜像中                                   *
ECHO. *                                                                                          *
ECHO. *                    注：将更新集成到Win7SP1%OS_ARCHITECTURE%简体中文官方原版镜像中                      *
ECHO. *                                                                                          *
ECHO  *          ※ 该功能不支持Ghost版,精简版,固化更新版等第三方发布的修改版系统                *
ECHO. *                                                                                          *
ECHO. *                                                                                          *
ECHO. *                                                                                          *
ECHO  ********************************************************************************************
ECHO. *                                                                                          *
ECHO. *  注：本工具内置了%LastUpdateDate%日前微软发布的所有必要的未被替代的官方更新, 但未包含以下更新: *
ECHO  *                                                                                          *
ECHO  *  ◎  KB2952664 : 升级至 Windows 10 的兼容性更新                                          *
ECHO  *  ◎  KB3021917 : 参与 Windows 客户体验改善计划 (CEIP),将检测结果发送回 Microsoft。       *
ECHO  *  ◎  KB3068708 : 参与 Windows 客户体验改善计划 (CEIP),将检测结果发送回 Microsoft。       *
ECHO  *  ◎  KB3080149 : 参与 Windows 客户体验改善计划 (CEIP),将检测结果发送回 Microsoft。       *
ECHO  *  ◎  每月下旬发布的预览版可选更新                                                        *
ECHO. *                                                                                          *
ECHO  ********************************************************************************************
ECHO.
SET /p input=  请输入你要选择的数字:
IF "%input%"=="1" (Goto H1)
IF "%input%"=="2" (Goto H2)
if %input% GTR 2 (
    ECHO.
    ECHO 请输入一个有效的数字
)
ECHO.
PAUSE
cls
GOTO HomePage
:H1
CALL "%APP_HOME%\SourceCode\Menu\UpdateWindowsFromLocalDrive.bat"
GOTO :EOF

:H2
CALL "%APP_HOME%\SourceCode\Menu\BuildNewISOWithUpdates.bat" ISOMenu
GOTO :EOF