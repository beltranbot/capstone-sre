resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.TAG_PREFIX}-db-subnet-group"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]

  tags = {
    Name = "${var.TAG_PREFIX}-db-subnet-group"
  }
}

resource "aws_security_group" "rds_security_group" {
  vpc_id      = aws_vpc.main_vpc.id
  name        = "${var.TAG_PREFIX}-rds-sg"
  description = "security group for the RDS"

  tags = {
    Name = "${var.TAG_PREFIX}-rds-sg"
  }
}

# add webserver security group to rds sg
resource "aws_security_group_rule" "allow_app_instances_to_rds" {
  type                     = "ingress"
  from_port                = var.DATABASE_PORT
  to_port                  = var.DATABASE_PORT
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.webserver_sg.id
  security_group_id        = aws_security_group.rds_security_group.id
}

resource "aws_db_instance" "rds" {
  instance_class         = "db.t2.micro"
  identifier             = var.DATABASE_IDENTIFIER
  snapshot_identifier    = var.SNAPSHOT_IDENTIFIER
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds_security_group.id]
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
}
