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
  key    = "config_ansible"
  source = "credentials/config"
  etag   = "${md5(file("credentials/config"))}"

  depends_on = ["null_resource.export_ansible_templates"]
}

resource "aws_s3_bucket_object" "jenkins-playbook" {
  bucket = "${aws_s3_bucket.config.id}"
  key    = "jenkins-playbook.yml"
  source = "ansible/playbooks/jenkins.yml"
  etag   = "${md5(file("ansible/playbooks/jenkins.yml"))}"

  depends_on = ["null_resource.export_ansible_templates"]
}

resource "aws_s3_bucket_object" "ansible-hosts" {
  bucket = "${aws_s3_bucket.config.id}"
  key    = "hosts"
  source = "ansible/hosts"
  etag   = "${md5(file("ansible/hosts"))}"

  depends_on = ["null_resource.export_ansible_templates"]
}