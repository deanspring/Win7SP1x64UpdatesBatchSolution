@ECHO OFF
SET current=%~n0
SET /a next=%current%+1
CALL %APP_HOME%\SourceCode\Common\Header\HeaderInstallNET47.bat
CALL %APP_HOME%\SourceCode\Common\UpdateScripts\InstallNET47.bat
CALL %APP_HOME%\SourceCode\Common\UpdateScripts\RemoveSupersededPackages.bat > NUL 2>&1
copy /y "%APP_HOME%\SourceCode\InstallOption\UpdatesAIO\%next%.bat" "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\" > NUL 2>&1
shutdown -r -t 1
del /f /q %0