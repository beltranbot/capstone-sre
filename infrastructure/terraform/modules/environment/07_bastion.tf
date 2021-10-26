data "aws_ami" "amazon_ami" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.*-x86_64-gp2"]
  }
}

resource "aws_instance" "bastion" {
  ami             = data.aws_ami.amazon_ami.id
  instance_type   = "t2.micro"
  key_name        = aws_key_pair.aws_bastion_key.key_name
  subnet_id       = aws_subnet.public_subnet_1.id
  vpc_security_group_ids = [aws_security_group.bastion_sg.id]

  tags = {
    Name = "${var.TAG_PREFIX}-bastion"
  }
}
