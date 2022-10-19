@ECHO OFF
REM  QBFC Project Options Begin
REM HasVersionInfo: Yes
REM Companyname: HSH
REM Productname: Multiprofile starter for Telegram/Kotatogram/64Gram
REM Filedescription: "Enables" the possibility to use multiple profiles in Telegram Windows clients
REM Copyrights: © Fixxxer
REM Trademarks: 
REM Originalname: TgMP.exe
REM Comments: 
REM Productversion:  4. 4. 0. 0
REM Fileversion:  4. 4. 0. 0
REM Internalname: TgMP.exe
REM ExeType: console
REM Architecture: x86
REM Appicon: X:\VoIP\Telegram\TgMultiProfile\Icon.2.0409.ico
REM AdministratorManifest: No
REM Embeddedfile: X:\VoIP\Telegram\TgMultiProfile\nircmdc.exe|nircmdc.exe
REM  QBFC Project Options End
@ECHO ON
@ECHO OFF
setlocal enabledelayedexpansion
title Multiprofile starter for Telegram/Kotatogram/64Gram
color 1f

if not exist %0.lock goto start
echo Process aborted: this program is already running
echo Close all Telegram/Kotatogram/64Gram instances
echo Exit and start once again
echo.
SET /P ask="If you want to override this check press 0, exit - any key>"
if /i "%ask%" NEQ "0" goto doublestart

:start
copy /y NUL %0.lock >nul 2>nul

if not exist "Telegram.exe" if not exist "Kotatogram.exe" if not exist "64Gram.exe" goto notelegram

del /F /Q 1.reg >nul 2>nul
del /F /Q 2.reg >nul 2>nul
del /F /Q 3.reg >nul 2>nul
del /F /Q 4.reg >nul 2>nul
del /F /Q 5.reg >nul 2>nul
reg export "HKEY_CLASSES_ROOT\tg" 1.reg /y >nul 2>nul
reg export "HKEY_CLASSES_ROOT\tdesktop.tg" 2.reg /y >nul 2>nul
reg export "HKEY_CLASSES_ROOT\ktgdesktop.tg" 3.reg /y >nul 2>nul
reg export "HKEY_CURRENT_USER\Software\KotatogramDesktop" 4.reg /y >nul 2>nul
reg export "HKEY_CURRENT_USER\Software\TelegramDesktop" 5.reg /y  >nul 2>nul

if exist "tdata" goto tdata

:new
cls

:confirm
SET /P name="What is the name of profile? (Press "Enter" to start a new profile) >"
CALL :LoCase name
call :checkprofilename name
if "%name%"=="" goto newprof
if %ERRORLEVEL%==1 goto confirm
if not exist "%name%" goto noprof
goto starttg

:newprof
SET /P name="Type a name for a new profile >"
CALL :LoCase name
call :checkprofilename name
if %ERRORLEVEL%==1 goto newprof
mkdir "%name%\telegram"
mkdir "%name%\kotatogram"
mkdir "%name%\64gram"

:starttg
if exist "Telegram.exe" attrib +R Telegram.exe
if exist "Kotatogram.exe" attrib +R Kotatogram.exe
if exist "64Gram.exe" attrib +R 64Gram.exe
if exist Updater.exe del /F /Q Updater.exe
if exist "64Gram.exe" if exist "Telegram.exe" if not exist "Kotatogram.exe" goto 6t
if exist "Kotatogram.exe" if exist "Telegram.exe" if not exist "64Gram.exe" goto kt
if exist "64Gram.exe" if exist "Kotatogram.exe" if not exist "Telegram.exe" goto 6k
if exist "64Gram.exe" if exist "Kotatogram.exe" if exist "Telegram.exe" goto 6kt
if exist "Telegram.exe" goto telegram 
if exist "Kotatogram.exe" goto kotatogram
if exist "64Gram.exe" goto 64gram

:64gram
echo.
rem echo ---------------------------
rem echo ^<^<^< !DO NOT CLOSE THIS! ^>^>^>
rem echo ---------------------------
rem echo.
rem %MYFILES%\setconsole /hide
%MYFILES%\nircmdc.exe win hide ititle "Multiprofile starter for Telegram/Kotatogram/64Gram"
start /wait 64Gram.exe -workdir %name%\64gram\
goto looping

:kotatogram
echo.
rem echo ---------------------------
rem echo ^<^<^< !DO NOT CLOSE THIS! ^>^>^>
rem echo ---------------------------
rem echo.
rem %MYFILES%\setconsole /hide
%MYFILES%\nircmdc.exe win hide ititle "Multiprofile starter for Telegram/Kotatogram/64Gram"
start /wait Kotatogram.exe -workdir %name%\kotatogram\
goto looping

