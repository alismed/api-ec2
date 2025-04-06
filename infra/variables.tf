variable "region" {
  description = "The AWS region to deploy in"
  type        = string
  default     = "us-east-1"
}

variable "ami" {
  description = "The AMI to use for the instance"
  type        = string
  default     = "ami-02a53b0d62d37a757"
}

variable "instance_type" {
  description = "The type of instance to use"
  type        = string
  default     = "t2.micro"
}

variable "vpc_id" {
  description = "The VPC ID to launch the instance in"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "The name of the key pair to use"
  type        = string
  default     = "terraform-keypair"
}

variable "public_key_path" {
  description = "The path to the public key file"
  type        = string
  default     = "~/.ssh/id_rsa_ec2"
}

variable "user_data" {
  description = "The user data script to run on instance launch"
  type        = string
  default     = "user_data.sh"
}

variable "tags" {
  description = "Tags to apply to the resources"
  type        = map(string)
  default = {
    Name        = "api-ec2"
    Environment = "Development"
    Department  = "IT"
    Owner       = "John Doe"
  }
}

variable "subnet_ids" {
  description = "List of subnet IDs for the infrastructure"
  type        = list(string)
}

variable "allowed_cidr_blocks" {
  description = "List of CIDR blocks allowed for ingress"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "http_port" {
  description = "HTTP port for the ALB and EC2 instances"
  type        = number
  default     = 80
}

variable "ssh_port" {
  description = "SSH port for the EC2 instances"
  type        = number
  default     = 22
}