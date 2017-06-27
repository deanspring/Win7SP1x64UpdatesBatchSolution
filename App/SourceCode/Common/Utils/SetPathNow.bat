@ECHO OFF
SetLocal EnableDelayedExpansion
Reg add "HKLM\SOFTWARE\Microsoft\PowerShell\1\ShellIds\Microsoft.PowerShell" /v "ExecutionPolicy" /t REG_SZ /d "RemoteSigned" /f>NUL 2>&1
wmic ENVIRONMENT where "name='%~1'" delete>NUL 2>&1
REM SETX "%~1" "!%~1!" -m>NUL 2>&1
powershell -noprofile "& {[Environment]::SetEnvironmentVariable("""%~1""", """!%~1!""", """Machine""")}">NUL 2>&1
GOTO :EOF