:telegram
echo.
rem echo ---------------------------
rem echo ^<^<^< !DO NOT CLOSE THIS! ^>^>^>
rem echo ---------------------------
rem echo.
rem %MYFILES%\setconsole /hide
%MYFILES%\nircmdc.exe win hide ititle "Multiprofile starter for Telegram/Kotatogram/64Gram"
start /wait Telegram.exe -workdir %name%\telegram\
goto looping

:looping
rem %MYFILES%\setconsole /show /fg
%MYFILES%\nircmdc.exe win show ititle "Multiprofile starter for Telegram/Kotatogram/64Gram"
echo ---------------------------
echo ^<^<^<        Done!        ^>^>^>
echo ---------------------------
echo.

:quitting
set "name="
set "newname="
SET /P ask="Any more? [y/n]>"
if /i "%ask%"=="yes" goto new
if /i "%ask%"=="y" goto new
if /i "%ask%"=="n" goto end
if /i "%ask%"=="no" goto end
if /i "%ask%"=="0" goto removealltraces
if /i "%ask%" NEQ "n" if /i "%ask%" NEQ "no" if /i "%ask%" NEQ "y" if /i "%ask%" NEQ "yes" goto quitting

:noprof
echo This profile was not found!
echo.
echo We have the following profiles:
echo.
echo ---------------------------
dir /ad-s-h-r /b /l | findstr /v /c:"modules"
echo ---------------------------
echo.
echo Try again or create a new profile by pressing "Enter" after the prompt.
echo.
set "name="
goto confirm

:kt
echo Both Telegram and Kotatogram clients are found.
echo.
:askingkt
echo Which one you want to start?
SET /P ask="Telegram - press 1, Kotatogram - press 0>"
if "%ask%"=="1" goto telegram
if "%ask%"=="0" goto kotatogram
if "%ask%" NEQ "1" if "%ask%" NEQ "0" goto askingkt

:6kt
echo Three Telegram clients are found.
echo.
:asking6kt
echo Which one you want to start?
SET /P ask="Telegram - press 1, Kotatogram - press 3, 64Gram - press 5>"
if "%ask%"=="1" goto telegram
if "%ask%"=="3" goto kotatogram
if "%ask%"=="5" goto 64gram
if "%ask%" NEQ "1" if "%ask%" NEQ "3" if "%ask%" NEQ "5" goto asking6kt

:6t
echo Both Telegram and 64Gram clients are found.
echo.
:asking6t
echo Which one you want to start?
SET /P ask="Telegram - press 1, 64Gram - press 0>"
if "%ask%"=="1" goto telegram
if "%ask%"=="0" goto 64gram
if "%ask%" NEQ "1" if "%ask%" NEQ "2" goto asking6t

:6k
echo Both 64Gram and Kotatogram clients are found.
echo.
:asking6k
echo Which one you want to start?
SET /P ask="64Gram - press 1, Kotatogram - press 0>"
if "%ask%"=="1" goto 64gram
if "%ask%"=="0" goto kotatogram
if "%ask%" NEQ "1" if "%ask%" NEQ "2" goto asking6k

:tdata
echo Default "tdata" profile was found!
echo Let's make it working.
echo.
:newproftdata
SET /P name="Type a name for this new profile >"
CALL :LoCase name
call :checkprofilename name
if %ERRORLEVEL%==1 goto newproftdata
mkdir "%name%\telegram"
mkdir "%name%\kotatogram"
echo.
:askingtdata
echo Which client corresponds to this profile?
SET /P ask="Telegram - press 1, Kotatogram - press 3, 64Gram - press 5>"
if "%ask%"=="1" goto telegramtdata
if "%ask%"=="5" goto 64gramtdata
if "%ask%"=="3" goto kotatogramtdata
if "%ask%" NEQ "1" if "%ask%" NEQ "3" if "%ask%" NEQ "5" goto askingtdata

:telegramtdata
move /Y tdata ".\%name%\telegram\"
if exist log.txt move /Y log.txt ".\%name%\telegram\"
if exist DebugLogs move /Y DebugLogs ".\%name%\telegram\"
goto profileready
:kotatogramtdata
move /Y tdata ".\%name%\kotatogram\"
if exist log.txt move /Y log.txt ".\%name%\kotatogram\"
if exist DebugLogs move /Y DebugLogs ".\%name%\kotatogram\"
goto profileready
:64gramtdata
move /Y tdata ".\%name%\64gram\"
if exist log.txt move /Y log.txt ".\%name%\64gram\"
if exist DebugLogs move /Y DebugLogs ".\%name%\64gram\"
goto profileready
:profileready
echo We have made this tdata profile working
echo.
echo Now let's start again.
echo.
goto confirm

