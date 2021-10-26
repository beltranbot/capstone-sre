resource "aws_key_pair" "aws_webserver_key" {
  key_name   = "${var.TAG_PREFIX}-webserver-key"
  public_key = file(var.PATH_TO_WEBSERVER_PUBLIC_KEY)
}

resource "aws_key_pair" "aws_bastion_key" {
  key_name   = "${var.TAG_PREFIX}-bastion-key"
  public_key = file(var.PATH_TO_BASTION_PUBLIC_KEY)
}
