@echo off
title NOVA AI Server (Port 8080)
cd /d "%~dp0"

:: =============================================================
:: CONFIGURATION LAYER
:: =============================================================
set "MAIN_MODEL=Qwen3-4B-2507-Instruct-Uncensored-HauhauCS-Aggressive.gguf"

:: Performance variables
set "CONTEXT_SIZE=4096"
set "THREADS=4"
set "PORT=8080"

:: =============================================================
:: ENGINE ROUTINE
:: =============================================================
echo =============================================================
echo               INITIATING LOCAL LLM ENDPOINT SERVER
echo =============================================================
echo Model:   %MAIN_MODEL%
echo Context: %CONTEXT_SIZE% tokens
echo Threads: %THREADS% CPU cores
echo Port:    %PORT% (http://127.0.0.1:%PORT%)
echo =============================================================
echo Launching engine back-end...
echo Minimize this window to keep the server running silently.
echo.

:: Verify files exist in the current folder before launching
if not exist "llamafile.exe" (
    color 0C
    echo ERROR: llamafile.exe was not found in this folder.
    goto end
)
if not exist "%MAIN_MODEL%" (
    color 0C
    echo ERROR: Model file missing: %MAIN_MODEL%
    goto end
)

:: Run using native llamafile web server wrapper mode (unsupported flags dropped)
llamafile.exe ^
  --server ^
  -m "%MAIN_MODEL%" ^
  -c %CONTEXT_SIZE% ^
  -t %THREADS% ^
  --port %PORT%

:end
echo.
echo Server instance terminated.
pause
