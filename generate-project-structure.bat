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
    echo target/
    echo .idea/
    echo .classpath
    echo .project
    echo .settings/
    echo *.log
    echo *.iml
    echo *.tmp
) > "%ROOT%\.gitignore"

:: Create folders and resources for each module
call :create_resources "%ROOT%" "%CORE%" "%PACKAGE_DIR%\core"
call :create_resources "%ROOT%" "%WEB%" "%PACKAGE_DIR%\web"
call :create_resources "%ROOT%" "%SERVICES%" "%PACKAGE_DIR%\services"

:: Generate parent pom.xml
call :create_parent_pom "%ROOT%" %PACKAGE% %ROOT% %CORE% %WEB% %SERVICES%

:: Generate module pom.xml files
call :create_module_pom "%ROOT%" %CORE% jar %PACKAGE% %ROOT%
call :create_module_pom "%ROOT%" %WEB% war %PACKAGE% %ROOT%
call :create_module_pom "%ROOT%" %SERVICES% war %PACKAGE% %ROOT%

echo.
echo Folder structure and pom files created successfully:
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

:: ---------------------
:create_parent_pom
:: %1 = root dir
:: %2 = groupId (package)
:: %3 = artifactId (root project name)
:: %4 = core module name
:: %5 = web module name
:: %6 = services module name
(
echo ^<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"^>
echo ^<modelVersion^>4.0.0^</modelVersion^>
echo ^<groupId^>%2^</groupId^>
echo ^<artifactId^>%3^</artifactId^>
echo ^<version^>1.0-SNAPSHOT^</version^>
echo ^<packaging^>pom^</packaging^>
echo ^<properties^>
echo     ^<java.version^>17^</java.version^>
echo     ^<maven.compiler.plugin.version^>3.10.1^</maven.compiler.plugin.version^>
echo     ^<maven.war.plugin.version^>3.3.2^</maven.war.plugin.version^>
echo     ^<jacoco.plugin.version^>0.8.10^</jacoco.plugin.version^>
echo     ^<pmd.plugin.version^>3.18.0^</pmd.plugin.version^>
echo     ^<checkstyle.plugin.version^>10.11.0^</checkstyle.plugin.version^>
echo     ^<csm.plugin.version^>2.8.0^</csm.plugin.version^>
echo ^</properties^>
echo ^<modules^>
echo     ^<module^>%4^</module^>
echo     ^<module^>%5^</module^>
echo     ^<module^>%6^</module^>
echo ^</modules^>
echo ^</project^>
) > "%1\pom.xml"
exit /b

:: ---------------------
:create_module_pom
:: %1 = root folder
:: %2 = module name
:: %3 = packaging type (jar or war)
:: %4 = groupId (package)
:: %5 = parent artifactId

set "PACKAGING=%~3"

(
echo ^<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"^>
echo ^<modelVersion^>4.0.0^</modelVersion^>
echo ^<parent^>
echo     ^<groupId^>%4^</groupId^>
echo     ^<artifactId^>%5^</artifactId^>
echo     ^<version^>1.0-SNAPSHOT^</version^>
echo ^</parent^>
echo ^<artifactId^>%2^</artifactId^>
echo ^<packaging^>%PACKAGING%^</packaging^>
echo ^<properties^>
echo     ^<maven.compiler.source^>${java.version}^</maven.compiler.source^>
echo     ^<maven.compiler.target^>${java.version}^</maven.compiler.target^>
echo ^</properties^>
echo ^<build^>
echo     ^<plugins^>
echo         ^<plugin^>
echo             ^<groupId^>org.apache.maven.plugins^</groupId^>
echo             ^<artifactId^>maven-compiler-plugin^</artifactId^>
echo             ^<version^>${maven.compiler.plugin.version}^</version^>
echo             ^<configuration^>
echo                 ^<source^>${java.version}^</source^>
echo                 ^<target^>${java.version}^</target^>
echo             ^</configuration^>
echo         ^</plugin^>
) > "%1\%2\pom.xml"

if /i "!PACKAGING!"=="war" (
    >> "%1\%2\pom.xml" (
        echo         ^<plugin^>
        echo             ^<groupId^>org.apache.maven.plugins^</groupId^>
        echo             ^<artifactId^>maven-war-plugin^</artifactId^>
        echo             ^<version^>${maven.war.plugin.version}^</version^>
        echo             ^<configuration^>
        echo                 ^<failOnMissingWebXml^>false^</failOnMissingWebXml^>
        echo             ^</configuration^>
        echo         ^</plugin^>
    )
)

>> "%1\%2\pom.xml" (
echo     ^</plugins^>
echo ^</build^>
echo ^</project^>
)

exit /b
