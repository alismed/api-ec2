#!/bin/bash

# Enable detailed logging
set -e
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Update system
sudo yum update -y

# Reinstall SSM agent
sudo yum remove -y amazon-ssm-agent
sudo yum install -y amazon-ssm-agent
sudo systemctl enable amazon-ssm-agent
sudo systemctl start amazon-ssm-agent
sudo systemctl status amazon-ssm-agent

# Install docker
sudo yum install -y docker
sudo systemctl enable docker
sudo systemctl start docker
sudo usermod -a -G docker ec2-user

# Run container
sudo docker pull alismed/api-ec2:latest
sudo docker run \
  -p 80:8080 \
  --restart always \
  -d \
  --name api-container \
  --log-driver json-file \
  --log-opt max-size=100m \
  alismed/api-ec2:latest

# Verify container is running
sleep 10
echo "Container Status:"
sudo docker ps
echo "Container Logs:"
sudo docker logs api-container
echo "Testing local endpoint:"
curl -v http://localhost/
