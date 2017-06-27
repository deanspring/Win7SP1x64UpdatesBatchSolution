@ECHO OFF
CALL %APP_HOME%\SourceCode\Common\Header\HeaderInstallNET47.bat
CALL %APP_HOME%\SourceCode\Common\UpdateScripts\InstallNET47.bat
CALL %APP_HOME%\SourceCode\Common\UpdateScripts\RemoveSupersededPackages.bat > NUL 2>&1
copy /y "%APP_HOME%\SourceCode\Common\Utils\AutoCheckUpdates.bat" "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\" > NUL 2>&1
shutdown -r -t 1
del /f /q %0