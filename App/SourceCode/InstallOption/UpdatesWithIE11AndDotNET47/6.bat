@ECHO OFF
SET current=%~n0
SET /a next=%current%+1
CALL %APP_HOME%\SourceCode\Common\Header\HeaderUpdateIE.bat
CALL %APP_HOME%\SourceCode\Common\UpdateScripts\UpdateToIE11.bat
CALL %APP_HOME%\SourceCode\Common\UpdateScripts\InstallRollup.bat
CALL %APP_HOME%\SourceCode\Common\Utils\IETweaks.bat > NUL 2>&1
copy /y "%APP_HOME%\SourceCode\InstallOption\UpdatesWithIE11AndDotNET47\%next%.bat" "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\" > NUL 2>&1
shutdown -r -t 1
del /f /q %0