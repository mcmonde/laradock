@echo off
setlocal enabledelayedexpansion

REM Define your container name
set container_name=laradock-postgres-1

REM Get the current date and time
for /f "delims=" %%a in ('wmic OS Get localdatetime ^| find "."') do set datetime=%%a

REM Remove unwanted characters from the date and time
set datetime=%datetime:~0,14%

REM Remove spaces from the datetime string
set datetime=%datetime: =%
set "backup_folder=C:\Users\Asus\Desktop\Infosoft Projects\laradock\.backup"

REM Use `docker ps` to list running containers and filter by container name
for /f "tokens=1" %%i in ('docker ps --filter "name=%container_name%" --format "{{.ID}}"') do (
    set container_id=%%i
)

REM Check if a container ID was found
if "%container_id%" == "" (
   echo Container "%container_name%" not found or not running.
) else (
   echo Container ID for "%container_name%" is %container_id%

   REM Retrieve the list of databases
   for /f "delims=" %%d in ('docker exec %container_name% psql -U default -d postgres -t -c "SELECT datname FROM pg_database WHERE datistemplate = false;"') do (
       set database=%%d
       REM Trim spaces from the database name
       set database=!database: =!
       if not "!database!" == "" (
           echo Backing up database: !database!
           docker exec %container_name% pg_dump -U default -d !database! > "%backup_folder%\!database!-%datetime%.sql"
           echo Backup completed for database: !database!
       )
   )

   echo All backups completed.
)
