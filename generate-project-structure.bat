@echo off
setlocal enabledelayedexpansion

:: Ask user for root project name
set /p ROOT=Enter the root project name (e.g., myapp-root): 

if "%ROOT%"=="" (
    echo No project name entered. Exiting.
    exit /b 1
)

:: Ask user for base package name
set /p PACKAGE=Enter the base package name (e.g., com.garbuz): 

if "%PACKAGE%"=="" (
    echo No package name entered. Exiting.
    exit /b 1
)

:: Convert package name to folder path (com.garbuz -> com\garbuz)
set "PACKAGE_DIR=%PACKAGE:.=\%"

:: Derive base name and module names
set "BASE_NAME=%ROOT%"
set LAST5=%ROOT:~-5%
if /i "%LAST5%"=="-root" (
    set "BASE_NAME=%ROOT:~0,-5%"
)

set "CORE=%BASE_NAME%-core"
set "WEB=%BASE_NAME%-web"
set "SERVICES=%BASE_NAME%-services"

echo Creating project folders:
echo ROOT:     %ROOT%
echo CORE:     %CORE%
echo WEB:      %WEB%
echo SERVICES: %SERVICES%
echo BASE PKG: %PACKAGE%

:: Create root and dev-ops folder
mkdir "%ROOT%"
mkdir "%ROOT%\dev-ops\maven\site-config"

:: .gitignore in root
(
    echo /target/
    echo /.idea/
    echo /.classpath
    echo /.project
    echo /.settings/
    echo *.log
    echo *.iml
    echo *.tmp
) > "%ROOT%\.gitignore"

:: Helper function for resource props and readme
call :create_resources "%ROOT%" "%CORE%" "%PACKAGE_DIR%\core"
call :create_resources "%ROOT%" "%WEB%" "%PACKAGE_DIR%\web"
call :create_resources "%ROOT%" "%SERVICES%" "%PACKAGE_DIR%\services"

echo.
echo Folder structure created successfully:
tree "%ROOT%"

pause
exit /b

:: ---------------------
:create_resources
:: %1 = root
:: %2 = module name
:: %3 = full subpackage dir (com\garbuz\xyz)
mkdir "%~1\%~2\src\main\java\%~3"
mkdir "%~1\%~2\src\main\resources"
mkdir "%~1\%~2\src\test\java\%~3"
mkdir "%~1\%~2\src\test\resources"
mkdir "%~1\%~2\src\main\webapp\WEB-INF\lib"
mkdir "%~1\%~2\src\main\webapp\WEB-INF\classes"

:: application.properties
echo # Application config > "%~1\%~2\src\main\resources\application.properties"

:: test-application.properties
echo # Test config > "%~1\%~2\src\test\resources\test-application.properties"

:: README.md
(
    echo # %~2
    echo This module is part of the %BASE_NAME% application.
) > "%~1\%~2\README.md"

exit /b
