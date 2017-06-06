@echo off
REM Builds the Zombies SML app and makes an executable Windows batch file
if not exist "%cd%\bin" mkdir %cd%\bin
call sml.bat build.sml

(
  echo @echo off
  echo call sml.bat @SMLcmdname=\$0 @SMLload="%cd%\bin\.heapimg" "%%1"
) > %cd%\bin\zombies.bat
