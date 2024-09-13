#!/bin/bash

# THIS SETUP IS FOR LINUX BASED SYSTEM. YOU CAN ADD THIS IN THE CRONTAB

# Set the working directory to the location of your script
cd /path/to/your/project

# Function to check if Docker is running
check_docker() {
    docker info > /dev/null 2>&1
}

# Check if Docker is running
check_docker
while [ $? -ne 0 ]; do
    echo "Waiting for Docker to start..."
    sleep 5
    check_docker
done

echo "Docker is running. Starting services..."
docker-compose up -d nginx-8.2 postgres pgadmin

# add this code in your crontab
# @reboot /path/to/your/script/start_docker.sh
