@echo off
setlocal

set "NEW_PATH=%CD%"
set "PATH_EXISTS=NO"

REM Check if PYTHONPATH is initially unset or empty
if not defined PYTHONPATH (
    echo PYTHONPATH is not set. Adding the current directory...
    setx PYTHONPATH "%NEW_PATH%"
    goto UpdateComplete
)

REM PYTHONPATH is not empty; check if the new path is already in PYTHONPATH
echo Checking if the current directory is already in the PYTHONPATH...
for %%A in ("%PYTHONPATH:;=" "%") do (
    if "%%~A"=="%NEW_PATH%" (
        set "PATH_EXISTS=YES"
        goto PathExists
    )
)

REM If we're here, PATH_EXISTS is NO and we should add NEW_PATH
setx PYTHONPATH "%PYTHONPATH%;%NEW_PATH%"
echo The current directory has been added to the PYTHONPATH.
goto UpdateComplete

:PathExists
echo The current directory is already in the PYTHONPATH.

:UpdateComplete
pause
endlocal
