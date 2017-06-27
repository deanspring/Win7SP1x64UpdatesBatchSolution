@ECHO OFF
setlocal ENABLEEXTENSIONS
SET versionNumber=3
SET regquery=reg query "HKLM\Software\Microsoft\Internet Explorer" /v svcVersion
FOR /F "tokens=3" %%a in ('%regquery%') DO (
  FOR /F "tokens=1 delims=." %%b in ("%%a") DO (
    if %%b GEQ 10 (
       SET versionNumber=%%b
    )
  )
)
if "%versionNumber%" LSS 10 (
  SET regquery=reg query "HKLM\Software\Microsoft\Internet Explorer" /v Version
  FOR /F "tokens=3" %%a in ('%regquery%') DO (
    FOR /F "tokens=1 delims=." %%b in ("%%a") DO (
      SET versionNumber=%%b
    )
  )    
)
IF "%versionNumber%" EQU "8" (
    rem 移除被IE8的更新取代的KB2900986
    dism /online /Remove-Package /PackageName:Package_for_KB2900986~31bf3856ad364e35~%PROCESSOR_ARCHITECTURE%~~6.1.1.1 /norestart > NUL 2>&1
) ELSE (
    rem 移除被替代的IE组件.(解释的再详细一点,移除之后,即使你不喜欢IE11,想卸载掉还原成IE8,也不会受影响.是可以正常的退回IE8的.退后之后,你又想安装IE11了,或者喜欢安装IE9 IE10 ,都可以正常的安装.意思就是这个移除完全没有风险,是安全的.)
    dism /online /Remove-Package /PackageName:Microsoft-Windows-IE-Troubleshooters-Package~31bf3856ad364e35~%PROCESSOR_ARCHITECTURE%~~6.1.7601.17514 /norestart>NUL 2>&1
    dism /online /Remove-Package /PackageName:Microsoft-Windows-InternetExplorer-Optional-Package~31bf3856ad364e35~%PROCESSOR_ARCHITECTURE%~~8.0.7601.17514 /norestart>NUL 2>&1
)