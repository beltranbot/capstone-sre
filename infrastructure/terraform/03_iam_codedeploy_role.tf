data "aws_iam_policy" "AWSCodeDeployRole" {
  arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

resource "aws_iam_role" "CodeDeployServiceRole" {
  name = "${var.TAG_PREFIX}-CodeDeployServiceRole"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "codedeploy.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "${var.TAG_PREFIX}-CodeDeployServiceRole"
  }
}

resource "aws_iam_role_policy_attachment" "aws-codedeploy-role-attach" {
  role       = aws_iam_role.CodeDeployServiceRole.name
  policy_arn = data.aws_iam_policy.AWSCodeDeployRole.arn
}
