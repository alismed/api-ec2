#!/bin/bash

sudo sudo su
yum update -y
yum install -y docker
service docker start
usermod -a -G docker ec2-user

docker run -p 80:8080 -d alismed/api-ec2