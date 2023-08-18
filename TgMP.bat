@ECHO OFF
REM  QBFC Project Options Begin
REM HasVersionInfo: Yes
REM Companyname: HSH
REM Productname: Multiprofile starter for 64Gram/Kotatogram/Telegram/iMe/AyuGram
REM Filedescription: "Enables" the possibility to use multiple profiles in Telegram Windows clients
REM Copyrights: © Fixxxer
REM Trademarks: 
REM Originalname: TgMP.exe
REM Comments: 
REM Productversion:  5. 2. 0. 1
REM Fileversion:  5. 2. 0. 1
REM Internalname: TgMP.exe
REM ExeType: console
REM Architecture: x86
REM Appicon: X:\VoIP\Telegram\TgMultiProfile\Icon.2.0409.ico
REM AdministratorManifest: No
REM Embeddedfile: E:\Repositories\TgMP\MYFILES\nircmdc.exe|nircmdc.exe
REM  QBFC Project Options End
@ECHO ON
@ECHO OFF
setlocal enabledelayedexpansion
title Multiprofile starter for 64Gram/Kotatogram/Telegram/iMe/AyuGram
color 1f

if not exist %0.lock goto start
echo Process aborted: this program is already running
echo Close all 64Gram/Kotatogram/Telegram/iMe/AyuGram instances
echo Exit and start once again
echo.
SET /P ask="If you want to override this check press 0, exit - any key>"
if /i "%ask%" NEQ "0" goto doublestart

:start
copy /y NUL %0.lock >nul 2>nul

if not exist "64Gram.exe" if not exist "Kotatogram.exe" if not exist "Telegram.exe" if not exist "iMe.exe" if not exist "AyuGram.exe" goto :0000

for /l %%i in (1,1,9) do del /f /q %%i.reg >nul 2>nul
reg export "HKEY_CLASSES_ROOT\tg" 1.reg /y >nul 2>nul
reg export "HKEY_CLASSES_ROOT\tdesktop.tg" 2.reg /y >nul 2>nul
reg export "HKEY_CLASSES_ROOT\ktgdesktop.tg" 3.reg /y >nul 2>nul
reg export "HKEY_CURRENT_USER\Software\KotatogramDesktop" 4.reg /y >nul 2>nul
reg export "HKEY_CURRENT_USER\Software\TelegramDesktop" 5.reg /y  >nul 2>nul
reg export "HKEY_CURRENT_USER\Software\iMe" 6.reg /y  >nul 2>nul
reg export "HKEY_CURRENT_USER\Software\64Gram" 7.reg /y  >nul 2>nul
reg export "HKEY_CURRENT_USER\Software\64GramDesktop" 8.reg /y  >nul 2>nul
reg export "HKEY_CURRENT_USER\Software\AyuGramDesktop" 9.reg /y  >nul 2>nul

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
for /d %%i in (64gram,kotatogram,telegram,iMe,ayugram) do mkdir "%%i"

:starttg
for /d %%i in (64gram,kotatogram,telegram,iMe,ayugram) do if exist "%%i" attrib +R %%i
if exist Updater.exe del /F /Q Updater.exe
:clientrun 
echo The following Telegram clients are found:
echo.
if exist "64Gram.exe" echo 1.	64Gram
if exist "Kotatogram.exe" echo 3.	Kotatogram
if exist "Telegram.exe" echo 5.	Telegram
if exist "iMe.exe" echo 7.	iMe
if exist "AyuGram.exe" echo 9.	AyuGram
echo.
SET /P ask="Which one you want to start? Enter the number that corrsponds to client>"
if "%ask%" NEQ "1" if "%ask%" NEQ "3" if "%ask%" NEQ "5" if "%ask%" NEQ "7" if "%ask%" NEQ "9" goto clientrun
if "%ask%"=="1" goto 60000
if "%ask%"=="3" goto 0k000
if "%ask%"=="5" goto 00t00
if "%ask%"=="7" goto 000i0
if "%ask%"=="9" goto 0000a
:60000
if not exist "64Gram.exe" goto clientrun
echo.
rem echo ---------------------------
rem echo ^<^<^< !DO NOT CLOSE THIS! ^>^>^>
rem echo ---------------------------
rem echo.
rem %MYFILES%\setconsole /hide
%MYFILES%\nircmdc.exe win hide ititle "Multiprofile starter for 64Gram/Kotatogram/Telegram/iMe/AyuGram"
start /wait 64Gram.exe -workdir %name%\64gram\
goto looping
:0k000
if not exist "Kotatogram.exe" goto clientrun
echo.
rem echo ---------------------------
rem echo ^<^<^< !DO NOT CLOSE THIS! ^>^>^>
rem echo ---------------------------
rem echo.
rem %MYFILES%\setconsole /hide
%MYFILES%\nircmdc.exe win hide ititle "Multiprofile starter for 64Gram/Kotatogram/Telegram/iMe/AyuGram"
start /wait Kotatogram.exe -workdir %name%\kotatogram\
goto looping
:00t00
if not exist "Telegram.exe" goto clientrun
echo.
rem echo ---------------------------
rem echo ^<^<^< !DO NOT CLOSE THIS! ^>^>^>
rem echo ---------------------------
rem echo.
rem %MYFILES%\setconsole /hide
%MYFILES%\nircmdc.exe win hide ititle "Multiprofile starter for 64Gram/Kotatogram/Telegram/iMe/AyuGram"
start /wait Telegram.exe -workdir %name%\telegram\
goto looping
:000i0
if not exist "iMe.exe" goto clientrun
echo.
rem echo ---------------------------
rem echo ^<^<^< !DO NOT CLOSE THIS! ^>^>^>
rem echo ---------------------------
rem echo.
rem %MYFILES%\setconsole /hide
%MYFILES%\nircmdc.exe win hide ititle "Multiprofile starter for 64Gram/Kotatogram/Telegram/iMe/AyuGram"
start /wait iMe.exe -workdir %name%\iMe\
goto looping
:0000a
if not exist "AyuGram.exe" goto clientrun
echo.
rem echo ---------------------------
rem echo ^<^<^< !DO NOT CLOSE THIS! ^>^>^>
rem echo ---------------------------
rem echo.
rem %MYFILES%\setconsole /hide
%MYFILES%\nircmdc.exe win hide ititle "Multiprofile starter for 64Gram/Kotatogram/Telegram/iMe/AyuGram"
start /wait AyuGram.exe -workdir %name%\ayugram\
goto looping

