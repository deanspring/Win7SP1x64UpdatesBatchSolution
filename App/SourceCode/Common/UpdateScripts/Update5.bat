SET UPDATES2ND_HOME=%APP_HOME%\Updates\CAB\Updates2nd
SET "SUCCESSTIPS=用于基于 %OS_ARCHITECTURE% 的系统的 Windows 7 更新程序"
SET "KB2533552TIPS=成功安装 适用于 %OS_ARCHITECTURE% 系统的 Windows 7 Service Pack 1"
CALL %APP_HOME%\SourceCode\Common\Utils\InstallCAB.bat %UPDATES2ND_HOME% "%SUCCESSTIPS%"
%DISM% /online /Add-Package /PackagePath:"%APP_HOME%\Updates\KB976932\Windows6.1-KB2533552-%OS_ARCHITECTURE%.cab" /norestart /quiet
ECHO 成功安装 适用于 %OS_ARCHITECTURE% 系统的 Windows 7 Service Pack 1 (KB2533552)
%DISM% /online /Add-Package /PackagePath:"%APP_HOME%\Updates\ServicingStack\Windows6.1-KB3172605-%OS_ARCHITECTURE%.cab" /norestart /quiet
ECHO 成功安装 用于基于 %OS_ARCHITECTURE% 的系统的 Windows 7 更新程序 (KB3172605)