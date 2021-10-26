resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.BUCKET_NAME
  acl    = "private"

  force_destroy = true

  tags = {
    Name        = "${var.TAG_PREFIX}-s3-bucket"
    Environment = "${var.TAG_PREFIX}"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket_access_block" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls   = true
  block_public_policy = true
  restrict_public_buckets = true
  ignore_public_acls = true
}
