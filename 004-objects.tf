resource "aws_s3_bucket" "config" {
  bucket = "configuration-bucket"
  acl    = "private"

  tags {
    Name        = "Bucket for configuration files"
    Environment = "Deployment"
  }
}