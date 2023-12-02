@echo off
cd /d "C:\Users\Asus\Desktop\Infosoft Projects\laradock"
:CHECK_DOCKER
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo Waiting for Docker to start...
    timeout /t 5 >nul
    goto CHECK_DOCKER
)

echo Docker is running. Starting services...
docker-compose up -d nginx postgres pgadmin

REM ADD THIS TO YOUR TASK SCHEDULER
