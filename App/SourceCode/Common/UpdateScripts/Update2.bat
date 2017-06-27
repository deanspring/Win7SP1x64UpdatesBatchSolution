SET NET351_HOME=%APP_HOME%\Updates\CAB\NET351
SET "SUCCESSTIPS=用于 Windows 7 SP1 %OS_ARCHITECTURE% 上的 Microsoft .NET Framework 3.5.1 的安全更新程序"
CALL %APP_HOME%\SourceCode\Common\Utils\InstallCAB.bat %NET351_HOME% "%SUCCESSTIPS%"