:looping
rem %MYFILES%\setconsole /show /fg
%MYFILES%\nircmdc.exe win show ititle "Multiprofile starter for 64Gram/Kotatogram/Telegram/iMe/AyuGram"
echo ---------------------------
echo ^<^<^<        Done!        ^>^>^>
echo ---------------------------
echo.
:quitting
set "name="
set "newname="
SET /P ask="Any more? [y/n]>"
if /i "%ask%" NEQ "n" if /i "%ask%" NEQ "no" if /i "%ask%" NEQ "y" if /i "%ask%" NEQ "yes" if /i "%ask%" NEQ "0" goto quitting
if /i "%ask%"=="yes" goto new
if /i "%ask%"=="y" goto new
if /i "%ask%"=="n" goto end
if /i "%ask%"=="no" goto end
if /i "%ask%"=="0" goto removealltraces

:tdata
echo Default "tdata" profile was found!
echo Let's make it working.
echo.
:newproftdata
SET /P name="Type a name for this new profile >"
CALL :LoCase name
call :checkprofilename name
if %ERRORLEVEL%==1 goto newproftdata
echo Such profile already exists!
echo The data will be overwritten!
SET /P ask="If you want to proceed press 0, choose once again - any key>"
if /i "%ask%" NEQ "0" goto newproftdata
for /d %%i in (64gram,kotatogram,telegram,iMe,ayugram) do mkdir "%%i"
echo.
:askingtdata
echo Which client corresponds to this profile?
SET /P ask="64Gram - press 1, Kotatogram - press 3, Telegram - press 5, iMe - press 7, AyuGram - press 9>"
if "%ask%" NEQ "1" if "%ask%" NEQ "3" if "%ask%" NEQ "5" if "%ask%" NEQ "7" if "%ask%" NEQ "9" goto askingtdata
if "%ask%"=="1" call :mtdata 64gram
if "%ask%"=="3" call :mtdata kotatogram
if "%ask%"=="5" call :mtdata telegram
if "%ask%"=="7" call :mtdata iMe
if "%ask%"=="9" call :mtdata ayugram
echo We have made this tdata profile working
echo.
echo Now let's start again.
echo.
goto confirm

:mtdata
rd /s /q ".\%name%\%~1\"
mkdir ".\%name%\%~1\"
move /Y tdata ".\%name%\%~1\"
if exist log.txt move /Y log.txt ".\%name%\%~1\"
if exist DebugLogs move /Y DebugLogs ".\%name%\%~1\"
exit /b

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
reg delete "HKEY_CURRENT_USER\Software\RegisteredApplications\iMe Desktop" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\RegisteredApplications\64Gram Desktop" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\RegisteredApplications\AyuGram Desktop" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\KotatogramDesktop" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\TelegramDesktop" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\64GramDesktop" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\64Gram" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\iMe" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\AyuGramDesktop" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\AyuGram" /f >nul 2>nul
goto finalend

:0000
echo Please place this program in the folder
echo where Telegram.exe, 64Gram.exe, Kotatogram.exe, iMe.exe or AyuGram.exe exists.
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
reg delete "HKEY_CURRENT_USER\Software\RegisteredApplications\iMe Desktop" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\RegisteredApplications\64Gram Desktop" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\RegisteredApplications\AyuGram Desktop" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\KotatogramDesktop" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\TelegramDesktop" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\64GramDesktop" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\64Gram" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\iMe" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\AyuGramDesktop" /f >nul 2>nul
reg delete "HKEY_CURRENT_USER\Software\AyuGram" /f >nul 2>nul
for /l %%i in (1,1,9) do reg import %%i.reg >nul 2>nul
:finalend
for /l %%i in (1,1,9) do del /f /q %%i.reg >nul 2>nul
del /F /Q %0.lock >nul 2>nul
cls
rem echo Bye!
rem del %~s0 /q /f
rem echo.
rem pause
:doublestart
color
exit /B 0
