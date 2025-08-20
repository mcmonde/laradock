#!/bin/bash

#database type
db_type=mysql

# List of databases to back up
databases=(
    hris_db
)

# Loop through the databases and create backups
for db in "${databases[@]}"; do
    #docker exec -i laradock_mysql_1 mysqldump "$db" > "/home/laradock/.backups/${db_type}/${db}-backup-$(date +%Y-%m-%d-%H%M%S).sql"
    docker exec -i laradock-mariadb-1 mariadb-dump "$db" > "/home/laradock/.backups/${db_type}/${db}-backup-$(date +%Y-%m-%d-%H%M%S).sql"
done

# Clean up old backup files
find /home/laradock/.backups/${db_type}/*.sql -mtime +3 -type f -exec rm {} \;
