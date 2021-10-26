# sg for load balancer
resource "aws_security_group" "elb_sg" {
  name        = "${var.TAG_PREFIX}-lb-sg"
  description = "Segurity group for the load balancer"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.TAG_PREFIX}-load-balancer-sg"
  }
}

# sg for load balancer
resource "aws_security_group" "bastion_sg" {
  name        = "${var.TAG_PREFIX}-bastion-sg"
  description = "Segurity group for the bastion"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.TAG_PREFIX}-bastion-sg"
  }
}

# sg for webserver
resource "aws_security_group" "webserver_sg" {
  name        = "${var.TAG_PREFIX}-webserver-sg"
  description = "Security group for the webserver"
  vpc_id      = aws_vpc.main_vpc.id

  ingress {
    from_port       = var.APP_PORT
    to_port         = var.APP_PORT
    protocol        = "tcp"
    description     = "app port access"
    security_groups = [aws_security_group.elb_sg.id]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    description     = "ssh"
    security_groups = [aws_security_group.elb_sg.id, aws_security_group.bastion_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.TAG_PREFIX}-webserver-sg"
  }
}
