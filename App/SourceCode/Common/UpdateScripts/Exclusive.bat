SET EXCLUSIVE_HOME=%APP_HOME%\Updates\CAB\Exclusive
SET UPDATESUCCESS=成功安装 用于基于 %OS_ARCHITECTURE% 的系统的 Windows 7 更新程序
SET SECURITYUPDATESUCCESS=成功安装 用于基于 %OS_ARCHITECTURE% 的系统的 Windows 7 更新程序
if "%OS_ARCHITECTURE%"=="x86" (
    CALL %APP_HOME%\SourceCode\Common\Utils\InstallCAB.bat %EXCLUSIVE_HOME%\Update "%UPDATESUCCESS%"
    CALL %APP_HOME%\SourceCode\Common\Utils\InstallCAB.bat %EXCLUSIVE_HOME%\SecurityUpdate "%SECURITYUPDATESUCCESS%"
) else (
    CALL %APP_HOME%\SourceCode\Common\Utils\InstallCAB.bat %EXCLUSIVE_HOME%\Update "%UPDATESUCCESS%"
)