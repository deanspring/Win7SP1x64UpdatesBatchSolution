::Author: 远景论坛Jay1982
::Blog: https://www.cnblogs.com/1982/
::Github: https://github.com/deanspring/Win7SP1x64UpdatesBatchSolution
::QQ:1438411802
@ECHO OFF&PUSHD %~DP0
SET APP_HOME=%~DP0App
SET "LastUpdateDate=2017.08.15"
SET "AppName=秒变老司机--系统更新安装和集成批处理解决方案[Win7SP1%OS_ARCHITECTURE%简体中文官方镜像专用]"
CALL "%APP_HOME%\SourceCode\Common\Header\HeaderOfIndex.bat"
CALL "%APP_HOME%\SourceCode\StartApp.bat"
GOTO :EOF