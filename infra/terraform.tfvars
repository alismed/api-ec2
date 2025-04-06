region          = "us-east-1"
ami             = "ami-02a53b0d62d37a757"
instance_type   = "t2.micro"
key_name        = "terraform-keypair"
vpc_id          = "vpc-0bbb42131ef1b5ad7"
public_key_path = "~/.ssh/id_rsa_ec2.pub"
subnet_ids      = ["subnet-0c56f6efbe2fec4de", "subnet-0ac630be8257bccc9"]

tags = {
  Name        = "api-ec2"
  Environment = "Development"
  Department  = "IT"
  Owner       = "John Doe"
}