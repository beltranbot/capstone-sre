resource "aws_codedeploy_app" "aws_codedeploy" {
  compute_platform = "Server"
  name = "${var.APP_NAME}"

  tags = {
    Name = "${var.TAG_PREFIX}-codedeploy-app"
  }
}
