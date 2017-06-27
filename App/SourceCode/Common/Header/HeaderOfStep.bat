@ECHO OFF
SET step=%~1
SET /a col=%~2 
SET /a line=%~3 
Title 第%step%阶段成功后系统会重新启动,自动进入下一阶段的安装.
mode con cols=%col% lines=%line%
Color 1F
taskkill /IM sysprep.exe /F >nul 2>&1
ECHO 安装马上开始,请稍后...
ECHO.
GOTO :EOF