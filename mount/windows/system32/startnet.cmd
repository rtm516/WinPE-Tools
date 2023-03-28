@echo off
title WinPE Tools

echo Welcome to the WinPE tools image
echo Starting...
wpeinit

echo Locating system drive
@REM Drive X is missing as thats the one WinPE boots from
for %%a in (C D E F G H I J K L M N O P Q R S T U V W Y Z) do @if exist %%a:\Windows\ set SYSTEMDRIVE=%%a
echo Located %SYSTEMDRIVE% as system drive ($env:SYSTEMDRIVE)

powershell -NoLogo
