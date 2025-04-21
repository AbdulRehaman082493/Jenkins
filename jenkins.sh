#!/bin/bash

echo "🔄 Updating package list..."
sudo apt update -y

echo "📦 Installing OpenJDK 17..."
sudo apt install openjdk-17-jdk -y

echo "📦 Installing Maven (optional)..."
sudo apt install maven -y

echo "📦 Installing 'tree' utility (optional)..."
sudo apt install tree -y

echo "🔑 Adding Jenkins repository key..."
sudo mkdir -p /usr/share/keyrings
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "📦 Adding Jenkins source list..."
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/" | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "🔄 Updating package list again..."
sudo apt update -y

echo "📦 Installing Jenkins..."
sudo apt install jenkins -y

echo "🚀 Starting and enabling Jenkins service..."
sudo systemctl start jenkins
sudo systemctl enable jenkins

echo "🛡️ Configuring UFW firewall rules..."
sudo ufw allow 8080
sudo ufw allow OpenSSH
sudo ufw --force enable

echo "✅ Jenkins installation complete!"
echo "🌐 Access Jenkins at: http://<your-server-ip>:8080"
echo "🔐 Initial Admin Password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
