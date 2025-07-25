#!/bin/bash

set -e

echo "🔄 Updating system packages..."
sudo apt update
sudo apt upgrade -y

echo "📦 Installing dependencies..."
sudo apt install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

echo "🔐 Adding Docker’s GPG key..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | \
    sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "📄 Adding Docker APT repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) \
  signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "🔄 Updating package index again..."
sudo apt update

echo "🐳 Installing Docker Engine, CLI, and plugins..."
sudo apt install -y \
    docker-ce \
    docker-ce-cli \
    containerd.io \
    docker-buildx-plugin \
    docker-compose-plugin

echo "🚀 Enabling and starting Docker..."
sudo systemctl enable docker
sudo systemctl start docker

echo "👤 Adding current user to docker group..."
sudo usermod -aG docker $USER

echo "✅ Docker installed successfully!"
echo "🔁 Please log out and back in or run: newgrp docker"
echo "🧪 Test Docker with: docker run hello-world"
