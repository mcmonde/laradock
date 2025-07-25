#!/bin/bash

set -e

echo "🔍 Removing old Docker versions..."
sudo apt remove -y docker docker-engine docker.io containerd runc
sudo apt purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "🧼 Cleaning up old Docker files..."
sudo rm -rf /var/lib/docker /var/lib/containerd /etc/docker
sudo rm -rf /etc/apt/keyrings/docker.gpg
sudo rm -f /etc/apt/sources.list.d/docker.list

echo "📦 Installing dependencies..."
sudo apt update
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

echo "🔐 Adding Docker GPG key..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "📄 Adding Docker APT repo..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "🔄 Updating APT..."
sudo apt update

echo "🐳 Installing latest Docker..."
sudo apt install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

echo "🚀 Starting Docker..."
sudo systemctl enable docker
sudo systemctl start docker

echo "👤 Adding user to docker group..."
sudo usermod -aG docker $USER

echo "✅ Docker reinstalled successfully!"
echo "🔁 Please log out and back in or run: newgrp docker"
echo "🧪 Test Docker with: docker run hello-world"
