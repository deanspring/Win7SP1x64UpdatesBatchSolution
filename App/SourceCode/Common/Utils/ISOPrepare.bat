@ECHO OFF
Setlocal enabledelayedexpansion
SET ISOHOME=!WORK_HOME!:\UPDATE_HOME\ISO
rd /s /q %ISOHOME%\support
rd /s /q %ISOHOME%\upgrade
rd /s /q %ISOHOME%\sources\license\_default\_default\enterprisee
rd /s /q %ISOHOME%\sources\license\_default\_default\enterprisen
rd /s /q %ISOHOME%\sources\license\_default\_default\homebasic
rd /s /q %ISOHOME%\sources\license\_default\_default\homebasice
rd /s /q %ISOHOME%\sources\license\_default\_default\homebasicn
rd /s /q %ISOHOME%\sources\license\_default\_default\homepremium
rd /s /q %ISOHOME%\sources\license\_default\_default\homepremiume
rd /s /q %ISOHOME%\sources\license\_default\_default\homepremiumn
rd /s /q %ISOHOME%\sources\license\_default\_default\professionale
rd /s /q %ISOHOME%\sources\license\_default\_default\professionaln
rd /s /q %ISOHOME%\sources\license\_default\_default\starter
rd /s /q %ISOHOME%\sources\license\_default\_default\startere
rd /s /q %ISOHOME%\sources\license\_default\_default\startern
rd /s /q %ISOHOME%\sources\license\_default\_default\ultimatee
rd /s /q %ISOHOME%\sources\license\_default\_default\ultimaten
rd /s /q %ISOHOME%\sources\license\_default\eval\enterprisee
rd /s /q %ISOHOME%\sources\license\_default\eval\enterprisen
rd /s /q %ISOHOME%\sources\license\_default\eval\homebasic
rd /s /q %ISOHOME%\sources\license\_default\eval\homebasice
rd /s /q %ISOHOME%\sources\license\_default\eval\homebasicn
rd /s /q %ISOHOME%\sources\license\_default\eval\homepremium
rd /s /q %ISOHOME%\sources\license\_default\eval\homepremiume
rd /s /q %ISOHOME%\sources\license\_default\eval\homepremiumn
rd /s /q %ISOHOME%\sources\license\_default\eval\professionale
rd /s /q %ISOHOME%\sources\license\_default\eval\professionaln
rd /s /q %ISOHOME%\sources\license\_default\eval\starter
rd /s /q %ISOHOME%\sources\license\_default\eval\startere
rd /s /q %ISOHOME%\sources\license\_default\eval\startern
rd /s /q %ISOHOME%\sources\license\_default\eval\ultimatee
rd /s /q %ISOHOME%\sources\license\_default\eval\ultimaten
rd /s /q %ISOHOME%\sources\license\_default\oem\enterprisee
rd /s /q %ISOHOME%\sources\license\_default\oem\enterprisen
rd /s /q %ISOHOME%\sources\license\_default\oem\homebasic
rd /s /q %ISOHOME%\sources\license\_default\oem\homebasice
rd /s /q %ISOHOME%\sources\license\_default\oem\homebasicn
rd /s /q %ISOHOME%\sources\license\_default\oem\homepremium
rd /s /q %ISOHOME%\sources\license\_default\oem\homepremiume
rd /s /q %ISOHOME%\sources\license\_default\oem\homepremiumn
rd /s /q %ISOHOME%\sources\license\_default\oem\professionale
rd /s /q %ISOHOME%\sources\license\_default\oem\professionaln
rd /s /q %ISOHOME%\sources\license\_default\oem\starter
rd /s /q %ISOHOME%\sources\license\_default\oem\startere
rd /s /q %ISOHOME%\sources\license\_default\oem\startern
rd /s /q %ISOHOME%\sources\license\_default\oem\ultimatee
rd /s /q %ISOHOME%\sources\license\_default\oem\ultimaten
rd /s /q %ISOHOME%\sources\license\zh-cn\_default\enterprisee
rd /s /q %ISOHOME%\sources\license\zh-cn\_default\enterprisen
rd /s /q %ISOHOME%\sources\license\zh-cn\_default\homebasic
rd /s /q %ISOHOME%\sources\license\zh-cn\_default\homebasice
rd /s /q %ISOHOME%\sources\license\zh-cn\_default\homebasicn
rd /s /q %ISOHOME%\sources\license\zh-cn\_default\homepremium
rd /s /q %ISOHOME%\sources\license\zh-cn\_default\homepremiume
rd /s /q %ISOHOME%\sources\license\zh-cn\_default\homepremiumn
rd /s /q %ISOHOME%\sources\license\zh-cn\_default\professionale
rd /s /q %ISOHOME%\sources\license\zh-cn\_default\professionaln
rd /s /q %ISOHOME%\sources\license\zh-cn\_default\starter
rd /s /q %ISOHOME%\sources\license\zh-cn\_default\startere
rd /s /q %ISOHOME%\sources\license\zh-cn\_default\startern
rd /s /q %ISOHOME%\sources\license\zh-cn\_default\ultimatee
rd /s /q %ISOHOME%\sources\license\zh-cn\_default\ultimaten
rd /s /q %ISOHOME%\sources\license\zh-cn\eval\enterprisee
rd /s /q %ISOHOME%\sources\license\zh-cn\eval\enterprisen
rd /s /q %ISOHOME%\sources\license\zh-cn\eval\homebasic
rd /s /q %ISOHOME%\sources\license\zh-cn\eval\homebasice
rd /s /q %ISOHOME%\sources\license\zh-cn\eval\homebasicn
rd /s /q %ISOHOME%\sources\license\zh-cn\eval\homepremium
rd /s /q %ISOHOME%\sources\license\zh-cn\eval\homepremiume
rd /s /q %ISOHOME%\sources\license\zh-cn\eval\homepremiumn
rd /s /q %ISOHOME%\sources\license\zh-cn\eval\professionale
rd /s /q %ISOHOME%\sources\license\zh-cn\eval\professionaln
rd /s /q %ISOHOME%\sources\license\zh-cn\eval\starter
rd /s /q %ISOHOME%\sources\license\zh-cn\eval\startere
rd /s /q %ISOHOME%\sources\license\zh-cn\eval\startern
rd /s /q %ISOHOME%\sources\license\zh-cn\eval\ultimatee
rd /s /q %ISOHOME%\sources\license\zh-cn\eval\ultimaten
rd /s /q %ISOHOME%\sources\license\zh-cn\oem\enterprisee
rd /s /q %ISOHOME%\sources\license\zh-cn\oem\enterprisen
rd /s /q %ISOHOME%\sources\license\zh-cn\oem\homebasic
rd /s /q %ISOHOME%\sources\license\zh-cn\oem\homebasice
rd /s /q %ISOHOME%\sources\license\zh-cn\oem\homebasicn
rd /s /q %ISOHOME%\sources\license\zh-cn\oem\homepremium
rd /s /q %ISOHOME%\sources\license\zh-cn\oem\homepremiume
rd /s /q %ISOHOME%\sources\license\zh-cn\oem\homepremiumn
rd /s /q %ISOHOME%\sources\license\zh-cn\oem\professionale
rd /s /q %ISOHOME%\sources\license\zh-cn\oem\professionaln
rd /s /q %ISOHOME%\sources\license\zh-cn\oem\starter
rd /s /q %ISOHOME%\sources\license\zh-cn\oem\startere
rd /s /q %ISOHOME%\sources\license\zh-cn\oem\startern
rd /s /q %ISOHOME%\sources\license\zh-cn\oem\ultimatee
rd /s /q %ISOHOME%\sources\license\zh-cn\oem\ultimaten
del /f /q /a %ISOHOME%\sources\ei.cfg
del /f /q /a %ISOHOME%\boot\fonts\cht_boot.ttf
del /f /q /a %ISOHOME%\boot\fonts\jpn_boot.ttf
del /f /q /a %ISOHOME%\boot\fonts\kor_boot.ttf
del /f /q /a %ISOHOME%\efi\microsoft\boot\fonts\cht_boot.ttf
del /f /q /a %ISOHOME%\efi\microsoft\boot\fonts\jpn_boot.ttf
del /f /q /a %ISOHOME%\efi\microsoft\boot\fonts\kor_boot.ttf
IF EXIST "%ISOHOME%\sources\install_Windows 7 ULTIMATE.clg" (
    if "%WimIndexNo%"=="1" (
        del /f /q /a "%ISOHOME%\sources\install_Windows 7 HOMEPREMIUM.clg"
        del /f /q /a "%ISOHOME%\sources\install_Windows 7 PROFESSIONAL.clg"
        del /f /q /a "%ISOHOME%\sources\install_Windows 7 ULTIMATE.clg"
    )
    if "%WimIndexNo%"=="2" (
        del /f /q /a "%ISOHOME%\sources\install_Windows 7 HOMEBASIC.clg"
        del /f /q /a "%ISOHOME%\sources\install_Windows 7 PROFESSIONAL.clg"
        del /f /q /a "%ISOHOME%\sources\install_Windows 7 ULTIMATE.clg"
    )
    if "%WimIndexNo%"=="3" (
        del /f /q /a "%ISOHOME%\sources\install_Windows 7 HOMEBASIC.clg"
        del /f /q /a "%ISOHOME%\sources\install_Windows 7 HOMEPREMIUM.clg"
        del /f /q /a "%ISOHOME%\sources\install_Windows 7 ULTIMATE.clg"
    )
    if "%WimIndexNo%"=="4" (
        del /f /q /a "%ISOHOME%\sources\install_Windows 7 HOMEBASIC.clg"
        del /f /q /a "%ISOHOME%\sources\install_Windows 7 HOMEPREMIUM.clg"
        del /f /q /a "%ISOHOME%\sources\install_Windows 7 PROFESSIONAL.clg"
    )    
)
XCOPY "%APP_HOME%\Packs\ISOPrepare\normal\*.*"  "%ISOHOME%\" /y /s /e /h /q