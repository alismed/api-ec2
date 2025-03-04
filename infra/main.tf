terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.89.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_security_group" "backend" {
  name        = "backend"
  description = "http access"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_key_pair" "keypair" {
  key_name   = "terraform-keypair"
  public_key = file("~/.ssh/id_ed25519.pub")
}

resource "aws_instance" "ec2" {
  ami                    = "ami-02a53b0d62d37a757"
  instance_type          = "t2.micro"
  user_data              = file("user_data.sh")
  key_name               = aws_key_pair.keypair.key_name
  vpc_security_group_ids = [aws_security_group.backend.id]
}

output "public_ip" {
  value = aws_instance.ec2.public_ip
}