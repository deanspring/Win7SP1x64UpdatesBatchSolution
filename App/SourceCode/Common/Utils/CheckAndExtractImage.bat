@ECHO off
mode con:cols=94 lines=42
:: 通过多步循环监测，判断输入或拖拽的文件是否为本工具支持的官方原版镜像
:: 本工具支持的官方原版镜像的SHA1值

SET SHA1_PROFESSIONAL=9b57e67888434c24dd683968a3ce2c72755ab148
SET SHA1_PROFESSIONAL_VL=647b26479a3a46c078f5b1364a89003a31f4aada
SET SHA1_ENTERPRISE=9ba5e85596c2f25be59f7e96139d83d4cb261a62
SET SHA1_ULTIMATE=2ce0b2db34d76ed3f697ce148cb7594432405e23

SET "Zip=%APP_HOME%\Bin\%PROCESSOR_ARCHITECTURE%\7z.exe"
SET "DVDFolder=%WORK_HOME%:\UPDATE_HOME\ISO\"

CALL :prompt
GOTO :EOF

:prompt
cls
SET ISOFullPathAndName=
ECHO.
ECHO ===============================================================================
ECHO            请输入ISO文件的路径或将支持的官方ISO镜像拖拽到此窗口
ECHO.  
ECHO        请注意:输入或拖拽完成后,用鼠标点击一下本窗口,再按回车键继续...
ECHO ===============================================================================
ECHO.
SET /p ISOFullPathAndName=
set "ISOFullPathAndName=%ISOFullPathAndName:"=%"
FOR %%x IN ("%ISOFullPathAndName%") DO SET ISOFullPathAndName=%%~sx
if [%ISOFullPathAndName%]==[] (
    ECHO.
    ECHO 输入无效,请输入ISO文件的路径或将支持的官方ISO镜像拖拽到此窗口
    ECHO.
    GOTO :prompt
)
if "%ISOFullPathAndName::\=%"=="%ISOFullPathAndName%" (
    ECHO.    
    ECHO 输入有误,请输入ISO文件的路径或将支持的官方ISO镜像拖拽到此窗口
    ECHO.
    pause
    GOTO :prompt
)
if /i "%ISOFullPathAndName:~-4%" neq ".iso" (
  ECHO.
  ECHO 请确保输入或拖拽的文件路径以iso结尾
  ECHO.
  pause
  GOTO :prompt
)

GOTO :CheckWhetherISOFileIsTheOfficialImageBeingSupport
GOTO :EOF
:: 可以通过 certutil -hashfile "文件路径" sha1 来获得指定文件的sha1值
:: 循环检测目标文件是否为支持的官方原版镜像
:CheckWhetherISOFileIsTheOfficialImageBeingSupport
ECHO.
ECHO 正在校验您的镜像是否为本工具支持的官方原版镜像
ECHO.
ECHO 校验镜像需要大概1分钟时间,请稍后...
ECHO.
CALL :CalculateSha1OfImageFile %ISOFullPathAndName%
if "%SHA1_IMAGE%"=="%SHA1_PROFESSIONAL%" (
    ECHO 您放入的镜像是 64位的Windows7SP1简体中文专业版 官方镜像
    GOTO :ExtractISOImageContentsToDVDFolder
)
if "%SHA1_IMAGE%"=="%SHA1_PROFESSIONAL_VL%" (
    ECHO 您放入的镜像是 64位的Windows7SP1简体中文专业版大客户授权版 官方镜像
    GOTO :ExtractISOImageContentsToDVDFolder
)
if "%SHA1_IMAGE%"=="%SHA1_ENTERPRISE%" (
    ECHO 您放入的镜像是 64位的Windows7SP1简体中文企业版 官方镜像
    GOTO :ExtractISOImageContentsToDVDFolder
)
if "%SHA1_IMAGE%"=="%SHA1_ULTIMATE%" (
    ECHO 您放入的镜像是 64位的Windows7SP1简体中文旗舰版 官方镜像
    GOTO :ExtractISOImageContentsToDVDFolder
) else (
    ECHO 程序暂停: 您放入的镜像不是本工具支持的64位的Windows7SP1简体中文官方镜像
    PAUSE >nul
    GOTO :prompt
)
GOTO :EOF


:: 计算放入ISO目录中的镜像的sha1值
:CalculateSha1OfImageFile
SET hashfile=%temp%\hash.out
certutil -hashfile %~1 SHA1 | find /v "SHA1" | find /v "CertUtil" >%hashfile%
SET /p SHA1_IMAGE=<%hashfile%
SET SHA1_IMAGE=%SHA1_IMAGE: =%
erase %hashfile%
GOTO :EOF
:: 解压镜像到指定的目录中
:ExtractISOImageContentsToDVDFolder
IF NOT EXIST "%DVDFolder%" (
	ECHO.
    ECHO 检测到: 目标路径的文件夹不存在
    PAUSE >nul
    MD %DVDFolder%
) else (
    GOTO :CheckWhetherDVDFolderIsEmpty
)
GOTO :EOF

:CheckWhetherDVDFolderIsEmpty
FOR /F %%i in ('dir /b /s /a "%DVDFolder%\*.*" 2^>nul ^| find /v /c ""') DO (
    if "%%i" NEQ "0" (
  		ECHO.
        ECHO 程序暂停: 检测到 %DVDFolder% 中已经存在文件,
        ECHO.
        ECHO 不要关闭本窗口,请将文件删除或转移后,按任意键继续...
    	PAUSE >nul
        GOTO :CheckWhetherDVDFolderIsEmpty
  	) else (
        GOTO :ExtractingISOImageContentsToDVDFolder
    )
)
GOTO :EOF

:ExtractingISOImageContentsToDVDFolder
ECHO.
ECHO 正在解压镜像内容到 %DVDFolder% 中...
ECHO.
ECHO 解压可能需要一些时间,请稍后...
%Zip% x -y "%ISOFullPathAndName%" -o"%DVDFolder%" >nul
ECHO.    
ECHO 成功解压镜像内容到 %DVDFolder% 中...
ECHO.  
ECHO. 
ECHO.
ECHO   ==========================================================================================
ECHO.  
ECHO                        按 "任意键" 返回上级菜单继续完成其它操作. . .
ECHO.  
ECHO   ==========================================================================================
ECHO.
PAUSE >nul
GOTO :EOF