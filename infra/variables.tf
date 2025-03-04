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

variable "key_name" {
  description = "The name of the key pair to use"
  type        = string
  default     = "terraform-keypair"
}

variable "public_key_path" {
  description = "The path to the public key file"
  type        = string
  default     = "~/.ssh/id_ed25519.pub"
}