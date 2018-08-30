resource "aws_s3_bucket" "config" {
  bucket = "tf-aws-configuration-bucket"
  acl    = "private"
  region = "${var.region}"

  tags {
    Name        = "Bucket for configuration files"
    Environment = "Deployment"
  }
}

resource "aws_s3_bucket_object" "master_server_id_rsa" {
  bucket = "${aws_s3_bucket.config.id}"
  key    = "master_server_id_rsa"
  source = "credentials/master_server_id_rsa"
  etag   = "${md5(file("credentials/master_server_id_rsa"))}"
}

resource "aws_s3_bucket_object" "master_server_id_rsa-pub" {
  bucket = "${aws_s3_bucket.config.id}"
  key    = "master_server_id_rsa.pub"
  source = "credentials/master_server_id_rsa.pub"
  etag   = "${md5(file("credentials/master_server_id_rsa.pub"))}"
}

resource "aws_s3_bucket_object" "ssh_config" {
  bucket = "${aws_s3_bucket.config.id}"
  key    = "config-ansible"
  source = "credentials/config"
  etag   = "${md5(file("credentials/config"))}"

  depends_on = ["null_resource.export_ansible_templates"]
}