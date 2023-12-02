@echo off

REM Define your container name
set container_name=laradock-postgres-1

REM Define an array of databases
set databases=doh_ppmp_local doh_davao_occidental

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

   REM Loop through the array of databases and perform backup
   for %%d in (%databases%) do (
       echo Backing up database: %%d
       docker exec %container_name% pg_dump -U default -d %%d > "%backup_folder%\%%d-%datetime%.sql"
       echo Backup completed for database: %%d
   )

   echo All backups completed.
)
