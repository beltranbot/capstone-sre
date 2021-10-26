# define autoscaling configuration policy
resource "aws_autoscaling_policy" "cpu_policy_scaleup" {
  name                   = "${var.TAG_PREFIX}-cpu-policy-scaleup"
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 300
  policy_type            = "SimpleScaling"
}

# define cloud watch monitoring
resource "aws_cloudwatch_metric_alarm" "cpu-alarm-scaleup" {
  alarm_name          = "${var.TAG_PREFIX}-cpu-alarm-scaleup"
  alarm_description   = "alarm once cpu usage increases"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 20

  dimensions = {
    "AutoScalingGroupName" : aws_autoscaling_group.autoscaling_group.name
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.cpu_policy_scaleup.arn]
}

# define auto descaling policy
resource "aws_autoscaling_policy" "cpu_policy_scaledown" {
  name                   = "${var.TAG_PREFIX}-cpu-policy-scaledown"
  autoscaling_group_name = aws_autoscaling_group.autoscaling_group.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = -1
  cooldown               = 300
  policy_type            = "SimpleScaling"
}

# define descaling cloud watch
resource "aws_cloudwatch_metric_alarm" "cpu-alarm-scaledown" {
  alarm_name          = "${var.TAG_PREFIX}-cpu-alarm-scaledown"
  alarm_description   = "alarm once cpu usage decreases"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 10

  dimensions = {
    "AutoScalingGroupName" = aws_autoscaling_group.autoscaling_group.arn
  }
  actions_enabled = true
  alarm_actions   = [aws_autoscaling_policy.cpu_policy_scaledown.arn]
}
