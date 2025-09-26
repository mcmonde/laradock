#!/bin/bash

# database type
db_type=postgres

# List of databases to back up+
databases=(
  db_1_here
  db_2_here
)

# Loop through the databases and create backups
for db in "${databases[@]}"; do
    docker exec -i laradock-postgres-1 pg_dump -U default "$db" > "/path/to/your/backups/${db_type}/${db}-backup-$(date +%Y-%m-%d-%H%M%S).sql"
done

# Clean up old backup files
find /path/to/your/backups/${db_type}/*.sql -mtime +3 -type f -exec rm {} \;
