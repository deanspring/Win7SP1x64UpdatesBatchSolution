SET IE8_HOME=%APP_HOME%\Updates\IE\IE8
SET IE8_MSG=成功安装  用于基于 %OS_ARCHITECTURE% 系统的 Windows 7 的 Internet Explorer 8
dism /Online /add-package /PackagePath:"%IE8_HOME%\Windows6.1-KB2598845-%OS_ARCHITECTURE%.cab" /ignorecheck /norestart /quiet
ECHO %IE8_MSG% 兼容性视图列表的更新程序 (KB2598845)
dism /Online /add-package /PackagePath:"%IE8_HOME%\Windows6.1-KB3124275-%OS_ARCHITECTURE%.cab" /ignorecheck /norestart /quiet
ECHO %IE8_MSG% 的累积安全更新程序 (KB3124275)