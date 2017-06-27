@ECHO OFF
mode con:cols=80 lines=25
ECHO   重要提示 [一定要仔细阅读,不看后悔噢...]:
ECHO.
ECHO   同时为了保护您的数据安全,请关闭所有已经打开的应用和文档,再运行本程序
ping -n 2 127.0 >nul 2>&1
ECHO.
ECHO   推荐在刚安装好且没有安装补丁的原版系统上运行本更新汇总
ping -n 2 127.0 >nul 2>&1
ECHO.
ECHO   由于一共要安装100多个更新,如果系统位于机械硬盘上,
ping -n 2 127.0 >nul 2>&1
ECHO.
ECHO   保守估计安装过程共需要大概1个小时左右,当然固态硬盘上安装,用时肯定更短.
ping -n 2 127.0 >nul 2>&1
ECHO.
ECHO   为了保证所有更新安装的顺利进行
ping -n 2 127.0 >nul 2>&1
ECHO.
ECHO   本程序将通过多次重启的方式分批次完成所有更新程序的安装
ping -n 2 127.0 >nul 2>&1
ECHO.
ECHO   若中途出现错误,请重新启动电脑后,重新运行本程序
ping -n 2 127.0 >nul 2>&1
ECHO.
ECHO   重启后将启动无人值守的全自动更新安装程序,您甚至可以离开电脑去做其它事情
ping -n 2 127.0 >nul 2>&1
ECHO.
ECHO   若已关闭所有其它应用和文档
ping -n 2 127.0 >nul 2>&1
ECHO.
ECHO   请按 "任意键" 进入重启倒计时.....
PAUSE > nul
CALL %APP_HOME%\SourceCode\Common\Utils\MyTimer.bat 1