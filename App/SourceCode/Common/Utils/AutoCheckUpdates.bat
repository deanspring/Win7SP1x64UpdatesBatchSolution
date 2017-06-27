@ECHO OFF
Color 3F
mode con:cols=120 lines=25
Title 正在清理安装更新过程生成的临时垃圾文件.......
taskkill /IM sysprep.exe /F >nul 2>&1
rem 通过命令打开Windows Update,并自动检测更新.
ECHO 正在清理安装更新过程生成的临时垃圾文件.......
start /B /wait cleanmgr /d %SystemDrive% /sagerun:65535
ping -n 3 -w 1000 8.8.8.1 >nul 2>&1
ECHO 为您自动打开Windows Update窗口,执行在线更新,安装剩余的补丁.
ECHO.
ECHO 微软每月都会推出新的更新,同时一些旧的补丁也会被新的更新所替代.
ECHO.
ECHO 温馨提示:不推荐安装以下4个补丁,并在可选更新列表中,点击右键,选择隐藏更新.
ECHO.
ECHO 1. KB2952664 :升级至 Windows 10 的兼容性更新
ECHO 2. KB3021917 :参与 Windows 客户体验改善计划 (CEIP),将检测结果发送回 Microsoft。
ECHO 3. KB3068708 :参与 Windows 客户体验改善计划 (CEIP),将检测结果发送回 Microsoft。
ECHO 4. KB3080149 :此更新包含当用户参与了 Windows CEIP 计划或遥测程序.
ECHO.
start /B /wait wuauclt /ShowWUAutoScan
ping -n 10 -w 1000 8.8.8.1 >nul 2>&1
start /B /wait mshta vbscript:CreateObject("Wscript.Shell").popup("感谢您的使用,再见.^_^",15,"温馨提示")(window.close)
CALL %APP_HOME%\SourceCode\Common\Utils\RestorePath.bat > NUL 2>&1
del /f /q %0
exit