data "aws_iam_policy" "AmazonEC2RoleforAWSCodeDeploy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforAWSCodeDeploy"
}

data "aws_iam_policy" "AutoScalingNotificationAccessRole" {
  arn = "arn:aws:iam::aws:policy/service-role/AutoScalingNotificationAccessRole"
}

resource "aws_iam_role" "CodeDeployInstanceRole" {
  name = "${var.TAG_PREFIX}-CodeDeployInstanceRole"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : "sts:AssumeRole",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Effect" : "Allow",
        "Sid" : ""
      }
    ]
  })

  tags = {
    Name = "${var.TAG_PREFIX}-CodeDeployInstanceRole"
  }
}

resource "aws_iam_role_policy_attachment" "ec2-role-for-aws-codedeploy-attach" {
  role       = aws_iam_role.CodeDeployInstanceRole.name
  policy_arn = data.aws_iam_policy.AmazonEC2RoleforAWSCodeDeploy.arn
}

resource "aws_iam_role_policy_attachment" "autoscaling-notification-access-policy-attach" {
  role       = aws_iam_role.CodeDeployInstanceRole.name
  policy_arn = data.aws_iam_policy.AutoScalingNotificationAccessRole.arn
}

resource "aws_iam_instance_profile" "CodeDeployInstanceProfile" {
  name = "${var.TAG_PREFIX}-CodeDeployInstanceRole"
  role = aws_iam_role.CodeDeployInstanceRole.name
}
