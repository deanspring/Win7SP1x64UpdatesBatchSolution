@echo off
cd /d "%~dp0"
set installs=0
set count=0

reg query "hklm\software\microsoft\Windows NT\currentversion" /v buildlabex >"%temp%\os.txt"
find /i "AMD64" <"%temp%\os.txt">nul
if %errorlevel% equ 0 (set arch=x64) else (set arch=x86)
for /f "tokens=3* delims= " %%G in ('reg query "hklm\software\microsoft\Windows NT\currentversion" /v productname') do (set winv=%%G %%H)
echo %winv%|find /i "Windows 10" >nul
if errorlevel 0 (set w10=1&for /f "tokens=3" %%G in ('reg query "hklm\software\microsoft\Windows NT\currentversion" /v UBR') do (set /a UBR=%%G))
if defined w10 (for /f "skip=2 tokens=3,4,6,7 delims=. " %%G in ('type "%temp%\os.txt"') do (set "win=%winv% %arch% Build %%G.%UBR% {%%I %%J}")
) else (
for /f "skip=2 tokens=3,4,6,7 delims=. " %%G in ('type "%temp%\os.txt"') do (set "win=%winv% %arch% Build %%G.%%H {%%I %%J}")
)
del "%temp%\os.txt"

if %arch% equ x64 (for /f %%G in ('type "redists_x64.txt"') do (set /a installs+=1))
for /f %%G in ('type "redists_x86.txt"') do (set /a installs+=1)
if defined auto goto :proceed

