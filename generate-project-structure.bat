@echo off
setlocal enabledelayedexpansion

:: Ask user for root project name
set /p ROOT=Enter the root project name (e.g., myapp-root): 

if "%ROOT%"=="" (
    echo No project name entered. Exiting.
    exit /b 1
)

:: Determine module names based on -root suffix
set CORE=%ROOT%
set WEB=%ROOT%

:: Get last 5 characters to see if it ends with -root
set LAST5=%ROOT:~-5%
if /i "%LAST5%"=="-root" (
    set "BASE_NAME=%ROOT:~0,-5%"
    set "CORE=%BASE_NAME%-core"
    set "WEB=%BASE_NAME%-web"
) else (
    set "CORE=%ROOT%-core"
    set "WEB=%ROOT%-web"
)

echo Creating project folders for root project: %ROOT%
echo Core module: %CORE%
echo Web module: %WEB%

:: Create root folder and dev-ops config
mkdir "%ROOT%"
mkdir "%ROOT%\dev-ops\maven\site-config"

:: Create core module folder structure
mkdir "%ROOT%\%CORE%\src\main\java"
mkdir "%ROOT%\%CORE%\src\main\resources"
mkdir "%ROOT%\%CORE%\src\test\java"
mkdir "%ROOT%\%CORE%\src\test\resources"

:: Create web module folder structure including webapp
mkdir "%ROOT%\%WEB%\src\main\java"
mkdir "%ROOT%\%WEB%\src\main\resources"
mkdir "%ROOT%\%WEB%\src\test\java"
mkdir "%ROOT%\%WEB%\src\test\resources"
mkdir "%ROOT%\%WEB%\src\main\webapp\WEB-INF\lib"
mkdir "%ROOT%\%WEB%\src\main\webapp\WEB-INF\classes"

echo.
echo Folder structure created successfully:
tree "%ROOT%"

pause
exit /b
