@echo off
setlocal EnableDelayedExpansion

:: Set your source and destination paths (no trailing backslashes)
set "SRC=C:\data\ateliers\261116-ws291"
set "DST=C:\ws291\261116_ws291"
set "ZIP_FILE=C:\data\ateliers\261116-atelier_291\2_r_ready\261116_ws291.zip"
set "SEVEN_ZIP=C:\Program Files\7-Zip\7z.exe"

:: Add your folders and files directly inside the parentheses below (one per line)
for %%i in (
    "01_install.R"
    "cycombine-app.R"
    "cytobatchflagr-app.R"
    "cytonorm-app.R"
    "fcsmerge-app.R"
    "cyCombine-app"
    "CytoBatchFlagR"
    "cytonorm-app"
    "fcsmerge-app"
) do (
    if exist "%SRC%\%%~i\" (
        :: DIRECTORY: Copies the contents of the folder directly into %DST% (no subfolder created)
        echo [DIR]  Copying directory with architecture: %%~i...
        xcopy "%SRC%\%%~i" "%DST%\%%~i" /E /I /Y >nul
    ) else if exist "%SRC%\%%~i" (
        :: FILE: Copies the file directly into %DST%, ignoring any relative subfolder paths
        echo [FILE] Copying %%~nxi...
        xcopy "%SRC%\%%~i" "%DST%\" /Y >nul
    ) else (
        echo [SKIP] Not found: %%~i
    )
)

echo.
echo Copying complete.
echo.
echo Preparing ZIP archive...

:: Check if 7-Zip exists
if not exist "%SEVEN_ZIP%" (
    echo [ERROR] 7-Zip executable not found at "%SEVEN_ZIP%".
    goto :end
)

:: If the target ZIP already exists, find the next available numerical suffix and rename it
if exist "%ZIP_FILE%" (
    echo Target ZIP already exists. Finding next available numerical suffix...

    for %%f in ("%ZIP_FILE%") do (
        set "FILE_DIR=%%~dpf"
        set "FILE_NAME=%%~nf"
        set "FILE_EXT=%%~xf"
    )

    set "n=1"
    :CheckSuffix
    set "NEW_ZIP=!FILE_DIR!!FILE_NAME!_!n!!FILE_EXT!"
    if exist "!NEW_ZIP!" (
        set /a n+=1
        goto CheckSuffix
    )

    move "%ZIP_FILE%" "!NEW_ZIP!" >nul
    echo Renamed existing archive to: "!NEW_ZIP!"
)

:: Create the new ZIP archive
echo Creating new ZIP archive...
"%SEVEN_ZIP%" a -tzip "%ZIP_FILE%" "%DST%\*" >nul
echo ZIP archive created successfully: "%ZIP_FILE%"

:end
echo.
echo Done!
pause