:top
call :title
:proceed
if exist "%temp%\list.txt" (del "%temp%\list.txt")
if exist "%temp%\list2.txt" (del "%temp%\list2.txt")
if %arch% neq x64 goto :x64skip
call :title
echo.
echo                            卸载已安装的 Visual C++ x86 运行库
echo.
echo                               这个过程需要一段时间,请稍后...
reg query hklm\software\wow6432node\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2012 Redistributable" /s >>"%temp%\list2.txt"
reg query hklm\software\wow6432node\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2013 Preview Redistributable" /s >>"%temp%\list2.txt"
reg query hklm\software\wow6432node\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2013 RC Redistributable" /s >>"%temp%\list2.txt"
reg query hklm\software\wow6432node\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2013 Redistributable" /s >>"%temp%\list2.txt"
reg query hklm\software\wow6432node\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 14 CTP Redistributable" /s >>"%temp%\list2.txt"
reg query hklm\software\wow6432node\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2015 Preview Redistributable" /s >>"%temp%\list2.txt"
reg query hklm\software\wow6432node\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2015 CTP Redistributable" /s >>"%temp%\list2.txt"
reg query hklm\software\wow6432node\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2015 RC Redistributable" /s >>"%temp%\list2.txt"
reg query hklm\software\wow6432node\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2015 Redistributable" /s >>"%temp%\list2.txt"
reg query hklm\software\wow6432node\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2017 RC Redistributable" /s >>"%temp%\list2.txt"
reg query hklm\software\wow6432node\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2017 Redistributable" /s >>"%temp%\list2.txt"
if exist "%temp%\list2.txt" (for /f "delims=\ tokens=8" %%a in ('type "%temp%\list2.txt"') do (if exist "C:\ProgramData\Package Cache\%%a\vcredist_x86.exe" ("C:\ProgramData\Package Cache\%%a\vcredist_x86.exe" /uninstall /norestart /quiet) else (if exist "C:\ProgramData\Package Cache\%%a\vcredist_x64.exe" ("C:\ProgramData\Package Cache\%%a\vcredist_x64.exe" /uninstall /norestart /quiet))))
if exist "%temp%\list2.txt" (for /f "delims=\ tokens=8" %%a in ('type "%temp%\list2.txt"') do (if exist "C:\ProgramData\Package Cache\%%a\vc_redist.x86.exe" ("C:\ProgramData\Package Cache\%%a\vc_redist.x86.exe" /uninstall /norestart /quiet) else (if exist "C:\ProgramData\Package Cache\%%a\vc_redist.x64.exe" ("C:\ProgramData\Package Cache\%%a\vc_redist.x64.exe" /uninstall /norestart /quiet))))
reg query hklm\software\wow6432node\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2005 Redistributable" /s >>"%temp%\list.txt"
reg query hklm\software\wow6432node\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2008 Redistributable" /s >>"%temp%\list.txt"
reg query hklm\software\wow6432node\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2010  x86 Redistributable" /s >>"%temp%\list.txt"
reg query hklm\software\wow6432node\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2012 x86 Minimum Runtime" /s >>"%temp%\list.txt"
reg query hklm\software\wow6432node\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2012 x86 Additional Runtime" /s >>"%temp%\list.txt"
reg query hklm\software\wow6432node\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2013 x86 Minimum Runtime" /s >>"%temp%\list.txt"
reg query hklm\software\wow6432node\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2013 x86 Additional Runtime" /s >>"%temp%\list.txt"
reg query hklm\software\wow6432node\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 14 x86 Minimum Runtime" /s >>"%temp%\list.txt"
reg query hklm\software\wow6432node\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 14 x86 Additional Runtime" /s >>"%temp%\list.txt"
reg query hklm\software\wow6432node\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2015 x86 Minimum Runtime" /s >>"%temp%\list.txt"
reg query hklm\software\wow6432node\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2015 x86 Additional Runtime" /s >>"%temp%\list.txt"
reg query hklm\software\wow6432node\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2017 x86 Minimum Runtime" /s >>"%temp%\list.txt"
reg query hklm\software\wow6432node\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2017 x86 Additional Runtime" /s >>"%temp%\list.txt"
if exist "%temp%\list.txt" (for /f "delims=\ tokens=8" %%a in ('type "%temp%\list.txt"') do ("%windir%\system32\msiexec.exe" /X%%a /q /norestart))
if exist "%temp%\list.txt" (del "%temp%\list.txt")
if exist "%temp%\list2.txt" (del "%temp%\list2.txt")
:x64skip
call :title
echo.
echo                            卸载已安装的 Visual C++ %arch% 运行库
echo.
echo                               这个过程需要一段时间,请稍后...
reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2012 Redistributable" /s >>"%temp%\list2.txt"
reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2013 Preview Redistributable" /s >>"%temp%\list2.txt"
reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2013 RC Redistributable" /s >>"%temp%\list2.txt"
reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2013 Redistributable" /s >>"%temp%\list2.txt"
reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 14 CTP Redistributable" /s >>"%temp%\list2.txt"
reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2015 Preview Redistributable" /s >>"%temp%\list2.txt"
reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2015 CTP Redistributable" /s >>"%temp%\list2.txt"
reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2015 RC Redistributable" /s >>"%temp%\list2.txt"
reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2015 Redistributable" /s >>"%temp%\list2.txt"
reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2017 RC Redistributable" /s >>"%temp%\list2.txt"
reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2017 Redistributable" /s >>"%temp%\list2.txt"
if exist "%temp%\list2.txt" (if %arch% equ x86 (for /f "delims=\ tokens=7" %%a in ('type "%temp%\list2.txt"') do (if exist "C:\ProgramData\Package Cache\%%a\vcredist_x86.exe" ("C:\ProgramData\Package Cache\%%a\vcredist_x86.exe" /uninstall /quiet))))
if exist "%temp%\list2.txt" (if %arch% equ x86 (for /f "delims=\ tokens=7" %%a in ('type "%temp%\list2.txt"') do (if exist "C:\ProgramData\Package Cache\%%a\vc_redist.x86.exe" ("C:\ProgramData\Package Cache\%%a\vc_redist.x86.exe" /uninstall /quiet))))
reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2005 Redistributable" /s >>"%temp%\list.txt"
reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2008 Redistributable" /s >>"%temp%\list.txt"
if %arch% equ x64 (reg query hklm\software\microsoft\windows\currentversion\uninstall /f "C++ 2010  x64 Redistributable" /s >>"%temp%\list.txt") else (reg query hklm\software\microsoft\windows\currentversion\uninstall /f "C++ 2010  x86 Redistributable" /s >"%temp%\list.txt")
if %arch% equ x64 (reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2012 x64 Minimum Runtime" /s >>"%temp%\list.txt") else (reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2012 x86 Minimum Runtime" /s >"%temp%\list.txt")
if %arch% equ x64 (reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2012 x64 Additional Runtime" /s >>"%temp%\list.txt") else (reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2012 x86 Additional Runtime" /s >"%temp%\list.txt")
if %arch% equ x64 (reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2013 x64 Minimum Runtime" /s >>"%temp%\list.txt") else (reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2013 x86 Minimum Runtime" /s >"%temp%\list.txt")
if %arch% equ x64 (reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2013 x64 Additional Runtime" /s >>"%temp%\list.txt") else (reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2013 x86 Additional Runtime" /s >"%temp%\list.txt")
if %arch% equ x64 (reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 14 x64 Minimum Runtime" /s >>"%temp%\list.txt") else (reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 14 x86 Minimum Runtime" /s >"%temp%\list.txt")
if %arch% equ x64 (reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 14 x64 Additional Runtime" /s >>"%temp%\list.txt") else (reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 14 x86 Additional Runtime" /s >"%temp%\list.txt")
if %arch% equ x64 (reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2015 x64 Minimum Runtime" /s >>"%temp%\list.txt") else (reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2015 x86 Minimum Runtime" /s >"%temp%\list.txt")
if %arch% equ x64 (reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2015 x64 Additional Runtime" /s >>"%temp%\list.txt") else (reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2015 x86 Additional Runtime" /s >"%temp%\list.txt")
if %arch% equ x64 (reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2017 x64 Minimum Runtime" /s >>"%temp%\list.txt") else (reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2017 x86 Minimum Runtime" /s >"%temp%\list.txt")
if %arch% equ x64 (reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2017 x64 Additional Runtime" /s >>"%temp%\list.txt") else (reg query hklm\software\microsoft\windows\currentversion\uninstall /f "Microsoft Visual C++ 2017 x86 Additional Runtime" /s >"%temp%\list.txt")
if exist "%temp%\list.txt" (for /f "delims=\ tokens=7" %%a in ('type "%temp%\list.txt"') do ("%windir%\system32\msiexec.exe" /X%%a /q))
for /f %%G in ('type "redists_x86.txt"') do (call :install "%%G")
if %arch% equ x64 (for /f %%G in ('type "redists_x64.txt"') do (call :install "%%G"))
if %arch% equ x64 (copy /y old_runtimes\* "%windir%\syswow64">nul) else (copy /y old _runtimes\* "%windir%\system32">nul)
if %arch% equ x64 ("%windir%\system32\regsvr32.exe" "%windir%\syswow64\comctl32.ocx" "%windir%\syswow64\comdlg32.ocx" "%windir%\syswow64\mscomctl.ocx" /s) else ("%windir%\system32\regsvr32.exe" "%windir%\system32\comctl32.ocx" "%windir%\system32\comdlg32.ocx" "%windir%\system32\mscomctl.ocx" /s)
if exist "%temp%\list.txt" (del "%temp%\list.txt")
if exist "%temp%\list2.txt" (del "%temp%\list2.txt")
echo.
echo.
echo.
echo                                         安装完毕...
echo.
echo.
if defined auto goto :eof
call :title
goto :eof
:install
call :title
set /a count+=1
echo             安装 组件 %count% of %installs%: %1
echo.
echo.
echo             每个组件安装过程都需要一段时间,请稍后...
"%1" /q
goto :eof
:title
cls
echo.
echo                        ---------------------------------------------------
echo                          Microsoft Visual C++[2005-2017]运行库 安装器
echo                        ---------------------------------------------------
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
echo.
goto :eof