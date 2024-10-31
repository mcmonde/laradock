#!/bin/bash
source /home/admin/website/laradock/.mariadb
docker exec -i laradock_mariadb_1 mariadb-dump --user=$DB_USERNAME --password=$DB_PASSWORD wp_davao_city_staging > "/home/admin/website/laradock/.backups/wp_davao_city_staging-backup-`date +%Y-%m-%d-%H:%M:%S`.sql"
find /home/admin/website/laradock/.backups/*.sql -mtime +3 -type f -exec rm {} \;
