#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Define your PostgreSQL container name and an array of database names
CONTAINER_NAME="laradock-postgres-1"
DATABASES=("db_name_1" "db_name_2")
FOLDER_NAME="folder_name_here"

# Get the current date and time for the backup filename
CURRENT_DATE=$(date +"%Y%m%d_%H%M%S")

# Loop through the array of databases and perform backup
for DATABASE_NAME in "${DATABASES[@]}"; do
  BACKUP_FILENAME="$SCRIPT_DIR/$FOLDER_NAME/$DATABASE_NAME-backup-$CURRENT_DATE.sql"

  # Run the pg_dump command inside the PostgreSQL container
  docker exec -i $CONTAINER_NAME pg_dump -U default $DATABASE_NAME > $BACKUP_FILENAME

  # Check if the backup was successful
  if [ $? -eq 0 ]; then
    echo "Backup completed successfully for database $DATABASE_NAME. File: $BACKUP_FILENAME"
  else
    echo "Backup failed for database $DATABASE_NAME."
  fi
done

# sample shorten script

# docker exec -i laradock-postgres-1 pg_dump -U default doh_prod > "/home/doh/Desktop/efiling/laradock/.backups/doh_prod-backup-`date +%Y-%m-%d-%H:%M:%S`.sql"
# find /home/doh/Desktop/efiling/laradock/.backups/*.sql -mtime +3 -type f -exec rm {} \;

# sample cron script

# 0 0 * * * root /home/doh/Desktop/efiling/laradock/postgres.sh >> /home/doh/Desktop/efiling/laradock/.backups/cron_logs.txt 2>&1
