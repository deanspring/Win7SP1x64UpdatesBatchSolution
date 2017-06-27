@ECHO OFF
SET current=%~n0
SET /a next=%current%+1
CALL %APP_HOME%\SourceCode\Common\Header\HeaderOfStep.bat %current% 85 35
CALL %APP_HOME%\SourceCode\Common\UpdateScripts\Update%current%.bat
copy /y "%APP_HOME%\SourceCode\InstallOption\UpdatesWithIE8\%next%.bat" "%PROGRAMDATA%\Microsoft\Windows\Start Menu\Programs\Startup\" > NUL 2>&1
shutdown -r -t 1
del /f /q %0