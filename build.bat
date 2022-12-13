@echo off
set AHK_COMPILER_DIR=C:\Program Files\AutoHotkey\Compiler

set COMPILER="%AHK_COMPILER_DIR%\Ahk2Exe.exe"
set COMPILER_BIN="%AHK_COMPILER_DIR%\Unicode 64-bit.bin"


if exist target (
    rmdir target /S /Q
)
md target
xcopy img target\img /S /Y /I

echo start compiler
%COMPILER% /in captain.ahk /out target\captain.exe /base %COMPILER_BIN%
%COMPILER% /in member.ahk /out target\member.exe /base %COMPILER_BIN%

echo start package
cd target
:: win10在2018年之后自带了tar命令
tar acvf release.zip --exclude release.zip *