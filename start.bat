@echo off
TITLE DayZ Server 1 - Normal Modded Server
COLOR 0B
:: Parameters::
::DayZ Parameters
set DAYZ-SA_SERVER_LOCATION="E:\DayZServer"
set DAYZ-SAL_NAME=DZSALModServer.exe
set LOG_LOCATION=E:\DayZServer\logs
set PORT_NUM=2302
::
::Battleye Parameters
set BE_FOLDER="E:\DayZServer\Battleye"
set BEC_LOCATION="E:\DayZServer\Battleye\Bec"
::
::ModCheck Parameters
set MOD_LIST=(E:\DayZServer\Modlist.txt)
set STEAM_WORKSHOP=E:\steamcmd\steamapps\workshop\content\221100
set STEAMCMD_LOCATION=E:\steamcmd
set STEAM_USER=daxrepair
set STEAMCMD_DEL=5
setlocal EnableDelayedExpansion
::::::::::::::

echo Agusanz
goto checksv
pause

:checksv
tasklist /FI "IMAGENAME eq %DAYZ-SAL_NAME%" 2>NUL | find /I /N "%DAYZ-SAL_NAME%">NUL
if "%ERRORLEVEL%"=="0" goto checksv
::cls
echo Server is not running, taking care of it..
goto killsv

::checkbec
::tasklist /FI "IMAGENAME eq Bec.exe" 2>NUL | find /I /N "Bec.exe">NUL
if "%ERRORLEVEL%"=="0" goto loopsv
::cls
::echo Bec is not running, taking care of it..
::goto startbec

:loopsv
FOR /L %%s IN (30,-1,0) DO (
	cls
	echo Server is running. Checking again in %%s seconds..
	timeout 1 >nul
)
goto checksv

:killsv
taskkill /f /im %DAYZ-SAL_NAME%
goto checkmods

:startsv
::cls
echo Starting DayZ SA Server.
timeout 1 >nul
::cls
echo Starting DayZ SA Server..
timeout 1 >nul
::cls
echo Starting DayZ SA Server...
cd "%DAYZ-SA_SERVER_LOCATION%"
::start %DAYZ-SAL_NAME% -config=serverDZ.cfg -port=%PORT_NUM% -dologs -adminlog -netlog -freezecheck -BEpath=%BE_FOLDER% -profiles=%LOG_LOCATION% "-mod=!MODS_TO_LOAD!%" "-servermod=@Survivor Missions" "-scrAllowFileWrite"
start %DAYZ-SAL_NAME% -config=serverDZ.cfg -port=%PORT_NUM% -freezecheck -BEpath=%BE_FOLDER% -profiles=%LOG_LOCATION% "-mod=!MODS_TO_LOAD!%" "-scrAllowFileWrite"
::FOR /L %%s IN (30,-1,0) DO (
::	cls
::	echo Initializing server, wait %%s seconds to initialize Bec..
::	timeout 1 >nul
::)
::goto startbec


::startbec
::cls
::echo Starting Bec.
::timeout 1 >nul
::cls
::echo Starting Bec..
::timeout 1 >nul
::cls
::echo Starting Bec...
::timeout 1 >nul
::cd "%BEC_LOCATION%"
::start Bec.exe -f Config.cfg
goto checksv

:checkmods
::cls
FOR /L %%s IN (%STEAMCMD_DEL%,-1,0) DO (
	cls
	echo Checking for mod updates in %%s seconds..
	timeout 1 >nul
)
echo Reading in configurations/variables set in this batch and MOD_LIST. Updating Steam Workbench mods...
@ timeout 1 >nul
cd %STEAMCMD_LOCATION%
for /f "tokens=1,2 delims=," %%g in %MOD_LIST% do steamcmd.exe +login %STEAM_USER% +workshop_download_item 221100 "%%g" +quit
::cls
echo Steam Workshop files up to date! Syncing Workbench source with server destination...
@ timeout 2 >nul
::cls
@ for /f "tokens=1,2 delims=," %%g in %MOD_LIST% do robocopy "%STEAM_WORKSHOP%\%%g" "%DAYZ-SA_SERVER_LOCATION%\%%h" *.* /mir
@ for /f "tokens=1,2 delims=," %%g in %MOD_LIST% do forfiles /p "%DAYZ-SA_SERVER_LOCATION%\%%h" /m *.bikey /s /c "cmd /c copy @path %DAYZ-SA_SERVER_LOCATION%\keys"
::cls
echo Sync complete! If sync not completed correctly, verify configuration file.
@ timeout 3 >nul
::cls
set "MODS_TO_LOAD="
for /f "tokens=1,2 delims=," %%g in %MOD_LIST% do (
set "MODS_TO_LOAD=!MODS_TO_LOAD!%%h;"
)
set "MODS_TO_LOAD=!MODS_TO_LOAD:~0,-1!"
ECHO Will start DayZ with the following mods: !MODS_TO_LOAD!%
@ timeout 3 >nul
goto startsv
