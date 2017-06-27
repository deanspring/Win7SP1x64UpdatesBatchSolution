SET ROLLUP_HOME=%APP_HOME%\Updates\RollupFix
SET "SUCCESSTIPS=用于基于 %OS_ARCHITECTURE% 的系统的 Windows 7 更新程序"
ECHO.
ECHO 正在安装用于基于 %OS_ARCHITECTURE% 的系统的 Windows 7 更新程序的月度累积更新...
ECHO.
CALL %APP_HOME%\SourceCode\Common\Utils\InstallCAB.bat %ROLLUP_HOME% "%SUCCESSTIPS%"