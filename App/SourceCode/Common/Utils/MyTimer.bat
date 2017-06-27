@ECHO OFF
color 3F
mode con:cols=65 lines=6
SET count=%~10
CALL :Timer
GOTO :EOF
:Timer
IF NOT %count% == -1 (
    cls
    IF %count% == 0 (
        ECHO.
        ECHO     系统正在重新启动 !!!
        ECHO.
    ) ELSE (
        ECHO.
        ECHO     系统将在 %count% 秒后重新启动,自动开始第一阶段的安装
        ECHO.
        ECHO     若还不想重新启动,请立即关闭本窗口 !!!         
    )
    SET /A count=%count% - 1
    ping localhost -n 2 >nul
    GOTO Timer
)
GOTO :EOF