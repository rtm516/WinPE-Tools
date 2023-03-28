@echo off
title WinPE Tools

echo Welcome to the WinPE tools image
echo Starting...
wpeinit

echo Locating system drive
@REM Drive X is missing as thats the one WinPE boots from
for %%a in (D E F G H I J K L M N O P Q R S T U V W Y Z) do if exist %%a:\Windows\ set OSDRIVE=%%a
if not defined OSDRIVE (echo WARNING: Failed to locate system drive, some tools may not work as expected & timeout 5) else (echo Located %OSDRIVE% as system drive ^($env:OSDRIVE^))

powershell -NoLogo -ExecutionPolicy Bypass \Scripts\Menu.ps1
