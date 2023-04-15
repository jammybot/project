#!/bin/bash

# Update package index and install required dependencies
sudo rm -rf /var/lib/apt/lists/* && \
echo "removed apt lists" && \
sudo apt-get update -y && \
echo "updated" && \
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common && \
echo "installed"
# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg && \

# Add Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null && \

# Update package index again and install Docker Engine
sudo apt-get update -y && \
sudo apt-get install -y docker-ce docker-ce-cli containerd.io && \
# Download Docker container and deploy on port 80
sudo docker pull jibba/web-dvwa:project && \
sudo docker run -d -it -p 80:80 jibba/web-dvwa:project