:LoCase
if not defined %~1 exit /B 1
SET %~1=!%~1:A=a!
SET %~1=!%~1:B=b!
SET %~1=!%~1:C=c!
SET %~1=!%~1:D=d!
SET %~1=!%~1:E=e!
SET %~1=!%~1:F=f!
SET %~1=!%~1:G=g!
SET %~1=!%~1:H=h!
SET %~1=!%~1:I=i!
SET %~1=!%~1:J=j!
SET %~1=!%~1:K=k!
SET %~1=!%~1:L=l!
SET %~1=!%~1:M=m!
SET %~1=!%~1:N=n!
SET %~1=!%~1:O=o!
SET %~1=!%~1:P=p!
SET %~1=!%~1:Q=q!
SET %~1=!%~1:R=r!
SET %~1=!%~1:S=s!
SET %~1=!%~1:T=t!
SET %~1=!%~1:U=u!
SET %~1=!%~1:V=v!
SET %~1=!%~1:W=w!
SET %~1=!%~1:X=x!
SET %~1=!%~1:Y=y!
SET %~1=!%~1:Z=z!
exit /B 0

:UpCase
if not defined %~1 exit /B 1
SET %~1=!%~1:a=A!
SET %~1=!%~1:b=B!
SET %~1=!%~1:c=C!
SET %~1=!%~1:d=D!
SET %~1=!%~1:e=E!
SET %~1=!%~1:f=F!
SET %~1=!%~1:g=G!
SET %~1=!%~1:h=H!
SET %~1=!%~1:i=I!
SET %~1=!%~1:j=J!
SET %~1=!%~1:k=K!
SET %~1=!%~1:l=L!
SET %~1=!%~1:m=M!
SET %~1=!%~1:n=N!
SET %~1=!%~1:o=O!
SET %~1=!%~1:p=P!
SET %~1=!%~1:q=Q!
SET %~1=!%~1:r=R!
SET %~1=!%~1:s=S!
SET %~1=!%~1:t=T!
SET %~1=!%~1:u=U!
SET %~1=!%~1:v=V!
SET %~1=!%~1:w=W!
SET %~1=!%~1:x=X!
SET %~1=!%~1:y=Y!
SET %~1=!%~1:z=Z!
exit /B 0

:checkprofilename
if not defined %~1 exit /B 1
if "%name%"=="modules" goto wrongprofilename
exit /B 0
:wrongprofilename
echo You cannot use this name as it is used by Telegram!
exit /B 1

:removealltraces
reg delete "HKEY_CLASSES_ROOT\tg" /f >nul 2>nul
reg delete "HKEY_CLASSES_ROOT\tdesktop.tg" /f >nul 2>nul
reg delete "HKEY_CLASSES_ROOT\ktgdesktop.tg" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\RegisteredApplications\Kotatogram Desktop" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\RegisteredApplications\Telegram Desktop" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\KotatogramDesktop" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\TelegramDesktop" /f >nul 2>nul
goto end

:notelegram
echo Please place this program in the folder
echo where Telegram.exe, 64Gram.exe or Kotatogram.exe exists.
echo.
echo This program will not work without it.
echo.
pause

:end
endlocal
reg delete "HKEY_CLASSES_ROOT\tg" /f >nul 2>nul
reg delete "HKEY_CLASSES_ROOT\tdesktop.tg" /f >nul 2>nul
reg delete "HKEY_CLASSES_ROOT\ktgdesktop.tg" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\RegisteredApplications\Kotatogram Desktop" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\RegisteredApplications\Telegram Desktop" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\KotatogramDesktop" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\TelegramDesktop" /f >nul 2>nul
reg import 1.reg >nul 2>nul
reg import 2.reg >nul 2>nul
reg import 3.reg >nul 2>nul
reg import 4.reg >nul 2>nul
reg import 5.reg >nul 2>nul
del /F /Q 1.reg >nul 2>nul
del /F /Q 2.reg >nul 2>nul
del /F /Q 3.reg >nul 2>nul
del /F /Q 4.reg >nul 2>nul
del /F /Q 5.reg >nul 2>nul
del /F /Q %0.lock >nul 2>nul
cls
rem echo Bye!
rem del %~s0 /q /f
rem echo.
rem pause
:doublestart
color
exit /B 0
