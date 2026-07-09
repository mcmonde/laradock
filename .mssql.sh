#!/bin/bash

# Configuration
CONTAINER_NAME="laradock-mssql-1" # Check with 'docker ps'
DB_NAME="archiving"
BACKUP_DIR="/var/opt/mssql/data/backups" # Path INSIDE container
HOST_DIR="./backups" # Path ON YOUR HOST machine
DATE=$(date +%Y%m%d_%H%M%S)
FILE_NAME="$DB_NAME-$DATE.bak"

# 1. Create backup directory on host if it doesn't exist
mkdir -p $HOST_DIR

# 2. Run the SQL Command via docker exec
docker exec $CONTAINER_NAME /opt/mssql-tools/bin/sqlcmd \
   -S localhost -U sa -P 'YourPassword123' \
   -Q "BACKUP DATABASE [$DB_NAME] TO DISK = N'$BACKUP_DIR/$FILE_NAME' WITH NOFORMAT, NOINIT, NAME = '$DB_NAME-Full', SKIP, NOREWIND, NOUNLOAD, STATS = 10"

# 3. Inform user
echo "Backup created: $HOST_DIR/$FILE_NAME"
