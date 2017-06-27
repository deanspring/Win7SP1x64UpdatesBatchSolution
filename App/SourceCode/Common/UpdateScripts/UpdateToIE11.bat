SET IE11_HOME=%APP_HOME%\Updates\IE\IE11
SET IE11_MSG=开始安装  用于基于 %OS_ARCHITECTURE% 系统的 Windows 7 的 Internet Explorer 11
ECHO %IE11_MSG%
dism /Online /add-package /PackagePath:"%IE11_HOME%\temp\IE11-neutral.Downloaded.cab" /ignorecheck /norestart
dism /Online /add-package /PackagePath:"%IE11_HOME%\temp\IE11_%PROCESSOR_ARCHITECTURE%_zh-CN.cab" /ignorecheck /norestart
dism /Online /add-package /PackagePath:"%IE11_HOME%\temp\Spelling_en\Windows6.3-KB2849696-x86.cab" /ignorecheck /norestart
dism /Online /add-package /PackagePath:"%IE11_HOME%\temp\Hyphenation_en\Windows6.3-KB2849697-x86.cab" /ignorecheck /norestart
::dism /Online /add-package /PackagePath:"%IE11_HOME%\Updates\IE11-Windows6.1-KB3185319-%OS_ARCHITECTURE%.cab" /ignorecheck /norestart
GOTO :EOF