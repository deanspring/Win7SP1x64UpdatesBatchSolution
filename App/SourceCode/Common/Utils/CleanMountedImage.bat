@ECHO off
mode con:cols=94 lines=42
SetLocal EnableDelayedExpansion
SET MountHome=%~1
::SET MountHome=%WimMountDir%\%WimIndexNo%
SET UserName=Administrator
::SET UserName=DeanMao
CALL :PrintMessage 0F "正在执行最后的清理工作,请稍后..."
CALL :%~2  >NUL 2>&1
GOTO :END
::-------------------------------------------------------------------------------------------------------------------
:CleanUpLevelOne
CALL :NeedTrustedInstallerLarge
CALL :NeedTrustedInstallerNormal
CALL :DoCleanFolderWithRule
CALL :CleanRetailMediaFile
CALL :DoDeleteFolder
CALL :DoCleanFolder
CALL :DoDelelteFiles
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:CleanUpLevelTwo
CALL :LiteThemes
CALL :LiteSidebar
CALL :LiteUserAccountPictures
CALL :CleanUselessMultilingual
CALL :CleanUselessMultilingualAdvanced
CALL :NeedTrustedInstaller
CALL :CleanMore
CALL :Clean3rd
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:END
ECHO 清理完毕!
mode con:cols=94 lines=42
GOTO :EOF
::===================================================================================================================
:TakeDirectoryOwnerShip
SET Target=%~1
TAKEOWN /F "%Target%"  >nul 2>&1
icacls "%Target%" /grant "Everyone":F  >nul 2>&1
icacls "%Target%" /grant "ALL APPLICATION PACKAGES":F  >nul 2>&1
icacls "%Target%" /grant "NT SERVICE\TrustedInstaller":F  >nul 2>&1
icacls "%Target%" /grant "System":F  >nul 2>&1
TAKEOWN /F "%Target%" /R /D Y  >nul 2>&1
icacls "%Target%" /grant "Everyone":F /t  >nul 2>&1
icacls "%Target%" /grant "ALL APPLICATION PACKAGES":F /t  >nul 2>&1
icacls "%Target%" /grant "NT SERVICE\TrustedInstaller":F /t  >nul 2>&1
icacls "%Target%" /grant "System":F /t  >nul 2>&1
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:NeedTrustedInstallerLarge
CALL :TakeDirectoryOwnerShip "!MountHome!\Windows\WinSxS\ManifestCache"
CALL :TakeDirectoryOwnerShip "!MountHome!\Windows\WinSxS\Temp\PendingRenames"
CALL :TakeDirectoryOwnerShip "!MountHome!\Windows\WinSxS\Temp"
del /f /s /q /a "!MountHome!\Windows\WinSxS\ManifestCache"
del /f /s /q /a "!MountHome!\Windows\WinSxS\Temp\PendingRenames"
del /f /s /q /a "!MountHome!\Windows\WinSxS\Temp"
rd /s /q "!MountHome!\Windows\WinSxS\Backup"
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:NeedTrustedInstallerNormal
CALL :TakeDirectoryOwnerShip "!MountHome!\Windows\WinSxS\poqexec.log"
CALL :TakeDirectoryOwnerShip "!MountHome!\System Volume Information"
CALL :TakeDirectoryOwnerShip "!MountHome!\Windows\System32\DriverStore\INFCACHE.1"
CALL :TakeDirectoryOwnerShip "!MountHome!\Windows\System32\DriverStore\FileRepository\*.PNF"
CALL :TakeDirectoryOwnerShip "!MountHome!\Windows\System32\LogFiles\WMI"
del /f /s /q /a "!MountHome!\Windows\WinSxS\poqexec.log"
del /f /s /q /a "!MountHome!\System Volume Information"
del /f /s /q /a "!MountHome!\Windows\System32\DriverStore\INFCACHE.1"
del /f /s /q /a "!MountHome!\Windows\System32\DriverStore\FileRepository\*.PNF"
del /f /s /q /a "!MountHome!\Windows\System32\LogFiles\WMI"
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:DoCleanFolderWithRule
CALL :CleanFolderWithRule "!MountHome!\Windows\assembly\NativeImages_v2.0.50727_32"
CALL :CleanFolderWithRule "!MountHome!\Windows\assembly\NativeImages_v2.0.50727_64"
CALL :CleanFolderWithRule "!MountHome!\Windows\assembly\NativeImages_v4.0.30319_32"
CALL :CleanFolderWithRule "!MountHome!\Windows\assembly\NativeImages_v4.0.30319_64"
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:CleanRetailMediaFile
rd /s /q "!MountHome!\Users\Public\Music\Sample Music"
rd /s /q "!MountHome!\Users\Public\Pictures\Sample Pictures"
rd /s /q "!MountHome!\Users\Public\Recorded TV\Sample Media"
rd /s /q "!MountHome!\Users\Public\Videos\Sample Videos"
rd /s /q "!MountHome!\Users\Public\Recorded TV"
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:DoDeleteFolder
rd /s /q "!MountHome!\Windows.old"
rd /s /q "!MountHome!\$RECYCLE.BIN"
rd /s /q "!MountHome!\$WINDOWS.~BT"
rd /s /q "!MountHome!\System Volume Information"
rd /s /q "!MountHome!\Config.msi"
rd /s /q "!MountHome!\Intel"
rd /s /q "!MountHome!\PerfLogs"
rd /s /q "!MountHome!\Program Files (x86)\Uninstall Information"
rd /s /q "!MountHome!\ProgramData\Microsoft\Windows Defender\Scans\CleanStore"
rd /s /q "!MountHome!\ProgramData\Microsoft\Windows\Start Menu\Programs\Tablet PC"
rd /s /q "!MountHome!\ProgramData\TEMP"
rd /s /q "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Windows\INetCookies\DNTException"
rd /s /q "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Windows\INetCookies\Low"
rd /s /q "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Windows\INetCookies\PrivacIE"
rd /s /q "!MountHome!\Users\!UserName!\AppData\Local\DBG"
rd /s /q "!MountHome!\Users\!UserName!\AppData\Local\winsys"
rd /s /q "!MountHome!\Users\!UserName!\AppData\Roaming\Adobe\Flash Player"
rd /s /q "!MountHome!\Users\!UserName!\AppData\Roaming\Macromedia"
rd /s /q "!MountHome!\Users\!UserName!\AppData\Roaming\Microsoft\Windows Photo Viewer"
rd /s /q "!MountHome!\Users\!UserName!\Favorites\Microsoft Websites"
rd /s /q "!MountHome!\Users\!UserName!\Favorites\Microsoft 网站"
rd /s /q "!MountHome!\Users\!UserName!\Favorites\MSN Websites"
rd /s /q "!MountHome!\Users\!UserName!\Favorites\MSN 网站"
rd /s /q "!MountHome!\Users\!UserName!\Favorites\Windows Live"
rd /s /q "!MountHome!\Windows\CSC"
rd /s /q "!MountHome!\Windows\Downloaded Installations"
rd /s /q "!MountHome!\Windows\Panther\setup.exe"
rd /s /q "!MountHome!\Windows\Panther\UnattendGC"
rd /s /q "!MountHome!\Windows\Prefetch"
rd /s /q "!MountHome!\Windows\SoftwareDistribution"
rd /s /q "!MountHome!\Windows\SoftwareDistribution\Download\SharedFileCache"
rd /s /q "!MountHome!\Windows\System32\LogFiles\AIT"
rd /s /q "!MountHome!\Windows\System32\LogFiles\Fax"
rd /s /q "!MountHome!\Windows\System32\LogFiles\Firewall"
rd /s /q "!MountHome!\Windows\System32\LogFiles\HTTPERR"
rd /s /q "!MountHome!\Windows\System32\LogFiles\SQM"
rd /s /q "!MountHome!\Windows\System32\LogFiles\Windows Portable Devices"
rd /s /q "!MountHome!\Windows\System32\LogFiles\WUDF"
rd /s /q "!MountHome!\Windows\System32\Tasks\Microsoft\Windows Defender"
rd /s /q "!MountHome!\Windows\SysWOW64\LogFiles\Windows Portable Devices"
rd /s /q "!MountHome!\Windows\LastGood.Tmp"
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:DoCleanFolder
::CALL :CleanFolder "!MountHome!\Windows\LastGood.Tmp"
CALL :CleanFolder "!MountHome!\ProgramData\Microsoft\Search\Data\Applications\Windows"
CALL :CleanFolder "!MountHome!\ProgramData\Microsoft\Windows Defender\Definition Updates"
CALL :CleanFolder "!MountHome!\ProgramData\Microsoft\Windows\WER"
CALL :CleanFolder "!MountHome!\ProgramData\Microsoft\Windows\RetailDemo"
CALL :CleanFolder "!MountHome!\Users\!UserName!\AppData\Local\Downloaded Installations"
CALL :CleanFolder "!MountHome!\Users\!UserName!\AppData\Local\ElevatedDiagnostics"
CALL :CleanFolder "!MountHome!\Users\!UserName!\AppData\Local\IsolatedStorage"
CALL :CleanFolder "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Feeds Cache"
CALL :CleanFolder "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Internet Explorer\DOMStore"
CALL :CleanFolder "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Internet Explorer\Recovery"
CALL :CleanFolder "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Media Player"
CALL :CleanFolder "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Windows\AppCache"
CALL :CleanFolder "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Windows\Explorer"
CALL :CleanFolder "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Windows\History"
CALL :CleanFolder "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Windows\INetCache"
CALL :CleanFolder "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Windows\Temporary Internet Files"
CALL :CleanFolder "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Windows\WER"
CALL :CleanFolder "!MountHome!\Users\!UserName!\AppData\Local\Temp"
CALL :CleanFolder "!MountHome!\Users\!UserName!\AppData\Roaming\Adobe\Flash Player\AssetCache"
CALL :CleanFolder "!MountHome!\Users\!UserName!\AppData\Roaming\Macromedia\Flash Player"
CALL :CleanFolder "!MountHome!\Users\!UserName!\AppData\Roaming\Microsoft\Internet Explorer\UserData"
CALL :CleanFolder "!MountHome!\Users\!UserName!\AppData\Roaming\Microsoft\Windows\Cookies"
CALL :CleanFolder "!MountHome!\Users\!UserName!\AppData\Roaming\Microsoft\Windows\Recent"
CALL :CleanFolder "!MountHome!\Users\Default\AppData\Local\Microsoft\Windows\Temporary Internet Files"
CALL :CleanFolder "!MountHome!\Users\Default\AppData\Local\Microsoft\Windows\WER"
CALL :CleanFolder "!MountHome!\Windows\AppCompat\Programs"
CALL :CleanFolder "!MountHome!\Windows\assembly\NativeImages_v2.0.50727_32\Temp"
CALL :CleanFolder "!MountHome!\Windows\assembly\NativeImages_v2.0.50727_64\Temp"
CALL :CleanFolder "!MountHome!\Windows\assembly\NativeImages_v4.0.30319_32\Temp"
CALL :CleanFolder "!MountHome!\Windows\assembly\NativeImages_v4.0.30319_64\Temp"
CALL :CleanFolder "!MountHome!\Windows\assembly\temp"
CALL :CleanFolder "!MountHome!\Windows\Debug"
CALL :CleanFolder "!MountHome!\Windows\Logs"
CALL :CleanFolder "!MountHome!\Windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\Windows\History"
CALL :CleanFolder "!MountHome!\Windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\Windows\Temporary Internet Files"
CALL :CleanFolder "!MountHome!\Windows\ServiceProfiles\LocalService\AppData\Local\Temp"
CALL :CleanFolder "!MountHome!\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\History"
CALL :CleanFolder "!MountHome!\Windows\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\Temporary Internet Files"
CALL :CleanFolder "!MountHome!\Windows\ServiceProfiles\NetworkService\AppData\Local\Temp"
CALL :CleanFolder "!MountHome!\Windows\System32\config\systemprofile\AppData\Local\Microsoft\Windows\Temporary Internet Files"
CALL :CleanFolder "!MountHome!\Windows\System32\config\systemprofile\AppData\Local\Microsoft\Windows\History"
CALL :CleanFolder "!MountHome!\Windows\System32\Sysprep\Panther"
CALL :CleanFolder "!MountHome!\Windows\SysWOW64\config\systemprofile\AppData\Local\Microsoft\Windows\History\History.IE5"
CALL :CleanFolder "!MountHome!\Windows\SysWOW64\config\systemprofile\AppData\Local\Microsoft\Windows\Temporary Internet Files"
CALL :CleanFolder "!MountHome!\Windows\SysWOW64\config\systemprofile\AppData\Roaming\Microsoft\Windows\Cookies"
CALL :CleanFolder "!MountHome!\Windows\Temp"
CALL :CleanFolder "!MountHome!\$RECYCLE.BIN"
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:DoDelelteFiles
del /f /q /a "!MountHome!\BOOTSECT.BAK"
del /f /q /a "!MountHome!\hiberfil.sys"
del /f /q /a "!MountHome!\pagefile.sys"
del /f /q /a "!MountHome!\$WINRE_BACKUP_PARTITION.MARKER"
del /f /q /a "!MountHome!\swapfile.sys"
del /f /q /a "!MountHome!\Windows\*.BAK"
del /f /q /a "!MountHome!\Windows\*.log"
del /f /q /a "!MountHome!\Windows\*.txt"
del /f /q /a "!MountHome!\Windows\bootstat.dat"
del /f /q /a "!MountHome!\Windows\inf\*.PNF"
del /f /q /a "!MountHome!\Windows\System32\*.log"
del /f /q /a "!MountHome!\Windows\SysWOW64\*.log"
del /f /q /a "!MountHome!\Windows\SysWOW64\nativetmp.dat"
del /f /q /a "!MountHome!\Users\!UserName!\AppData\Local\Microsoft Games\FreeCell\FreeCellSettings.xml"
del /f /q /a "!MountHome!\Users\!UserName!\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\Shows Desktop.lnk"
del /f /q /a "!MountHome!\Users\!UserName!\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\Window Switcher.lnk"
del /f /s /q /a "!MountHome!\*.cache"
del /f /s /q /a "!MountHome!\*.chk"
del /f /s /q /a "!MountHome!\*.cookie"
del /f /s /q /a "!MountHome!\*.dmp"
del /f /s /q /a "!MountHome!\*.etl"
del /f /s /q /a "!MountHome!\*.etl.*"
del /f /s /q /a "!MountHome!\*.gid"
del /f /s /q /a "!MountHome!\*.jrs"
del /f /s /q /a "!MountHome!\*.old"
del /f /s /q /a "!MountHome!\*.tmp"
del /f /s /q /a "!MountHome!\*.tbres"
del /f /s /q /a "!MountHome!\container.dat"
del /f /s /q /a "!MountHome!\counters.dat"
del /f /s /q /a "!MountHome!\edb*.log"
del /f /s /q /a "!MountHome!\Ci*T0000.*"
del /f /s /q /a "!MountHome!\ProgramData\*.log"
del /f /s /q /a "!MountHome!\ProgramData\*.log.gz"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\Diagnosis\events*.rbs"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\Network\Downloader"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\Vault\*.vcrd"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\Windows Defender\Scans\MpDiag.bin"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\Windows Defender\Scans\History\CacheManager"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\Windows Defender\Scans\History\Results\Quick"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\Windows Defender\Scans\History\Results\Resource"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\Windows Defender\Scans\History\Service"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\Windows Defender\Scans\mpcache*"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\Windows Defender\Scans\Scans\History\CacheManager"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\Windows Defender\Support"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\Windows Defender\Network Inspection System\Support\NisLog.txt"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\Windows\Caches"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\Windows\Power Efficiency Diagnostics"
del /f /s /q /a "!MountHome!\Program Files (x86)\InstallShield Installation Information\*.log"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\LocalLow\Microsoft\CryptnetUrlCache"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Local\*.log"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Local\GDIPFONTCACHEV1.DAT"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Local\IconCache.db"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\*.log"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Feeds\Microsoft Feeds~"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Feeds\{5588ACFD-6436-411B-A5CE-666AE6A92D3D}~\WebSlices~"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Internet Explorer\*.log"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Internet Explorer\brndlog*"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Internet Explorer\frameiconcache.dat"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Internet Explorer\Recovery\High\*.dat"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Internet Explorer\Recovery\Last Active\*.dat"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Windows Mail\edb*"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Windows\*.jrs"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Windows\*.log"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Windows\ActionCenterCache"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Windows\Burn"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Windows\Caches"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Windows\History\desktop.ini"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Windows\INetCookies"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Windows\WebCache"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Windows\Notifications\wpnidm"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Roaming\Adobe\Flash Player\NativeCache"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Roaming\Microsoft\HTML Help\hh.dat"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Roaming\Microsoft\IETldCache\index.dat"
del /f /s /q /a "!MountHome!\Users\!UserName!\Favorites\Links\Web Slice Gallery.url"
del /f /s /q /a "!MountHome!\Users\!UserName!\Searches\*.search-ms"
del /f /s /q /a "!MountHome!\Users\Default User\AppData\Local\Microsoft\Windows\Explorer"
del /f /s /q /a "!MountHome!\Users\Default User\AppData\Local\Temp"
del /f /s /q /a "!MountHome!\Users\Default\NTUSER.DAT{*.regtrans-ms"
del /f /s /q /a "!MountHome!\Windows\Downloaded Program Files"
del /f /s /q /a "!MountHome!\Windows\inf\*.log"
del /f /s /q /a "!MountHome!\Windows\inf\*.tmp"
del /f /s /q /a "!MountHome!\Windows\inf\setupapi.ev*"
del /f /s /q /a "!MountHome!\Windows\Installer\SourceHash*"
del /f /s /q /a "!MountHome!\Windows\Microsoft.NET\*.log"
del /f /s /q /a "!MountHome!\Windows\Microsoft.NET\*.txt"
del /f /s /q /a "!MountHome!\Windows\Panther\*.dir"
del /f /s /q /a "!MountHome!\Windows\Panther\*.log"
del /f /s /q /a "!MountHome!\Windows\Panther\*.que"
del /f /s /q /a "!MountHome!\Windows\Panther\diag*.xml"
del /f /s /q /a "!MountHome!\Windows\Performance\WinSAT\*.log"
del /f /s /q /a "!MountHome!\Windows\Performance\WinSAT\DataStore"
del /f /s /q /a "!MountHome!\Windows\security\logs"
del /f /s /q /a "!MountHome!\Windows\ServiceProfiles\LocalService\AppData\LocalLow\Microsoft\CryptnetUrlCache"
del /f /s /q /a "!MountHome!\Windows\ServiceProfiles\LocalService\AppData\Local\*.log"
del /f /s /q /a "!MountHome!\Windows\ServiceProfiles\LocalService\AppData\Local\*FontCache*"
del /f /s /q /a "!MountHome!\Windows\ServiceProfiles\LocalService\AppData\Local\Microsoft\Windows\WindowsUpdate.log"
del /f /s /q /a "!MountHome!\Windows\ServiceProfiles\LocalService\AppData\Roaming\Microsoft\Windows\Cookies"
del /f /s /q /a "!MountHome!\Windows\ServiceProfiles\NetworkService\AppData\Roaming\Microsoft\Windows\Cookies"
del /f /s /q /a "!MountHome!\Windows\ServiceProfiles\NetworkService\AppData\Roaming\Microsoft\Windows\IETldCache"
del /f /s /q /a "!MountHome!\Windows\ServiceProfiles\NetworkService\AppData\LocalLow\Microsoft\CryptnetUrlCache"
del /f /s /q /a "!MountHome!\Windows\ServiceProfiles\NetworkService\debug"
del /f /s /q /a "!MountHome!\Windows\SoftwareDistribution\DataStore\Logs"
del /f /s /q /a "!MountHome!\Windows\System32\catroot2\*.txt"
del /f /s /q /a "!MountHome!\Windows\System32\catroot2\edb*"
del /f /s /q /a "!MountHome!\Windows\System32\spool\drivers\*.txt"
del /f /s /q /a "!MountHome!\Windows\System32\config\systemprofile\AppData\LocalLow\Microsoft\CryptnetUrlCache"
del /f /s /q /a "!MountHome!\Windows\System32\config\systemprofile\AppData\Local\Microsoft\*.log"
del /f /s /q /a "!MountHome!\Windows\System32\config\systemprofile\AppData\Roaming\Microsoft\Windows\Cookies"
del /f /s /q /a "!MountHome!\Windows\System32\config\systemprofile\AppData\Roaming\Microsoft\Windows\IETldCache"
del /f /s /q /a "!MountHome!\Windows\System32\FNTCACHE.DAT"
del /f /s /q /a "!MountHome!\Windows\System32\LogFiles\Scm"
del /f /s /q /a "!MountHome!\Windows\System32\LogFiles\WMI\RtBackup\*.etl"
del /f /s /q /a "!MountHome!\Windows\System32\Macromed\Flash\FlashInstall.log"
del /f /s /q /a "!MountHome!\Windows\System32\Msdtc\MSDTC.LOG"
del /f /s /q /a "!MountHome!\Windows\System32\NetworkList\Icons\{*.bin"
del /f /s /q /a "!MountHome!\Windows\System32\sru"
del /f /s /q /a "!MountHome!\Windows\System32\sysprep\Sysprep_succeeded.tag"
del /f /s /q /a "!MountHome!\Windows\System32\Tasks\Microsoft\Windows\UpdateOrchestrator\Schedule Retry Scan"
del /f /s /q /a "!MountHome!\Windows\System32\wbem\AutoRecover"
del /f /s /q /a "!MountHome!\Windows\System32\wfp"
del /f /s /q /a "!MountHome!\Windows\System32\winevt\Logs"
del /f /s /q /a "!MountHome!\Windows\SysWOW64\config\systemprofile\AppData\Local\Microsoft\*.log"
del /f /s /q /a "!MountHome!\Windows\SysWOW64\config\systemprofile\AppData\LocalLow\Microsoft\CryptnetUrlCache"
del /f /s /q /a "!MountHome!\Windows\SysWOW64\config\systemprofile\AppData\Roaming\Microsoft\Windows\Cookies"
del /f /s /q /a "!MountHome!\Windows\SysWOW64\Macromed\Flash\FlashInstall.log"
del /f /s /q /a "!MountHome!\Windows\Tasks\Microsoft\Windows Defender\MpIdleTask"
del /f /s /q /a "!MountHome!\Windows\Tasks\SCHEDLGU.TXT"
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:LiteThemes
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\Windows\Ringtones\Ringtone 01.wma"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\Windows\Ringtones\Ringtone 02.wma"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\Windows\Ringtones\Ringtone 03.wma"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\Windows\Ringtones\Ringtone 04.wma"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\Windows\Ringtones\Ringtone 05.wma"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\Windows\Ringtones\Ringtone 06.wma"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\Windows\Ringtones\Ringtone 07.wma"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\Windows\Ringtones\Ringtone 08.wma"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\Windows\Ringtones\Ringtone 09.wma"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\Windows\Ringtones\Ringtone 10.wma"
del /f /s /q /a "!MountHome!\Windows\Resources\Ease of Access Themes\hc1.theme"
del /f /s /q /a "!MountHome!\Windows\Resources\Ease of Access Themes\hc2.theme"
del /f /s /q /a "!MountHome!\Windows\Resources\Ease of Access Themes\hcblack.theme"
del /f /s /q /a "!MountHome!\Windows\Resources\Ease of Access Themes\hcwhite.theme"
del /f /s /q /a "!MountHome!\Windows\Resources\Themes\architecture.theme"
del /f /s /q /a "!MountHome!\Windows\Resources\Themes\characters.theme"
del /f /s /q /a "!MountHome!\Windows\Resources\Themes\landscapes.theme"
del /f /s /q /a "!MountHome!\Windows\Resources\Themes\nature.theme"
del /f /s /q /a "!MountHome!\Windows\Resources\Themes\scenes.theme"
rd /s /q "!MountHome!\Windows\Web\Wallpaper\Architecture"
rd /s /q "!MountHome!\Windows\Web\Wallpaper\Characters"
rd /s /q "!MountHome!\Windows\Web\Wallpaper\Landscapes"
rd /s /q "!MountHome!\Windows\Web\Wallpaper\Nature"
rd /s /q "!MountHome!\Windows\Web\Wallpaper\Scenes"
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:LiteSidebar
rd /s /q "!MountHome!\Program Files\Windows Sidebar\Gadgets\Currency.Gadget"
rd /s /q "!MountHome!\Program Files\Windows Sidebar\Gadgets\MediaCenter.Gadget"
rd /s /q "!MountHome!\Program Files\Windows Sidebar\Gadgets\PicturePuzzle.Gadget"
rd /s /q "!MountHome!\Program Files\Windows Sidebar\Gadgets\RSSFeeds.Gadget"
rd /s /q "!MountHome!\Program Files\Windows Sidebar\Gadgets\SlideShow.Gadget"
rd /s /q "!MountHome!\Program Files\Windows Sidebar\Gadgets\Weather.Gadget"
rd /s /q "!MountHome!\Program Files (x86)\Windows Sidebar\Gadgets\Currency.Gadget"
rd /s /q "!MountHome!\Program Files (x86)\Windows Sidebar\Gadgets\PicturePuzzle.Gadget"
rd /s /q "!MountHome!\Program Files (x86)\Windows Sidebar\Gadgets\RSSFeeds.Gadget"
rd /s /q "!MountHome!\Program Files (x86)\Windows Sidebar\Gadgets\SlideShow.Gadget"
rd /s /q "!MountHome!\Program Files (x86)\Windows Sidebar\Gadgets\Weather.Gadget"
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:LiteUserAccountPictures
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile10.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile13.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile16.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile19.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile20.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile22.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile23.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile24.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile25.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile26.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile27.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile28.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile29.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile30.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile31.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile32.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile33.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile34.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile35.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile36.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile37.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile38.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile39.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile40.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile41.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile42.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile43.bmp"
del /f /s /q /a "!MountHome!\ProgramData\Microsoft\User Account Pictures\Default Pictures\usertile44.bmp"
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:CleanUselessMultilingual
del /f /s /q /a "!MountHome!\Windows\Boot\Fonts\jpn_boot.ttf"
del /f /s /q /a "!MountHome!\Windows\Boot\Fonts\kor_boot.ttf"
del /f /s /q /a "!MountHome!\Windows\Boot\Fonts\cht_boot.ttf"
rd /s /q "!MountHome!\Windows\Boot\EFI\cs-CZ"
rd /s /q "!MountHome!\Windows\Boot\EFI\da-DK"
rd /s /q "!MountHome!\Windows\Boot\EFI\de-DE"
rd /s /q "!MountHome!\Windows\Boot\EFI\el-GR"
rd /s /q "!MountHome!\Windows\Boot\EFI\es-ES"
rd /s /q "!MountHome!\Windows\Boot\EFI\fi-FI"
rd /s /q "!MountHome!\Windows\Boot\EFI\fr-FR"
rd /s /q "!MountHome!\Windows\Boot\EFI\hu-HU"
rd /s /q "!MountHome!\Windows\Boot\EFI\it-IT"
rd /s /q "!MountHome!\Windows\Boot\EFI\ja-JP"
rd /s /q "!MountHome!\Windows\Boot\EFI\ko-KR"
rd /s /q "!MountHome!\Windows\Boot\EFI\nb-NO"
rd /s /q "!MountHome!\Windows\Boot\EFI\nl-NL"
rd /s /q "!MountHome!\Windows\Boot\EFI\pl-PL"
rd /s /q "!MountHome!\Windows\Boot\EFI\pt-BR"
rd /s /q "!MountHome!\Windows\Boot\EFI\pt-PT"
rd /s /q "!MountHome!\Windows\Boot\EFI\ru-RU"
rd /s /q "!MountHome!\Windows\Boot\EFI\sv-SE"
rd /s /q "!MountHome!\Windows\Boot\EFI\tr-TR"
rd /s /q "!MountHome!\Windows\Boot\PCAT\cs-CZ"
rd /s /q "!MountHome!\Windows\Boot\PCAT\da-DK"
rd /s /q "!MountHome!\Windows\Boot\PCAT\de-DE"
rd /s /q "!MountHome!\Windows\Boot\PCAT\el-GR"
rd /s /q "!MountHome!\Windows\Boot\PCAT\es-ES"
rd /s /q "!MountHome!\Windows\Boot\PCAT\fi-FI"
rd /s /q "!MountHome!\Windows\Boot\PCAT\fr-FR"
rd /s /q "!MountHome!\Windows\Boot\PCAT\hu-HU"
rd /s /q "!MountHome!\Windows\Boot\PCAT\it-IT"
rd /s /q "!MountHome!\Windows\Boot\PCAT\ja-JP"
rd /s /q "!MountHome!\Windows\Boot\PCAT\ko-KR"
rd /s /q "!MountHome!\Windows\Boot\PCAT\nb-NO"
rd /s /q "!MountHome!\Windows\Boot\PCAT\nl-NL"
rd /s /q "!MountHome!\Windows\Boot\PCAT\pl-PL"
rd /s /q "!MountHome!\Windows\Boot\PCAT\pt-BR"
rd /s /q "!MountHome!\Windows\Boot\PCAT\pt-PT"
rd /s /q "!MountHome!\Windows\Boot\PCAT\ru-RU"
rd /s /q "!MountHome!\Windows\Boot\PCAT\sv-SE"
rd /s /q "!MountHome!\Windows\Boot\PCAT\tr-TR"
rd /s /q "%MountHome%\Windows\Boot\EFI\zh-TW"
rd /s /q "%MountHome%\Windows\Boot\EFI\zh-HK"
rd /s /q "%MountHome%\Windows\Boot\PCAT\zh-TW"
rd /s /q "%MountHome%\Windows\Boot\PCAT\zh-HK"
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:CleanUselessMultilingualAdvanced
rd /s /q "!MountHome!\Windows\System32\ar-SA"
rd /s /q "!MountHome!\Windows\System32\bg-BG"
rd /s /q "!MountHome!\Windows\System32\cs-CZ"
rd /s /q "!MountHome!\Windows\System32\da-DK"
rd /s /q "!MountHome!\Windows\System32\de-DE"
rd /s /q "!MountHome!\Windows\System32\el-GR"
rd /s /q "!MountHome!\Windows\System32\es-ES"
rd /s /q "!MountHome!\Windows\System32\et-EE"
rd /s /q "!MountHome!\Windows\System32\fi-FI"
rd /s /q "!MountHome!\Windows\System32\fr-FR"
rd /s /q "!MountHome!\Windows\System32\he-IL"
rd /s /q "!MountHome!\Windows\System32\hr-HR"
rd /s /q "!MountHome!\Windows\System32\hu-HU"
rd /s /q "!MountHome!\Windows\System32\it-IT"
rd /s /q "!MountHome!\Windows\System32\ja-JP"
rd /s /q "!MountHome!\Windows\System32\ko-KR"
rd /s /q "!MountHome!\Windows\System32\lt-LT"
rd /s /q "!MountHome!\Windows\System32\lv-LV"
rd /s /q "!MountHome!\Windows\System32\nb-NO"
rd /s /q "!MountHome!\Windows\System32\nl-NL"
rd /s /q "!MountHome!\Windows\System32\pl-PL"
rd /s /q "!MountHome!\Windows\System32\pt-BR"
rd /s /q "!MountHome!\Windows\System32\pt-PT"
rd /s /q "!MountHome!\Windows\System32\ro-RO"
rd /s /q "!MountHome!\Windows\System32\ru-RU"
rd /s /q "!MountHome!\Windows\System32\sk-SK"
rd /s /q "!MountHome!\Windows\System32\sl-SI"
rd /s /q "!MountHome!\Windows\System32\sr-Latn-CS"
rd /s /q "!MountHome!\Windows\System32\sv-SE"
rd /s /q "!MountHome!\Windows\System32\th-TH"
rd /s /q "!MountHome!\Windows\System32\tr-TR"
rd /s /q "!MountHome!\Windows\System32\uk-UA"
rd /s /q "!MountHome!\Windows\SysWOW64\ar-SA"
rd /s /q "!MountHome!\Windows\SysWOW64\bg-BG"
rd /s /q "!MountHome!\Windows\SysWOW64\cs-CZ"
rd /s /q "!MountHome!\Windows\SysWOW64\da-DK"
rd /s /q "!MountHome!\Windows\SysWOW64\de-DE"
rd /s /q "!MountHome!\Windows\SysWOW64\el-GR"
rd /s /q "!MountHome!\Windows\SysWOW64\es-ES"
rd /s /q "!MountHome!\Windows\SysWOW64\et-EE"
rd /s /q "!MountHome!\Windows\SysWOW64\fi-FI"
rd /s /q "!MountHome!\Windows\SysWOW64\fr-FR"
rd /s /q "!MountHome!\Windows\SysWOW64\he-IL"
rd /s /q "!MountHome!\Windows\SysWOW64\hr-HR"
rd /s /q "!MountHome!\Windows\SysWOW64\hu-HU"
rd /s /q "!MountHome!\Windows\SysWOW64\it-IT"
rd /s /q "!MountHome!\Windows\SysWOW64\ja-JP"
rd /s /q "!MountHome!\Windows\SysWOW64\ko-KR"
rd /s /q "!MountHome!\Windows\SysWOW64\lt-LT"
rd /s /q "!MountHome!\Windows\SysWOW64\lv-LV"
rd /s /q "!MountHome!\Windows\SysWOW64\nb-NO"
rd /s /q "!MountHome!\Windows\SysWOW64\nl-NL"
rd /s /q "!MountHome!\Windows\SysWOW64\pl-PL"
rd /s /q "!MountHome!\Windows\SysWOW64\pt-BR"
rd /s /q "!MountHome!\Windows\SysWOW64\pt-PT"
rd /s /q "!MountHome!\Windows\SysWOW64\ro-RO"
rd /s /q "!MountHome!\Windows\SysWOW64\ru-RU"
rd /s /q "!MountHome!\Windows\SysWOW64\sk-SK"
rd /s /q "!MountHome!\Windows\SysWOW64\sl-SI"
rd /s /q "!MountHome!\Windows\SysWOW64\sr-Latn-CS"
rd /s /q "!MountHome!\Windows\SysWOW64\sv-SE"
rd /s /q "!MountHome!\Windows\SysWOW64\th-TH"
rd /s /q "!MountHome!\Windows\SysWOW64\tr-TR"
rd /s /q "!MountHome!\Windows\SysWOW64\uk-UA"
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:NeedTrustedInstaller
del /f /s /q /a "!MountHome!\Windows\WinSxS\amd64_microsoft-windows-ehome-samplemedia_31bf3856ad364e35_6.1.7600.16385_none_b6b9b223710b3802"
del /f /s /q /a "!MountHome!\Windows\WinSxS\amd64_microsoft-windows-musicsamples_31bf3856ad364e35_6.1.7600.16385_none_06495209cbd8e93b"
del /f /s /q /a "!MountHome!\Windows\WinSxS\amd64_microsoft-windows-photosamples_31bf3856ad364e35_6.1.7600.16385_none_f36e0e659b8042be"
del /f /s /q /a "!MountHome!\Windows\WinSxS\amd64_microsoft-windows-videosamples_31bf3856ad364e35_6.1.7600.16385_none_51a21f033003affd"
del /f /s /q /a "!MountHome!\Windows\WinSxS\amd64_microsoft-windows-winsatmediasamples_31bf3856ad364e35_6.1.7600.16385_none_0b34d0642122c1c4"
del /f /s /q /a "!MountHome!\Windows\Performance\WinSAT\ShaderCache*"
CALL :CleanFolder "!MountHome!\Windows\System32\WDI"
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:CleanMore
del /f /s /q /a "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\FlickAnimation.avi"
del /f /s /q /a "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\en-US\*.avi"
del /f /s /q /a "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\ipscat.xml"
del /f /s /q /a "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\ipscsy.xml"
del /f /s /q /a "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\ipsdan.xml"
del /f /s /q /a "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\ipsdeu.xml"
del /f /s /q /a "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\ipsesp.xml"
del /f /s /q /a "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\ipsfin.xml"
del /f /s /q /a "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\ipsfra.xml"
del /f /s /q /a "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\ipshrv.xml"
del /f /s /q /a "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\ipsita.xml"
del /f /s /q /a "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\ipsnld.xml"
del /f /s /q /a "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\ipsnor.xml"
del /f /s /q /a "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\ipsplk.xml"
del /f /s /q /a "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\ipsptb.xml"
del /f /s /q /a "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\ipsptg.xml"
del /f /s /q /a "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\ipsrom.xml"
del /f /s /q /a "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\ipsrus.xml"
del /f /s /q /a "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\ipssrb.xml"
del /f /s /q /a "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\ipssrl.xml"
del /f /s /q /a "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\ipssve.xml"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\ar-SA"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\bg-BG"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\cs-CZ"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\da-DK"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\de-DE"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\el-GR"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\es-ES"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\et-EE"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\fi-FI"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\fr-FR"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\he-IL"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\hr-HR"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\hu-HU"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\it-IT"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\lt-LT"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\lv-LV"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\nb-NO"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\nl-NL"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\pl-PL"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\pt-BR"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\pt-PT"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\ro-RO"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\ru-RU"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\sk-SK"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\sl-SI"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\sr-Latn-CS"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\sv-SE"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\th-TH"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\tr-TR"
rd /s /q "!MountHome!\Program Files\Common Files\Microsoft Shared\ink\uk-UA"
rd /s /q "%MountHome%\Program Files\Common Files\Microsoft Shared\ink\ja-JP"
rd /s /q "%MountHome%\Program Files\Common Files\Microsoft Shared\ink\ko-KR"
rd /s /q "%MountHome%\Program Files\Common Files\Microsoft Shared\ink\zh-TW"
rd /s /q "%MountHome%\Program Files\Common Files\Microsoft Shared\ink\zh-HK"
SET str=!MountHome!\Windows\Help
del /f /s /q /a "%str%\*.*" 
FOR /F "tokens=* delims=" %%i in ('dir /ad /s /b "%str%"^|sort /r') DO (
   rd "%%i" 2>nul &&ECHO %%i deleted!
)
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:Clean3rd
CALL :CleanFolder !MountHome!\Users\!UserName!\AppData\Roaming\Tencent\QQ\Temp"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Roaming\BaiduYunGuanjia\logs\"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Roaming\IDM\foldresHistory.txt"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Roaming\IDM\UrlHistory.txt"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Roaming\IDM\*.log"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Roaming\DAEMON Tools Lite\ImageCatalog.xml"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Roaming\TeamViewer\Connections.txt"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Roaming\TeamViewer\MRU\RemoteSupport\*.tvc"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Roaming\TeamViewer\*.log"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Local\VMware\*.log"
del /f /s /q /a "!MountHome!\Program Files (x86)\VMware\VMware VIX\open_source_licenses.txt"
del /f /s /q /a "!MountHome!\Program Files (x86)\VMware\VMware VIX\eula.rtf"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Roaming\Microsoft\Templates\欢迎使用 Word.dotx"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Roaming\Microsoft\Document Building Blocks\2052\16\Built-In Building Blocks.dotx"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Roaming\Microsoft\Office\Recent\"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Office\16.0\WebServiceCache\AllUsers\clienttemplates.content.office.net\"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Local\Microsoft\Office\16.0\WebServiceCache\AllUsers\officeclient.microsoft.com\"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Roaming\FileZilla\recentservers.xml"
del /f /s /q /a "!MountHome!\ProgramData\Apple\Installer Cache\Apple Mobile Device Support 10.0.1.3\AppleMobileDeviceSupport6464.msi"
del /f /s /q /a "!MountHome!\ProgramData\Apple\Installer Cache\Apple Software Update 2.2.0.150\AppleSoftwareUpdate.msi"
del /f /s /q /a "!MountHome!\ProgramData\Apple\Installer Cache\AppleApplicationSupport 5.2\AppleApplicationSupport.msi"
del /f /s /q /a "!MountHome!\ProgramData\Apple\Installer Cache\AppleApplicationSupport64 5.2\AppleApplicationSupport64.msi"
del /f /s /q /a "!MountHome!\ProgramData\Apple\Installer Cache\Bonjour 3.1.0.1\Bonjour64.msi"
del /f /s /q /a "!MountHome!\ProgramData\Apple Computer\Installer Cache\iTunes 12.5.4.42\iTunes6464.msi"
del /f /s /q /a "!MountHome!\ProgramData\Apple Computer\Installer Cache\iTunes 12.5.4.42\SetupAdmin.exe"
del /f /s /q /a "!MountHome!\ProgramData\mntemp"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Local\Apple Computer\iTunes\Cache.db"
del /f /s /q /a "!MountHome!\Windows\System32\config\systemprofile\AppData\Roaming\Apple Computer\Logs\"
rd /s /q "!MountHome!\Users\!UserName!\AppData\LocalLow\Oracle\Java"
rd /s /q "!MountHome!\Users\!UserName!\AppData\Roaming\IDM\DwnlData\!UserName!"
rd /s /q "!MountHome!\ProgramData\Martau"
CALL :CleanFolder "!MountHome!\Users\!UserName!\AppData\Roaming\Apple Computer\Logs"
CALL :CleanFolder "!MountHome!\Users\!UserName!\AppData\Roaming\Tencent\Logs"
del /f /s /q /a "!MountHome!\Users\!UserName!\AppData\Roaming\Scooter Software\Beyond Compare 4\*.bak"
GOTO :EOF
::===================================================================================================================
:CleanFolderWithRule
SET "url=%~1"
PUSHD "!url!"
::需要保留的目录的文件夹名
SET ReserveD="temp"
::需要保留的文件名样式
SET ReserveF="index*.dat;"
::处理豁免列表
FOR /F "delims=" %%a in (!ReserveD!) DO (
SET "ReserveD=%%~a"
SET "ReserveD="!ReserveD:;=" "!""
)
FOR /F "delims=" %%a in (!ReserveF!) do SET "ReserveF=%%~a"
::删除文件夹
(
FOR /F "delims=" %%i in ('dir /ad /s /b "%url%"') DO (
    SET temp_a=0
    for %%j in (!ReserveD!) DO (if /i "%%~nxi"=="%%~j" SET temp_a=1)
    if !temp_a!==0 rd "%%i" /s /q
)
::以下是删除文件
del /q "%~dp0temp2.db" && del /q "%~dp0temp.db"
FOR /F "delims=" %%i in ('dir /a-d /b "%url%"') do ECHO.%%i>>"%~dp0temp2.db"
)>nul 2>nul
SET "temp_c=!ReserveF!"
:LableA
(
FOR /F "tokens=1,* delims=;" %%a in ("!temp_c!") DO (
if not "%%~a"=="" (
FOR /F "delims=" %%c in ('dir /ah  /b "%%~a"') DO (ECHO.%%c>>"%~dp0temp.db")
FOR /F "delims=" %%c in ('dir /a-h /b "%%~a"') DO (ECHO.%%c>>"%~dp0temp.db")
)
SET "temp_c=%%~b"
if "!temp_c!"=="" GOTO :LableB
)
)>nul 2>nul
GOTO :LableA
:LableB
(
FOR /F "usebackq delims=" %%a in ("%~dp0temp2.db") DO (
    SET temp_a=0
    FOR /F "usebackq delims=" %%b in ("%~dp0temp.db") DO (if "%%~a"=="%%~b" SET temp_a=1)
    if "!temp_a!"=="0" del /f /q "%%~fa" && del /f /q "%%~fa" /ah
)
del /q "%~dp0temp2.db" && del /q "%~dp0temp.db"
)>nul 2>nul
ECHO.完成
GOTO :EOF
::-------------------------------------------------------------------------------------------------------------------
:CleanFolder
SET "url=%~1"
PowerShell -Command "&{Remove-Item '!url!\*' -Force -Recurse}">NUL 2>&1
ECHO 清理目录: !url!
GOTO :EOF
::===================================================================================================================
:PrintMessage
Color %~1
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO  ============================================================================================
ECHO.
ECHO.
ECHO.
ECHO.
ECHO                                 %~2...
ECHO.
ECHO.
ECHO.
ECHO.
ECHO  ============================================================================================
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
GOTO :EOF
::===================================================================================================================