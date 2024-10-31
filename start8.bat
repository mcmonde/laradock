@echo off

setlocal enabledelayedexpansion

rem Define the ports you want to find and kill

docker compose down

set "ports=5432"

for %%p in (%ports%) do (
    echo Checking port %%p...

    rem Find the process ID (PID) using the specified port
    for /f "tokens=5" %%a in ('netstat -ano ^| findstr :%%p') do (
        set "pid=%%a"
        echo Found process !pid! using port %%p.

        rem Kill the process using the PID
        taskkill /PID !pid! /F
        echo Process !pid! has been killed.
    )
)

echo Done.
endlocal

cd /d "C:\Users\Asus\Desktop\Infosoft Projects\laradock"
:CHECK_DOCKER
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo Waiting for Docker to start...
    timeout /t 5 >nul
    goto CHECK_DOCKER
)

echo Docker is running. Starting services...
docker-compose up -d nginx-8.2 postgres pgadmin

REM ADD THIS TO YOUR TASK SCHEDULER
