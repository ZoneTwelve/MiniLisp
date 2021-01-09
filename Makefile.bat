set code=main
set output=program.exe
if [%1]==[] goto arg1Pass
  set code=%1
:arg1Pass
if [%2]==[] goto arg2Pass
  set output=%2
:arg2Pass




echo Compile %code% then output: %output%