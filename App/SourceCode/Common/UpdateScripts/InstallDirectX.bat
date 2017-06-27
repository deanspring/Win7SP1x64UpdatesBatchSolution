@ECHO OFF & PUSHD %~DP0
mode con:cols=94 lines=42
SET DX_HOME=%APP_HOME%\Updates\Runtimes\DirectX
SET SUCCESSTIPS=安装  微软DirectX9.0c最终用户运行库
ECHO.
ECHO                      ---------------------------------------------------
ECHO                            微软DirectX9.0c最终用户运行库 安装器
ECHO                      ---------------------------------------------------
ECHO.
IF NOT EXIST "%WINDIR%\System32\d3dx11_43.dll" (
    ECHO.
    ECHO 正在%SUCCESSTIPS%
    ECHO.
    "%DX_HOME%\DXSETUP.exe" /silent
    ECHO.
    ECHO 成功%SUCCESSTIPS%
    ECHO.
) ELSE (
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
    ECHO                        微软DirectX9.0c最终用户运行库已安装,无需重新安装...
    ECHO.  
    ECHO.
)
GOTO :EOF

echo                        ---------------------------------------------------
echo                          Microsoft Visual C++[2005-2017]运行库 安装器
echo                        ---------------------------------------------------
echo.