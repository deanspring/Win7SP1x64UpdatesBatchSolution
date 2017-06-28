@ECHO OFF&PUSHD %~DP0
CALL "%APP_HOME%\SourceCode\Common\Header\HeaderOfIndex.bat"
setLocal EnableDelayedExpansion
SET wim=!WORK_HOME!:\UPDATE_HOME\ISO\sources\install.wim
CALL "%APP_HOME%\SourceCode\Common\Utils\SupportIamgeList.bat"
if defined %~1 GOTO %~1 else GOTO :ISOMenu
:ISOMenu
mode con:cols=94 lines=42
Color 0F
SET input=null
cls
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" DisplayAppName
ECHO.
ECHO   请按备注依次执行下面的步骤,可选的可跳过:
ECHO.
ECHO   1.  [第1步:必须首先运行此项] 准备封装运行环境
ECHO. 
ECHO   2.  [注意:2和3只能2选1]离线添加更新到install.wim[升至IE11]
ECHO.
ECHO   3.  [注意:2和3只能2选1]离线添加更新到install.wim[保留IE8]
ECHO.
ECHO   4.  [可选]添加 微软.NET Framework v4.7 正式版本
ECHO.            
ECHO   5.  [可选]添加 微软 DirectX9.0c 最终版
ECHO.            
ECHO   6.  [可选]添加 Microsoft Visual C++[2005-2017]运行库
ECHO.            
ECHO   7.  [推荐]同时 添加 4，5，6 [若已添加4,5,6,无需选择此项]
ECHO.            
ECHO   8.  [推荐]添加 万能网卡驱动 [Win7原版镜像自带网卡驱动不全，不添加可能无法联网] 
ECHO.
ECHO   9.  [可选]添加 USB3 驱动[若无USB3接口,请勿添加此项 ,否则安装后可能会蓝屏]
ECHO.
ECHO.  10. [可选]添加 NVMe 驱动[若无M.2接口固态硬盘,请勿添加此项]
ECHO.
ECHO   11. [推荐]为镜像添加无人值守安装功能,同时添加适当的注册表优化[以Administrator登录,无伪优化]
ECHO.
ECHO   12. [可选]解除官方最新补丁对Ryzen和7代酷睿处理器不能使用Win7的限制[非Ryzen和7代酷睿,请勿选]
ECHO.
ECHO   13. [最后执行此项]为您生成全新的支持BIOS和UEFI双模式引导的ISO
ECHO.
ECHO   14. 我的博客       15.  Github更新页面         00. 打赏支持              0. 返回首页
ECHO.
ECHO.
SET /p input=*  请输入你要选择的数字:
if "%input%"=="0" (CALL "%APP_HOME%\SourceCode\Menu\Home.bat")
if "%input%"=="00" (
    START /B %APP_HOME%\Packs\RewardMe\RewardMe.png
    rem START http://t.cn/RStk2bP
    GOTO ISOMenu
)
if "%input%"=="1" (GOTO :PREPARE)
if "%input%"=="2" (CALL :InstallUpdateToWIMWith IE11)
if "%input%"=="3" (CALL :InstallUpdateToWIMWith IE8Update)
if "%input%"=="4" (CALL :AddToInstall NetFX47)
if "%input%"=="5" (CALL :AddToInstall DirectX9c)
if "%input%"=="6" (CALL :AddToInstall RuntimePack)
if "%input%"=="7" (CALL :AddPacksToInstall)
if "%input%"=="8" (CALL :AddingNetworkDriverToISO)
if "%input%"=="9" (CALL :AddSupport USB3)
if "%input%"=="10" (CALL :AddSupport NVMe)
if "%input%"=="11" (CALL :AddUnattendToWIM Admin)
if "%input%"=="12" (GOTO :AddNewCPUSupportPatch)
if "%input%"=="13" (GOTO :CreateISO)
if "%input%"=="di" (GOTO :AutoDiscard)
if "%input%"=="slim" (CALL :AddSupport slim)
if "%input%"=="re" (GOTO :RebuildCurrentInstallWIM)
if "%input%"=="info" (GOTO :GetCurrentImageInfo)
if "%input%"=="os" (GOTO :OneStep)
if "%input%"=="swi" (GOTO :SetWimInfoUser)
if "%input%"=="14" (START http://t.cn/RStk2bP)
if "%input%"=="15" (START http://t.cn/Ro0s9FK)
if %input% GTR 15 (
    ECHO.
    ECHO 请输入一个有效的数字
)
ECHO.
PAUSE
cls
GOTO ISOMenu
GOTO :EOF
::===================================================================================================================
::OneStep  
::===================================================================================================================
:OneStep
cls
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" KillRelatedProcess
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" FOOTER
ECHO.
SET InstallWim=!WORK_HOME!:\UPDATE_HOME\ISO\sources\install.wim
ECHO OneStep UpdateALL START
CALL :AddSupport UpdateALL
ECHO OneStep UpdateALL END
ECHO Win7SP1 3in1 full.wim 制作完毕
GOTO :EOF
::===================================================================================================================
::1.  [第1步:必须首先运行此项] 准备封装运行环境
::===================================================================================================================
:PREPARE
CALL :DoPrepare
CALL :SucessPause 离线添加更新的工作环境已经准备好了.
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:DoPrepare
cls
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" KillRelatedProcess
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" FOOTER
ECHO.
ECHO 提示:根据你的实际情况输入,A只是一个例子.注意不要输入目录的路径,必须是分区盘符的根路径.
ECHO.
ECHO 只需输入盘符的字母本身,不要输入":" , "\"等其它符号,否则程序将无法正确进行。
GOTO :InputWorkHome

::-------------------------------------------------------------------------------------------------------------------

:InputWorkHome
rem 等待用户输入
SET WORK_HOME=
ECHO.
SET /p WORK_HOME=输入一个剩余空间大于30G的分区盘符,不包含冒号.^(例如 D ^>

rem 去掉输入值前后的空格
:Trim
FOR /F "tokens=* delims= " %%a in ("!WORK_HOME!") do SET WORK_HOME=%%a
for /l %%a in (1,1,100) do if "!WORK_HOME:~-1!"==" " SET WORK_HOME=!WORK_HOME:~0,-1!
GOTO :CheckWhetherInputIsEmpty

rem 检测输入的盘符是否为空
:CheckWhetherInputIsEmpty
IF "!WORK_HOME!" EQU "" (
    ECHO.
    ECHO 您还没有输入盘符,请重新输入.
    GOTO :InputWorkHome
) ELSE (
    ECHO.
    rem 如果不为空,则去校验输入的盘符是否存在
    GOTO :CheckInputLetter
)
GOTO :EOF

rem 将输入的盘符转成大写字母
:toUpperCase
FOR /F "usebackq delims=" %%I in (`powershell "\"%1\".toUpper()"`) do SET "WORK_HOME=%%~I"
GOTO :EOF

:CheckInputLetter
CALL :toUpperCase "!WORK_HOME!"

rem fsutil fsinfo drives 命令可以获得当前电脑的存在的盘符
FOR /F "tokens=1,* delims= " %%a in ('fsutil fsinfo drives') DO (
    for %%c in (%%~b) DO (
        SET Drive=%%c
        SET Drive=!Drive:~0,-2!
        rem 循环判断,输入的值,与当前电脑存在的盘符是否有匹配的
        if "!Drive!"=="!WORK_HOME!" (
            rem 如果发现有匹配的则,继续执行剩余空间的检测
            rem 同时将 FLAG标志设置为1
            SET /A FLAG=1
            CALL :CheckFreeSpace !WORK_HOME!
            GOTO :EOF
        )
        rem 如果输入的盘符一直无法于当前电脑存在的盘符匹配,设值FLAG标记值为0
        if "!Drive!" NEQ "!WORK_HOME!" SET /A FLAG=0
	)
)

rem 通过上面的循环检测,如果FLAG值不等1,说明输入的盘符不存在
IF "!FLAG!" NEQ "1" (
    ECHO.
    ECHO 您输入的分区不存在,请重新输入.
    ECHO.    
    GOTO :InputWorkHome
) ELSE (
    CALL :CheckFreeSpace !WORK_HOME!
)
SET /A FLAG=0
SET WORK_HOME=
GOTO :EOF

rem 检测输入盘符对应分区的剩余空间
:CheckFreeSpace
FOR /F "usebackq delims== tokens=2" %%v IN (`wmic logicaldisk where "DeviceID='%1:'" get FreeSpace /format:value`) DO SET "FreeSpace=%%v"
FOR /F "usebackq delims=" %%v IN (`powershell -noprofile "& {[math]::truncate(%FreeSpace%/ 1GB)}"`) DO SET /A "FreeSpace=%%v"
if %FreeSpace% lss 30 (
    ECHO.    
    ECHO 剩余空间 小于 30GB,请输入一个剩余空间大于30GB的分区盘符
    GOTO :InputWorkHome
) else (
    GOTO :SetWorkHome
)
GOTO :EOF

:SetWorkHome
CALL "!APP_HOME!\SourceCode\Common\Utils\SetPathNow.bat" WORK_HOME
IF NOT EXIST !WORK_HOME!:\UPDATE_HOME\ MD !WORK_HOME!:\UPDATE_HOME\
IF NOT EXIST !WORK_HOME!:\UPDATE_HOME\ISO\ MD !WORK_HOME!:\UPDATE_HOME\ISO\
IF NOT EXIST !WORK_HOME!:\UPDATE_HOME\NEW_ISO\ MD !WORK_HOME!:\UPDATE_HOME\NEW_ISO\
IF NOT EXIST !WORK_HOME!:\UPDATE_HOME\INSTALL_MOUNT\ MD !WORK_HOME!:\UPDATE_HOME\INSTALL_MOUNT\
IF NOT EXIST !WORK_HOME!:\UPDATE_HOME\BOOT_MOUNT\ MD !WORK_HOME!:\UPDATE_HOME\BOOT_MOUNT\
IF NOT EXIST !WORK_HOME!:\UPDATE_HOME\Temp\ MD !WORK_HOME!:\UPDATE_HOME\Temp\
SET WimMountDir=!WORK_HOME!:\UPDATE_HOME\INSTALL_MOUNT
CALL "!APP_HOME!\SourceCode\Common\Utils\SetPathNow.bat" WimMountDir
GOTO :DoPrepareEnd

:DoPrepareEnd
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" FOOTER
GOTO :CheckAndExtractImage

:CheckAndExtractImage
CALL "%APP_HOME%\SourceCode\Common\Utils\CheckAndExtractImage.bat"
GOTO :ISOMenu
::===================================================================================================================
:CheckWhetherWorkHomeIsEmpty
if "%WORK_HOME%"=="" (
    mode con:cols=94 lines=42
    ECHO.
    ECHO 请先运行 [第1步:必须首先运行此项] 准备封装运行环境
    ECHO.
    pause
    CALL :DoPrepare
    GOTO :EOF
)
GOTO :EOF
::===================================================================================================================
::2.  [注意:2和3只能2选1]离线添加更新到install.wim[升至IE11]
::3.  [注意:2和3只能2选1]离线添加更新到install.wim[保留IE8]
::===================================================================================================================
:InstallUpdateToWIMWith
CALL :DoInstallUpdateToWIMWith %~1
CALL :SucessPause 成功了...
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:DoInstallUpdateToWIMWith
mode con:cols=105 lines=42
cls
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" KillRelatedProcess
cls
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" FOOTER
CALL :CheckWhetherWorkHomeIsEmpty
CALL :AutoStartMount
CALL :InstallUpdateToWIM
CALL :Install%~1
CALL :InstallRollupFix
CALL :AddNecessarySetupScripts
CALL :DoCleanup
CALL :CommitWIM
CALL :RebuildWimCurrentIndex install
GOTO :EOF
::===================================================================================================================
::4.  [可选]在Install.wim 中添加 微软.NET Framework v4.7 正式版本
::5.  [可选]在Install.wim 中添加 微软 DirectX9.0c 最终版
::6.  [可选]在Install.wim 中添加 Microsoft Visual C++[2005-2017]运行库
::===================================================================================================================
:AddToInstall
cls
CALL :CheckWhetherWorkHomeIsEmpty
SET WimMountDir=!WORK_HOME!:\UPDATE_HOME\INSTALL_MOUNT
SET InstallWim=!WORK_HOME!:\UPDATE_HOME\ISO\sources\Install.wim
FOR /F "tokens=2 delims=: " %%a in ('!DISM! /Get-WimInfo /WimFile:!InstallWim! ^| find /i "Index"') DO (
    SET WimIndexNo=%%~a
    for /d %%b in (!WimIndexNo!) DO (IF NOT EXIST "!WimMountDir!\%%b" MD "!WimMountDir!\%%b")&&(!DISM! /mount-wim /wimfile:"%InstallWim%" /index:%%b /mountdir:"!WimMountDir!\%%b")
    CALL :AddPack %~1
    for /d %%c in (!WimIndexNo!) DO (!DISM! /unmount-wim /mountdir:"!WimMountDir!\%%c" /commit /checkintegrity)
    for /d %%c in (!WimIndexNo!) DO (rd /s /q "!WimMountDir!\%%c")
)
CALL :RebuildWim install
CALL :SucessPause 添加成功。
GOTO :EOF
::===================================================================================================================
::7.  [可选]在Install.wim中同时加入以上 4，5，6
::===================================================================================================================
:AddPacksToInstall
cls
CALL :CheckWhetherWorkHomeIsEmpty
SET WimMountDir=!WORK_HOME!:\UPDATE_HOME\INSTALL_MOUNT
SET InstallWim=!WORK_HOME!:\UPDATE_HOME\ISO\sources\Install.wim
FOR /F "tokens=2 delims=: " %%a in ('!DISM! /Get-WimInfo /WimFile:!InstallWim! ^| find /i "Index"') DO (
    SET WimIndexNo=%%~a
    for /d %%b in (!WimIndexNo!) DO (IF NOT EXIST "!WimMountDir!\%%b" MD "!WimMountDir!\%%b")&&(!DISM! /mount-wim /wimfile:"%InstallWim%" /index:%%b /mountdir:"!WimMountDir!\%%b")
    CALL :AddPack NetFX47
    CALL :AddPack RuntimePack
    CALL :AddPack DirectX9c
    for /d %%c in (!WimIndexNo!) DO (!DISM! /unmount-wim /mountdir:"!WimMountDir!\%%c" /commit /checkintegrity)
    for /d %%c in (!WimIndexNo!) DO (rd /s /q "!WimMountDir!\%%c")
)
CALL :RebuildWim install
CALL :SucessPause 添加成功。
GOTO :EOF
::===================================================================================================================
::8.  [可选]在ISO中添加 万能网卡驱动[推荐加入] 
::===================================================================================================================
:AddingNetworkDriverToISO
cls
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" FOOTER
CALL :CheckWhetherWorkHomeIsEmpty
(IF NOT EXIST "!WORK_HOME!:\UPDATE_HOME\ISO\sources\$OEM$\$1\drv" MD "!WORK_HOME!:\UPDATE_HOME\ISO\sources\$OEM$\$1\drv")&&(XCOPY "%APP_HOME%\Packs\Drivers\drv\*.*" "!WORK_HOME!:\UPDATE_HOME\ISO\sources\$OEM$\$1\drv\" /y /s /e /h /q  >NUL 2>&1)
CALL :SucessPause 加入万能网卡驱动成功。
GOTO :EOF
::===================================================================================================================
::9.  [可选]加入 USB3 驱动[让镜像支持原本无法安装WIN7的新主板]
::10. [可选]加入 NVMe 驱动[若无NVMe固态硬盘,选择此项是多余的]
::===================================================================================================================
:AddSupport
cls
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" FOOTER

if "%~1"=="USB3" CALL :AddingSupport %~1 boot
if "%~1"=="NVMe" CALL :AddingSupport %~1 boot

CALL :AddingSupport %~1 install
if "%~1"=="slim" (
    ECHO.
    ECHO 瘦身成功. . .
    ECHO.
) else (
    ECHO 成功添加%~1支持. . .
)
CALL :SucessPause
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:AddingSupport
CALL :CheckWhetherWorkHomeIsEmpty
SET WimMountDir=!WORK_HOME!:\UPDATE_HOME\%~2_MOUNT
SET InstallWim=!WORK_HOME!:\UPDATE_HOME\ISO\sources\%~2.wim
SET DRIVERHOME=!APP_HOME!\Packs\Drivers\%~1\!OS_ARCHITECTURE!
if "%~1" NEQ "slim" (
    ECHO 正在为%~2.wim添加%~1支持. . .
    ECHO.
)
if "%~1"=="NVMe" (
    XCOPY "%APP_HOME%\Packs\ISOPrepare\NVMe\*.*"  "!WORK_HOME!:\UPDATE_HOME\ISO\" /y /e /h /q>NUL 2>&1
)
FOR /F "tokens=2 delims=: " %%a in ('!DISM! /Get-WimInfo /WimFile:!InstallWim! ^| find /i "Index"') DO (
    SET WimIndexNo=%%~a
    for /d %%b in (!WimIndexNo!) DO (IF NOT EXIST "!WimMountDir!\%%b" MD "!WimMountDir!\%%b")&&(!DISM! /mount-wim /wimfile:"%InstallWim%" /index:%%b /mountdir:"!WimMountDir!\%%b")
    if "%~1"=="UpdateALL" (
        if "%~2"=="install" (
            mode con:cols=105 lines=42
            CALL :InstallUpdateToWIM
            CALL :InstallIE11
            CALL :InstallRollupFix
            CALL :AddPack NetFX47
            CALL :AddPack RuntimePack
            CALL :AddPack DirectX9c
            CALL :AddNecessarySetupScripts
            CALL :DoCleanup
        )
    ) else (
        if "%~1"=="slim" (
            ECHO 正在为%~2.wim进行瘦身操作. . .
            CALL :AddPack NetFX47
            CALL :AddPack RuntimePack
            CALL :AddPack DirectX9c
            CALL :DoCleanup
            ECHO 成功瘦身 !InstallWim! 的索引!WimIndexNo!中的映像. . .
        ) else (
            for /d %%c in (!WimIndexNo!) DO (
                !DISM! /image:"!WimMountDir!\%%c" /add-driver /driver:"!DRIVERHOME!" /forceunsigned /Recurse >NUL 2>&1
                ECHO.
                ECHO 成功添加%~1驱动到 !InstallWim!的映像索引!WimIndexNo!中. . .
                ECHO.
            )
            if "%~1"=="NVMe" (
                for /d %%c in (!WimIndexNo!) DO (!DISM! /Image:"!WimMountDir!\%%c" /add-package /packagepath:"!APP_HOME!\Updates\NVMe\Windows6.1-KB2990941-v3-!OS_ARCHITECTURE!.cab" /NoRestart) >NUL 2>&1
                for /d %%c in (!WimIndexNo!) DO (!DISM! /Image:"!WimMountDir!\%%c" /add-package /packagepath:"!APP_HOME!\Updates\NVMe\Windows6.1-KB3087873-v2-!OS_ARCHITECTURE!.cab" /NoRestart) >NUL 2>&1
                ECHO.                    
                ECHO 成功添加%~1补丁到 !InstallWim!的映像索引!WimIndexNo!中. . .
                ECHO.
            )     
        )
    )
    mode con:cols=94 lines=42
    for /d %%c in (!WimIndexNo!) DO (
        !DISM! /unmount-wim /mountdir:"!WimMountDir!\%%c" /commit /checkintegrity
        ECHO.
    )
    for /d %%c in (!WimIndexNo!) DO (rd /s /q "!WimMountDir!\%%c")
)
CALL :RebuildWim %~2
GOTO :EOF
::===================================================================================================================
:FIX
SET "SetupCompleteFile=%APP_HOME%\SourceCode\Configuration\SetupConfig\Common\Windows\Setup\Scripts\SetupComplete.cmd"
rem IF EXIST "!WimMountDir!\!WimIndexNo!\Windows\Setup\Scripts\Tweaks.reg" 
XCOPY "%SetupCompleteFile%"  "!WimMountDir!\!WimIndexNo!\Windows\Setup\Scripts\" /y /s /e /h /q
rem CALL :AddNecessarySetupScripts
GOTO :EOF
::===================================================================================================================
:AddSetupConfig
CALL :AddSomeOEMCertificates
XCOPY "%APP_HOME%\SourceCode\Configuration\SetupConfig\Common\*.*" "!WimMountDir!\!WimIndexNo!\" /y /s /e /h /q
IF NOT EXIST "!WimMountDir!\!WimIndexNo!\Windows\Setup\Files\Updates\" MD "!WimMountDir!\!WimIndexNo!\Windows\Setup\Files\Updates"
XCOPY "%APP_HOME%\Updates\ServicingStack\*.*" "!WimMountDir!\!WimIndexNo!\Windows\Setup\Files\Updates\" /y /s /e /h /q
XCOPY "%APP_HOME%\Updates\KB976932\*.*" "!WimMountDir!\!WimIndexNo!\Windows\Setup\Files\Updates\" /y /s /e /h /q
::CALL :AddingUnattendToWIM admin
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:AddFlashPlayer
IF NOT EXIST "!WimMountDir!\!WimIndexNo!\Windows\Setup\Files\Apps\" MD "!WimMountDir!\!WimIndexNo!\Windows\Setup\Files\Apps"
XCOPY "%APP_HOME%\Packs\FlashPlayer\*.*" "!WimMountDir!\!WimIndexNo!\Windows\Setup\Files\Apps\" /y /s /e /h /q >NUL 2>&1
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:AddUserUattend
IF EXIST "!WimMountDir!\!WimIndexNo!\Windows\Ultimate.xml" (
    XCOPY "!APP_HOME!\SourceCode\Configuration\Panther\!OS_ARCHITECTURE!\User\Ultimate\*.*" "!WimMountDir!\!WimIndexNo!\Windows\" /y /s /e /h >NUL 2>&1
) else (
    XCOPY "!APP_HOME!\SourceCode\Configuration\Panther\!OS_ARCHITECTURE!\User\NotUltimate\*.*" "!WimMountDir!\!WimIndexNo!\Windows\" /y /s /e /h >NUL 2>&1
)
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:AddThemePatch
XCOPY "%APP_HOME%\Packs\ThemePatch\!OS_ARCHITECTURE!\*.*" "!WimMountDir!\!WimIndexNo!\Windows\System32\" /y /s /e /h /q >NUL 2>&1
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:AddSomeOEMCertificates
XCOPY "%APP_HOME%\Packs\OEM" "!WimMountDir!\!WimIndexNo!\Windows\System32\OEM\" /y /s /e /h /q >NUL 2>&1
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:AddNecessarySetupScripts
IF NOT EXIST "!WimMountDir!\!WimIndexNo!\Windows\Setup\Scripts" MD "!WimMountDir!\!WimIndexNo!\Windows\Setup\Scripts" >NUL 2>&1
XCOPY "%APP_HOME%\SourceCode\Configuration\SetupConfig\Common\Windows\Setup\Scripts\SetupComplete.cmd" "!WimMountDir!\!WimIndexNo!\Windows\Setup\Scripts" /y /s /e /h /q >NUL 2>&1
XCOPY "%APP_HOME%\SourceCode\Configuration\SetupConfig\Common\Windows\System32\FirstLogon.bat" "!WimMountDir!\!WimIndexNo!\Windows\System32\" /y /s /e /h /q >NUL 2>&1
XCOPY "%APP_HOME%\SourceCode\Configuration\SetupConfig\Common\Windows\System32\drivers\etc\hosts" "!WimMountDir!\!WimIndexNo!\Windows\System32\drivers\etc\" /y /s /e /h /q >NUL 2>&1
IF NOT EXIST "!WimMountDir!\!WimIndexNo!\Windows\Setup\Files\Updates\" MD "!WimMountDir!\!WimIndexNo!\Windows\Setup\Files\Updates" >NUL 2>&1
XCOPY "%APP_HOME%\Updates\ServicingStack\*.*" "!WimMountDir!\!WimIndexNo!\Windows\Setup\Files\Updates\" /y /s /e /h /q >NUL 2>&1
XCOPY "%APP_HOME%\Updates\KB976932\*.*" "!WimMountDir!\!WimIndexNo!\Windows\Setup\Files\Updates\" /y /s /e /h /q >NUL 2>&1
CALL :AddUserUattend >NUL 2>&1
GOTO :EOF
::===================================================================================================================
::11. [可选]为镜像添加无人值守安装功能[使用Admin用户登录]
::===================================================================================================================
:AddUnattendToWIM
cls
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" FOOTER
CALL :CheckWhetherWorkHomeIsEmpty
SET WimMountDir=!WORK_HOME!:\UPDATE_HOME\INSTALL_MOUNT
SET InstallWim=!WORK_HOME!:\UPDATE_HOME\ISO\sources\Install.wim
FOR /F "tokens=2 delims=: " %%a in ('!DISM! /Get-WimInfo /WimFile:!InstallWim! ^| find /i "Index"') DO (
    SET WimIndexNo=%%~a
    for /d %%b in (!WimIndexNo!) DO (IF NOT EXIST "!WimMountDir!\%%b" MD "!WimMountDir!\%%b")&&(!DISM! /mount-wim /wimfile:"%InstallWim%" /index:%%b /mountdir:"!WimMountDir!\%%b")
    CALL :AddSetupConfig >NUL 2>&1
    CALL :AddingUnattendToWIM %~1
    for /d %%c in (!WimIndexNo!) DO (!DISM! /unmount-wim /mountdir:"!WimMountDir!\%%c" /commit /checkintegrity)
    for /d %%c in (!WimIndexNo!) DO (rd /s /q "!WimMountDir!\%%c")
)
CALL :RebuildWim install
CALL :SucessPause 添加成功。
GOTO :EOF
::------------------------------------------------------------------------------------------------------------------
:AddingUnattendToWIM
for /d %%a in (!WimIndexNo!) DO (
    IF EXIST "!WimMountDir!\%%a\Windows\Ultimate.xml" (
        SET "COPYFROM=!APP_HOME!\SourceCode\Configuration\Panther\!OS_ARCHITECTURE!\%~1\Ultimate\*.*"
        SET "COPYTO=!WimMountDir!\%%a\Windows"
        XCOPY  !COPYFROM! !COPYTO! /y /s /e /h /q >NUL 2>&1
    ) else (
        SET "COPYFROM=!APP_HOME!\SourceCode\Configuration\Panther\!OS_ARCHITECTURE!\%~1\NotUltimate\*.*"
        SET "COPYTO=!WimMountDir!\%%a\Windows"
        XCOPY  !COPYFROM! !COPYTO! /y /s /e /h /q >NUL 2>&1
    )
)
ECHO.
ECHO 成功为镜像添加无人值守安装功能 ...
GOTO :EOF
::===================================================================================================================
::12.[可选]解除官方最新补丁对Ryzen和7代酷睿处理器不能使用Win7的限制[非Ryzen和7代酷睿,不推荐]
::===================================================================================================================
:AddNewCPUSupportPatch
cls
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" FOOTER
CALL :CheckWhetherWorkHomeIsEmpty
SET WimMountDir=!WORK_HOME!:\UPDATE_HOME\INSTALL_MOUNT
SET InstallWim=!WORK_HOME!:\UPDATE_HOME\ISO\sources\Install.wim
FOR /F "tokens=2 delims=: " %%a in ('!DISM! /Get-WimInfo /WimFile:!InstallWim! ^| find /i "Index"') DO (
    SET WimIndexNo=%%~a
    for /d %%b in (!WimIndexNo!) DO (IF NOT EXIST "!WimMountDir!\%%b" MD "!WimMountDir!\%%b")&&(!DISM! /mount-wim /wimfile:"%InstallWim%" /index:%%b /mountdir:"!WimMountDir!\%%b")
    CALL :AddingNewCPUSupportPatch
    for /d %%c in (!WimIndexNo!) DO (!DISM! /unmount-wim /mountdir:"!WimMountDir!\%%c" /commit /checkintegrity)
    for /d %%c in (!WimIndexNo!) DO (rd /s /q "!WimMountDir!\%%c")
)
CALL :RebuildWim install
CALL :SucessPause 成功解除官方最新补丁对Ryzen和7代酷睿处理器不能使用Win7的限制 ...
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:AddingNewCPUSupportPatch
XCOPY "%APP_HOME%\Packs\NewCPUSupportPatch\!OS_ARCHITECTURE!\*.*" "!WimMountDir!\!WimIndexNo!\Windows\System32\" /y /s /e /h /q >NUL 2>&1
XCOPY "%APP_HOME%\Packs\NewCPUSupportPatch\install_wufuc.bat" "!WimMountDir!\!WimIndexNo!\Windows\System32\" /y /s /e /h /q >NUL 2>&1
GOTO :EOF
::===================================================================================================================
::13. [最后执行此项]为您生成全新的ISO
::===================================================================================================================
:CreateISO
cls
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" FOOTER
CALL :CheckWhetherWorkHomeIsEmpty
ECHO.
ECHO 正在生成新的支持BIOS与UEFI双启动的ISO镜像. . .
CALL "!APP_HOME!\SourceCode\Common\Utils\ISOPrepare.bat" >NUL 2>&1
CALL :TimeUtil
CALL :NameUtil
SET "ISOCreateTime=%MM%/%dd%/%yyyy%,%HH%:%Min%:%Sec%"
SET "ISONameTimeStamp=%yyyy%%MM%%dd%%HH%%Min%"
SET ISOFinalName=Win7SP1!OS_ARCHITECTURE!!ISONAME!WithUpdate!ISONameTimeStamp!.iso
!oscdimg! -bootdata:2#p0,e,b!etfsboot!#pEF,e,b!efisys! -o -u2 -udfver102 -lWIN7SP1_CN_DVD_%yyyy%%MM% -t!ISOCreateTime! !WORK_HOME!:\UPDATE_HOME\ISO !WORK_HOME!:\UPDATE_HOME\NEW_ISO\!ISOFinalName!
cls
ECHO.
ECHO 成功生成新的支持BIOS与UEFI双启动的ISO镜像. . .
ECHO.
ECHO 新生成的ISO镜像文件位于!WORK_HOME!:\UPDATE_HOME\NEW_ISO\!ISOFinalName!
ECHO.
ECHO 强烈建议在虚拟机中安装测试一次新生成的ISO，测试没有问题再往实体上安装。
ECHO.
ECHO 否则万一出现无法安装的情况，会浪费您更多宝贵的时间。
ECHO.
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" FOOTER
ECHO 按 "任意键" 打开新创建的ISO所在的目录
PAUSE >nul
START/max "" explorer.exe /n,"!WORK_HOME!:\UPDATE_HOME\NEW_ISO\"
GOTO :ISOMenu
GOTO :EOF
cls
::===================================================================================================================
:InstallUpdateToWIM
cls
ECHO  ============================================================================================
ECHO.
ECHO          正在添加更新到已挂载到!WimMountDir!\!WimIndexNo!的系统映像中,请稍后 ...
ECHO.
ECHO  ============================================================================================
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" FOOTER
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" CleanTemp
SET "TipUpdate=用于基于 !OS_ARCHITECTURE! 的系统的 Windows 7 更新程序"
SET "TipNet351=用于 Windows 7 SP1 !OS_ARCHITECTURE! 上的 Microsoft .NET Framework 3.5.1 的安全更新程序"
SET "TipSecurityUpdate=用于基于 !OS_ARCHITECTURE! 的系统的 Windows 7 安全更新程序"
for /d %%a in (!WimIndexNo!) do !StartPlus! !APP_HOME!\SourceCode\Common\Utils\OfflineInstallCAB.bat !APP_HOME!\Updates\CAB\OptionalUpdate "!TipUpdate!"
for /d %%a in (!WimIndexNo!) do !StartPlus! !APP_HOME!\SourceCode\Common\Utils\OfflineInstallCAB.bat !APP_HOME!\Updates\CAB\NET351 "!TipNet351!"
for /d %%a in (!WimIndexNo!) do !StartPlus! !APP_HOME!\SourceCode\Common\Utils\OfflineInstallCAB.bat !APP_HOME!\Updates\CAB\Updates1st "!TipUpdate!"
for /d %%a in (!WimIndexNo!) do !StartPlus! !APP_HOME!\SourceCode\Common\Utils\OfflineInstallCAB.bat !APP_HOME!\Updates\CAB\SecurityUpdate "!TipSecurityUpdate!"
for /d %%a in (!WimIndexNo!) do !StartPlus! !APP_HOME!\SourceCode\Common\Utils\OfflineInstallCAB.bat !APP_HOME!\Updates\CAB\Updates2nd "!TipUpdate!"
CALL :InstallExclusive%OS_ARCHITECTURE%
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" CleanTemp
GOTO :EOF
::===================================================================================================================
:InstallIE11
ECHO 正在添加 IE11
SET "IE11_HOME=!APP_HOME!\Updates\IE\IE11"
for /d %%a in (!WimIndexNo!) do !DISM! /Image:"!WimMountDir!\%%a" /add-package /PackagePath:!IE11_HOME!\temp\IE11-neutral.Downloaded.cab /NoRestart /Quiet
for /d %%a in (!WimIndexNo!) do !DISM! /Image:"!WimMountDir!\%%a" /add-package /PackagePath:!IE11_HOME!\temp\IE11_%PROCESSOR_ARCHITECTURE%_zh-CN.cab /NoRestart /Quiet
for /d %%a in (!WimIndexNo!) do !DISM! /Image:"!WimMountDir!\%%a" /add-package /PackagePath:!IE11_HOME!\temp\Spelling_en\Windows6.3-KB2849696-x86.cab /NoRestart /Quiet
for /d %%a in (!WimIndexNo!) do !DISM! /Image:"!WimMountDir!\%%a" /add-package /PackagePath:!IE11_HOME!\temp\Hyphenation_en\Windows6.3-KB2849697-x86.cab /NoRestart /Quiet
ECHO 成功添加 IE11
GOTO :EOF
::===================================================================================================================
:InstallIE8Update
ECHO 正在添加 IE8的安全更新
SET "IE8_HOME=!APP_HOME!\Updates\IE\IE8"
for /d %%a in (!WimIndexNo!) do !DISM! /Image:"!WimMountDir!\%%a" /add-package /PackagePath:!IE8_HOME!\Windows6.1-KB2598845-%OS_ARCHITECTURE%.cab /NoRestart /Quiet
for /d %%a in (!WimIndexNo!) do !DISM! /Image:"!WimMountDir!\%%a" /add-package /PackagePath:!IE8_HOME!\Windows6.1-KB3124275-%OS_ARCHITECTURE%.cab /NoRestart /Quiet
ECHO 成功添加 IE8的安全更新
GOTO :EOF
::===================================================================================================================
:InstallExclusivex64
for /d %%a in (!WimIndexNo!) do !StartPlus! !APP_HOME!\SourceCode\Common\Utils\OfflineInstallCAB.bat !APP_HOME!\Updates\CAB\Exclusive\Update "!TipUpdate!" 
GOTO :EOF
:InstallExclusivex86
for /d %%a in (!WimIndexNo!) do !StartPlus! !APP_HOME!\SourceCode\Common\Utils\OfflineInstallCAB.bat !APP_HOME!\Updates\CAB\Exclusive\Update "!TipUpdate!" 
for /d %%a in (!WimIndexNo!) do !StartPlus! !APP_HOME!\SourceCode\Common\Utils\OfflineInstallCAB.bat !APP_HOME!\Updates\CAB\Exclusive\SecurityUpdate "!TipSecurityUpdate!"
GOTO :EOF
::===================================================================================================================
:InstallRollupFix
SET RollupFixTip=适用于基于 !OS_ARCHITECTURE! 的系统的 Windows 7 月度安全质量汇总
for /d %%a in (!WimIndexNo!) do !StartPlus! !APP_HOME!\SourceCode\Common\Utils\OfflineInstallCAB.bat !APP_HOME!\Updates\RollupFix "!RollupFixTip!"
GOTO :EOF
::===================================================================================================================
:AutoMount
cls
SET wim=!WORK_HOME!:\UPDATE_HOME\ISO\sources\install.wim
ECHO.
ECHO 当前WIM的存放路径为:%wim%
ECHO.----------------------------------------------------------
ECHO 正在操作的install.wim中的映像的信息如下:
ECHO.----------------------------------------------------------
CALL :GetWimInfo
ECHO.----------------------------------------------------------
ECHO    ***************************************************************************
ECHO    *   小提示：                                                              *
ECHO    *   1.输入的编号必须在上面的列表中存在,更不能为空.                        *
ECHO    *   2.输入的编号必须是数字,范围从1到上面标号的最大值,包括最大值.          *
ECHO    *   3.如果输入有误,后续的操作一定会出错.                                  *
ECHO    ***************************************************************************
ECHO:
CALL :InputIndexNo
CALL :IndexNotNullLoop
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" FOOTER
GOTO :EOF
::===================================================================================================================
:CommitWIM
ECHO.
ECHO 正在保存更改到WIM中...
ECHO.
ECHO 保存更改到WIM中可能需要一些时间,请稍后...
ECHO.
for /d %%a in (!WimIndexNo!) do !DISM! /unmount-wim /mountdir:"!WimMountDir!\%%a" /commit
for /d %%a in (!WimIndexNo!) DO (rd /s /q "!WimMountDir!\%%a") >NUL 2>&1
ECHO.
ECHO 成功保存更改到WIM中...
GOTO :EOF
::===================================================================================================================
:GetWimInfo
ECHO ========================
ECHO 索引         名称
ECHO ========================
FOR /F "tokens=1,* delims= " %%a in ('!DISM! /Get-WimInfo /WimFile:!WORK_HOME!:\UPDATE_HOME\ISO\sources\install.wim') DO (
    if "%%~a"=="Index" (
        endlocal
        SET IndexSize=%%~b
        SET IndexSize=!IndexSize:~2,2!
    )
    if "%%~a"=="Name" (
        SET IndexName=%%~b
        SET IndexName=!IndexName:~2,20!
        ECHO  !IndexSize!   !IndexName!
    )
)
CALL "!APP_HOME!\SourceCode\Common\Utils\SetPathNow.bat" IndexSize
GOTO :EOF
::===================================================================================================================
:IndexNotNullLoop
if "!WimIndexNo!"=="" (
    ECHO.
    ECHO 分卷的编号不能为空,请重新输入.
    ECHO.
    CALL :InputIndexNo
    GOTO :IndexNotNullLoop
)
if "!WimIndexNo!"=="none" (
    ECHO.
    ECHO 分卷的编号不能为空,请重新输入.
    ECHO.
    CALL :InputIndexNo
    GOTO :IndexNotNullLoop
)
if not !WimIndexNo!=="" (
    if not !WimIndexNo!=="none" (
        GOTO :IndexNotExistLoop
    ))
GOTO :EOF
::===================================================================================================================
:IndexNotExistLoop
for /l %%g in (1, 1, !IndexSize!) DO (
    if !WimIndexNo!==%%g (
        SET flag=true
        GOTO :IndexNotExistLoopEnd
    )
    if not !WimIndexNo!==%%g (
        SET flag=false
        if %%g==!IndexSize! GOTO :IndexNotExistLoopEnd
    )
)
GOTO :EOF
::===================================================================================================================
:IndexNotExistLoopEnd
if "!flag!"=="false" (
    SET WimIndexNo=none
    ECHO.
    ECHO 您输入的索引值不存在,请重新输入.
    ECHO.
    CALL :InputIndexNo
    GOTO :IndexNotNullLoop
)
if "!flag!"=="true" (
    GOTO :StartMount
)
GOTO :EOF
::===================================================================================================================
:StartMount
cls
ECHO.
ECHO 开始安装镜像文件到!WimMountDir!\!WimIndexNo!目录下
ECHO.
for /d %%a in (!WimIndexNo!) DO (IF NOT EXIST "!WimMountDir!\%%a" MD "!WimMountDir!\%%a")&&(!DISM! /mount-wim /wimfile:"%wim%" /index:%%a /mountdir:"!WimMountDir!\%%a")
ECHO 成功安装镜像文件到!WimMountDir!\!WimIndexNo!目录下
ECHO.
GOTO :EOF
::===================================================================================================================
:InputIndexNo
SET /p WimIndexNo=输入要挂载的分卷的编号[请输入1到!IndexSize!之间的正整数] : ^>
CALL "!APP_HOME!\SourceCode\Common\Utils\SetPathNow.bat" WimIndexNo
GOTO :EOF
::===================================================================================================================
:HEADER
ECHO.----------------------------------------------------------
ECHO %~1
ECHO %~2
ECHO.----------------------------------------------------------
ECHO:
GOTO :EOF
::===================================================================================================================
:MENUHEADER
ECHO.----------------------------------------------------------
ECHO %~1
ECHO.----------------------------------------------------------
ECHO:
GOTO :EOF
::===================================================================================================================
:TITLE
title 离线添加更新到 WIM
GOTO :EOF
::===================================================================================================================
:TimeUtil
FOR /F "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do SET "dt=%%a"
SET "YY=%dt:~2,2%" & SET "YYYY=%dt:~0,4%" & SET "MM=%dt:~4,2%" & SET "DD=%dt:~6,2%"
SET "HH=%dt:~8,2%" & SET "Min=%dt:~10,2%" & SET "Sec=%dt:~12,2%"
GOTO :EOF
::===================================================================================================================
:NameUtil
SET "UltimateFlag=!WORK_HOME!:\UPDATE_HOME\ISO\sources\install_Windows 7 ULTIMATE.clg"
SET "EnterpriseFlag=!WORK_HOME!:\UPDATE_HOME\ISO\sources\install_Windows 7 ENTERPRISE.clg"
SET "ProfessionalFlag=!WORK_HOME!:\UPDATE_HOME\ISO\sources\install_Windows 7 PROFESSIONAL.clg"
IF EXIST "!ULTIMATEFlag!" (
    SET ISONAME=Ultimate
) else (
    IF EXIST "!EnterpriseFlag!" (
        SET ISONAME=Enterprise
    )    
    IF EXIST "!ProfessionalFlag!" (
        SET ISONAME=Professional
    )
)
GOTO :EOF
::===================================================================================================================
:RebuildWim
SET InstallWim=!WORK_HOME!:\UPDATE_HOME\ISO\sources\%~1.wim
SET TempFile=!WORK_HOME!:\UPDATE_HOME\ISO\sources\%~1rebuild.wim
FOR /F "tokens=1,* delims= " %%a in ('!DISM! /Get-WimInfo /WimFile:!InstallWim!') DO (
    if "%%~a"=="Index" (
        endlocal
        SET IndexLength=%%~b
        SET IndexLength=!IndexLength:~2,2!
    )
)
del /f /q /a !TempFile!>NUL 2>&1
for /l %%g in (1, 1, !IndexLength!) DO (
    !DISM! /Export-Image /SourceImageFile:!InstallWim! /SourceIndex:%%g /DestinationImageFile:!TempFile! /Compress:Max
)
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" KillRelatedProcess
del /f /q /a !InstallWim!
ren !TempFile! %~1.wim>NUL 2>&1
GOTO :EOF
::===================================================================================================================
:RebuildWimCurrentIndex
SET InstallWim=!WORK_HOME!:\UPDATE_HOME\ISO\sources\%~1.wim
SET TempFile=!WORK_HOME!:\UPDATE_HOME\ISO\sources\%~1temp.wim
del /f /q /a !TempFile!>NUL 2>&1
!DISM! /Export-Image /SourceImageFile:!InstallWim! /SourceIndex:!WimIndexNo! /DestinationImageFile:!TempFile! /Quiet /Compress:Max
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" KillRelatedProcess
del /f /q /a !InstallWim!>NUL 2>&1
ren !TempFile! %~1.wim>NUL 2>&1
GOTO :EOF
::===================================================================================================================
:MountWim
SET InstallWim=!WORK_HOME!:\UPDATE_HOME\ISO\sources\%~1.wim
SET WimIndexNo=1
for /d %%a in (!WimIndexNo!) DO (IF NOT EXIST "!WimMountDir!\%%a" MD "!WimMountDir!\%%a")&&(!DISM! /mount-wim /wimfile:"!InstallWim!" /index:%%a /mountdir:"!WimMountDir!\%%a")
GOTO :EOF
::===================================================================================================================
:AddAboveALLToWIM
SET "FROM=%APP_HOME%\Updates\Runtimes\*.*"
SET "TO=!WimMountDir!\!WimIndexNo!\Windows\Setup\Files\Runtimes\"
(IF NOT EXIST "!TO!" MD "!TO!")&&(XCOPY "!FROM!" "!TO!" /y /s /e /h /q)
GOTO :EOF
::===================================================================================================================
:AddWanDrvLiteToWIM
(IF NOT EXIST "!WimMountDir!\!WimIndexNo!\drv" MD "!WimMountDir!\!WimIndexNo!\drv")&&(XCOPY "%APP_HOME%\Packs\Drivers\drv\*.*" "!WimMountDir!\!WimIndexNo!\drv\" /y /s /e /h /q  >NUL 2>&1)
GOTO :EOF
::===================================================================================================================
:AutoDiscard
cls
CALL :MENUHEADER " 清理当前挂载的镜像，且不提交之前对镜像的任何修改。"
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" DoAutoDiscard
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" FOOTER
PAUSE
GOTO :ISOMenu
GOTO :EOF
::===================================================================================================================
:SucessPause
if "%~1"=="" (
    ECHO.
) else (
    ECHO.
    ECHO %~1
    ECHO.
)
ECHO 按"任意键"返回上层菜单,继续操作. . .
PAUSE >nul
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" FOOTER
GOTO :ISOMenu
GOTO :EOF
::===================================================================================================================
:GetIndexInstalled
FOR /F "tokens=1,* delims=: " %%a in ('%DISM% /Get-WimInfo /WimFile:"!WORK_HOME!:\UPDATE_HOME\ISO\sources\install.wim"') DO (
    if "%%~a"=="Index" (
        SET IndexSize=%%~b
    )
)
if "%IndexSize%"=="1" (
    SET WimIndexNo=1
)
GOTO :EOF
::===================================================================================================================
:AutoStartMount
IF EXIST !WimMountDir! (
    CALL :DoAutoDiscard >nul
) else (
    MD "!WimMountDir!"  
)
CALL :GetIndexInstalled
IF "!MountedState!"=="Ok" (
    GOTO :EOF
)else (
    if "!WimIndexNo!"=="1" (
        for /d %%a in (!WimIndexNo!) DO (IF NOT EXIST "!WimMountDir!\%%a" MD "!WimMountDir!\%%a")&&(!DISM! /mount-wim /wimfile:"!wim!" /index:%%a /mountdir:"!WimMountDir!\%%a") 
    )else (
        CALL :AutoMount
    )
    GOTO :EOF
)
::-------------------------------------------------------------------------------------------
:AddPack
ECHO.
ECHO 正在将%~1的文件导入到已挂载的系统镜像中
SET "Pack=%APP_HOME%\Packs\%~1"
CALL :ApplyWim "%Pack%\%~1_%OS_ARCHITECTURE%.esd", 1, "!WimMountDir!\!WimIndexNo!"
if "%~1" == "NetFX47" CALL :ApplyWim "%Pack%\%~1_CHS_%OS_ARCHITECTURE%.esd", 1, "!WimMountDir!\!WimIndexNo!"
CALL :MountWIMRegistry "!WimMountDir!\!WimIndexNo!"
if "%~1" == "NetFX47" CALL :TakeRegistryOwnerShip "HKLM\WIM_Software\Classes\CLSID\{FEDB2179-2335-48F1-AA28-5CDA35A2B36D}\InprocServer32"
ECHO.
ECHO 将%~1的相关注册表离线导入到已挂载的注册表中
CALL :ImportReg2WIM "%Pack%\%~1_%OS_ARCHITECTURE%.reg"
if "%~1" == "NetFX47" CALL :ImportReg2WIM "%Pack%\%~1_CHS_%OS_ARCHITECTURE%.reg"
CALL :UnMountWIMRegistry
GOTO :EOF
::-------------------------------------------------------------------------------------------
:ApplyWim
%DISM% /Apply-Image /ImageFile:%~1 /Index:%~2 /ApplyDir:%~3\ /CheckIntegrity /Verify
GOTO :EOF
::-------------------------------------------------------------------------------------------
:MountWIMRegistry
ECHO.
ECHO 加载当前挂载镜像的注册表配置单元
reg load HKLM\WIM_Software "%~1\Windows\System32\config\software" >nul
reg load HKLM\WIM_System "%~1\Windows\System32\config\system" >nul
reg load HKLM\WIM_Current_User "%~1\Users\Default\ntuser.dat" >nul
reg load HKLM\WIM_User_Default "%~1\Windows\System32\config\default" >nul
GOTO :EOF
::-------------------------------------------------------------------------------------------
:UnMountWIMRegistry
ECHO.
ECHO 卸载已挂载的注册表配置单元.
reg unload HKLM\WIM_Software >nul
reg unload HKLM\WIM_System >nul
reg unload HKLM\WIM_Current_User >nul
reg unload HKLM\WIM_User_Default >nul
GOTO :EOF
::-------------------------------------------------------------------------------------------
:ImportReg2WIM
reg import %~1 >NUL 2>&1
GOTO :EOF
::-------------------------------------------------------------------------------------------
:TakeRegistryOwnerShip
SET "SetACL=%APP_HOME%\Bin\%PROCESSOR_ARCHITECTURE%\SetACL.exe"
ECHO.
ECHO 更改WIM注册表项所有权.
"%SetACL%" -on "%~1" -ot reg -actn setowner -ownr "n:S-1-5-32-544;s:y" -rec yes >nul
ECHO.
ECHO 设置WIM注册表项权限
"%SetACL%" -on "%~1" -ot reg -actn ace -ace "n:S-1-5-32-544;s:y;p:full" -rec yes >nul
GOTO :EOF
::===================================================================================================================
:DoCleanup
cls
CALL %APP_HOME%\SourceCode\Common\Utils\CleanMountedImage.bat %WimMountDir%\%WimIndexNo% CleanUpLevelOne
cls
GOTO :EOF
::===================================================================================================================
:RebuildCurrentInstallWIM
cls
CALL "%APP_HOME%\SourceCode\Common\Utils\MyUtils.bat" FOOTER
CALL :AutoStartMount
ECHO.
ECHO 正在重建install.wim . . .
CALL :RebuildWimCurrentIndex install
CALL :SucessPause 成功重建install.wim . . .
GOTO :EOF
::===================================================================================================================
:GetCurrentImageInfo
cls
!DISM! /Get-MountedImageInfo
CALL :SucessPause
GOTO :EOF