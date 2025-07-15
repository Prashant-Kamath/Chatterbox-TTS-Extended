@echo off
echo ==================================================
echo  Chatterbox TTS Extended Installer
echo ==================================================
echo.

REM Check for Python
echo Checking for Python 3.10...
python --version 2>&1 | find "3.10" > nul
if %errorlevel% neq 0 (
    echo Python 3.10 not found.
    echo Please download and install Python 3.10 from https://www.python.org/downloads/release/python-31011/
    echo Make sure to check the box "Add Python to PATH" during installation.
    pause
    exit /b 1
)
echo Python 3.10 found.
echo.

REM Create virtual environment
echo Creating virtual environment...
python -m venv .venv
if %errorlevel% neq 0 (
    echo Failed to create virtual environment.
    pause
    exit /b 1
)
echo Virtual environment created.
echo.

REM Activate virtual environment and install dependencies
echo Installing dependencies...
call .venv\\Scripts\\activate.bat
pip install --upgrade pip
pip install -r requirements.txt
if %errorlevel% neq 0 (
    echo Failed to install dependencies.
    pause
    exit /b 1
)
echo Dependencies installed.
echo.

REM Download and install FFMPEG
echo Downloading and installing FFMPEG...
mkdir bin
curl -L -o ffmpeg.zip "https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip"
tar -xf ffmpeg.zip -C bin --strip-components=1 ffmpeg-7.0-essentials_build/bin/ffmpeg.exe
del ffmpeg.zip
if %errorlevel% neq 0 (
    echo Failed to download or extract FFMPEG.
    pause
    exit /b 1
)
echo FFMPEG installed.
echo.

REM Download and install models
echo Downloading and installing models...
mkdir models
set HF_HUB_URL=https://huggingface.co/ResembleAI/chatterbox/resolve/main
curl -L -o models/ve.safetensors "%HF_HUB_URL%/ve.safetensors"
curl -L -o models/t3_cfg.safetensors "%HF_HUB_URL%/t3_cfg.safetensors"
curl -L -o models/s3gen.safetensors "%HF_HUB_URL%/s3gen.safetensors"
curl -L -o models/tokenizer.json "%HF_HUB_URL%/tokenizer.json"
curl -L -o models/conds.pt "%HF_HUB_URL%/conds.pt"
if %errorlevel% neq 0 (
    echo Failed to download models.
    pause
    exit /b 1
)
echo Models installed.
echo.

echo ==================================================
echo  Installation Complete!
echo ==================================================
echo.
echo You can now run the application by double-clicking on run.bat
pause
