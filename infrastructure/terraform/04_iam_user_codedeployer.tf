resource "aws_iam_user" "codedeployer" {
  name = "${var.TAG_PREFIX}-codedeployer"
  force_destroy = true
  tags = {
    Name = "${var.TAG_PREFIX}-codedeployer"
  }
}

data "aws_iam_policy" "AmazonS3FullAccesss" {
  arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

data "aws_iam_policy" "AWSCodeDeployDeployerAccess" {
  arn = "arn:aws:iam::aws:policy/AWSCodeDeployDeployerAccess"
}

resource "aws_iam_user_policy_attachment" "amazon-s3-full-access-attach" {
  user       = aws_iam_user.codedeployer.name
  policy_arn = data.aws_iam_policy.AmazonS3FullAccesss.arn
}

resource "aws_iam_user_policy_attachment" "codedeploy-deployer-access-attach" {
  user       = aws_iam_user.codedeployer.name
  policy_arn = data.aws_iam_policy.AWSCodeDeployDeployerAccess.arn
}
