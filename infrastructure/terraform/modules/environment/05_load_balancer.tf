resource "aws_launch_configuration" "webserver-launch-config" {
  iam_instance_profile = var.CODEDEPLOY_INSTANCE_ROLE_PROFILE.name
  image_id             = var.AMI_ID
  instance_type        = "t2.micro"
  key_name             = aws_key_pair.aws_webserver_key.key_name
  name_prefix          = "${var.TAG_PREFIX}-webserver-launch-config"
  security_groups      = [aws_security_group.webserver_sg.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb" "load_balancer" {
  name               = "${var.TAG_PREFIX}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.elb_sg.id]
  subnets            = [aws_subnet.public_subnet_1.id, aws_subnet.public_subnet_2.id]

  tags = {
    Name = "${var.TAG_PREFIX}-load-balancer"
  }
}

resource "aws_lb_target_group" "target_group" {
  name       = "${var.TAG_PREFIX}-tg"
  depends_on = [aws_vpc.main_vpc]
  port       = var.APP_PORT
  protocol   = "HTTP"
  vpc_id     = aws_vpc.main_vpc.id
  health_check {
    interval            = 70
    path                = "/"
    port                = var.APP_PORT
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 60
    protocol            = "HTTP"
    matcher             = "200,202"
  }
}

resource "aws_lb_listener" "lb-80-listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}

resource "aws_autoscaling_group" "autoscaling_group" {
  name                 = "${var.TAG_PREFIX}-autoscaling-group"
  desired_capacity     = 2
  max_size             = 2
  min_size             = 2
  force_delete         = true
  depends_on           = [aws_lb.load_balancer]
  target_group_arns    = [aws_lb_target_group.target_group.arn]
  health_check_type    = "EC2"
  launch_configuration = aws_launch_configuration.webserver-launch-config.name
  vpc_zone_identifier  = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]

  tag {
    key                 = "Name"
    value               = "${var.TAG_PREFIX}-webserver-instance"
    propagate_at_launch = true
  }
}
