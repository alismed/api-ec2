resource "aws_instance" "ec2" {
  count                  = length(var.subnet_ids)
  subnet_id              = var.subnet_ids[count.index]
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = aws_key_pair.keypair.key_name
  vpc_security_group_ids = [aws_security_group.backend.id]
  user_data              = file(var.user_data)
  associate_public_ip_address = true
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name

  tags = merge(
    var.tags,
    {
      Name = "api-ec2-${count.index + 1}"
    }
  )
}