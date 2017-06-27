SET OPTIONAL_HOME=%APP_HOME%\Updates\CAB\OptionalUpdate
SET OTHERS_HOME=%APP_HOME%\Updates\CAB\OthersUpdate
SET "SUCCESSTIPS=用于基于 %OS_ARCHITECTURE% 的系统的 Windows 7 更新程序"
CALL %APP_HOME%\SourceCode\Common\Utils\InstallCAB.bat %OPTIONAL_HOME% "%SUCCESSTIPS%"
%DISM% /online /Add-Package /PackagePath:"%APP_HOME%\Updates\ServicingStack\Windows6.1-KB3177467-%OS_ARCHITECTURE%.cab" /norestart /quiet
ECHO 成功安装 用于基于 %OS_ARCHITECTURE% 的系统的 Windows 7 更新程序 (KB3177467)